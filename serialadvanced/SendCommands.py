#!/usr/bin/python

## M. Studley, 7 Sept, 2009, Advanced Robotics Course
##
## Description : when given the name of a file containing commands for
## the Lynxmotion SSC-32 servo-motor controller, open a connection to the
## SSC-32, and send each of the commands in the text file one after
## another.
##
## Text files are in this format:
##    
##     % comments
##     #1 PO n  % set the position offset for channel 1 to n
##     wait n % float n = number of seconds
##     % move one servo
##     #5 P1600 S750
##     wait 10
##     % move two servos as a group
##     #5 P1600 #10 P750 T2500

usage = """\n\n\nSendCommands <text_file> : read commands from text_file and send to lynxmotion arm"
 
=================================================================
Servo Move or Group Move.
# <ch> P <pw> S <spd> ... # <ch> P <pw> S <spd> T <time>
<ch> 	Channel number in decimal, 0-31
<pw> 	Pulse width in microseconds, 500-2500
<spd> 	Movement speed in uS per second for one channel (Optional)
<time> 	Time in mS for the entire move, affects all channels,
        65535 max (Optional)

see http://www.lynxmotion.com/images/html/build136.htm#comform
=================================================================
"""

import serial, time, re, sys
from optparse import OptionParser

SERVO_MIN   = 0
SERVO_MAX   = 31
PW_MIN      = 500
PW_MAX      = 2500
S_MIN       = 0
S_MAX       = 65535
TIME_MIN    = 0
TIME_MAX    = 65535
OFFSET_MIN  = -100
OFFSET_MAX  = 100

class SSC32_Parser(object):
    comment   = r"\%.*"
    wait      = r"(WAIT)\s*([\d\.]+)"
    command   = r"#(\d+)\s*(P)?\s*(\d+)?\s*(S)?\s*(\d+)?\s*(T)?\s*(\d+)?"
    first_cmd = r"#(\d+)\s*(P)\s*(\d+)\s*$"
    offset    = r"#(\d+)\s*PO\s*(-*\d+)\s*$"

    COMMENT = 0 
    WAIT    = 1
    COMMAND = 2
    BLANK   = 3
    OFFSET  = 4

    #COMMENT, WAIT, COMMAND, BLANK, OFFSET = range(5)
    
    def __init__(self):
        self.regexp_comment = re.compile(SSC32_Parser.comment, re.IGNORECASE)
        self.regexp_wait = re.compile(SSC32_Parser.wait, re.IGNORECASE)
        self.regexp_command = re.compile(SSC32_Parser.command, re.IGNORECASE)
        self.regexp_firstCmd = re.compile(SSC32_Parser.first_cmd, re.IGNORECASE)
        self.regexp_offset = re.compile(SSC32_Parser.offset, re.IGNORECASE)
        self.isFirstCommand = True

    def valid_servo(self, servo):
        if int(servo) not in range(SERVO_MIN, SERVO_MAX+1):
            raise Exception ("%s refers to servo number %s, should be in range %d - %d"%(text, servo, SERVO_MIN, SERVO_MAX))
            
            
    def check_offset_parameters(self, text, servo, offset):
        self.valid_servo(servo)
        if int(offset) not in range(OFFSET_MIN, OFFSET_MAX+1):
            print ( text, servo, offset )
            raise Exception ("%s has servo offset (%d) outside range [%d:%d]"%(text, int(offset), OFFSET_MIN, OFFSET_MAX))
        
    def check_command_parameters(self, text, servo, p, s, t): 
        self.valid_servo(servo)    
        if not p:
            raise Exception ("%s has no pulse width parameter for servo %s"%(text, servo))
        elif p and int(p) not in range(PW_MIN, PW_MAX+1):
            raise Exception ("%s refers to P value %s, should be in range %d - %d"%(text, p, PW_MIN, PW_MAX))
        elif s and int(s) not in range(S_MIN, S_MAX+1):
            raise Exception ("%s refers to P value %s, should be in range %d - %d"%(text, p, S_MIN, S_MAX))
        elif t and int(t) not in range(TIME_MIN, TIME_MAX+1):
            raise Exception ("%s refers to T value %s, should be in range %d - %d"%(text, t, TIME_MIN, TIME_MAX))
                       
    def valid_command(self, text):
        """Commands must contain at least one of the pattern
        #<number in range 0-31>, P<number in range 500-2500>
        This pattern may further include a speed command S<0-65535> 
        A group can contain at 1 - 31 occurance of this pattern,
        and at most one terminal T<0-65535> time command"""
        if text.find("#") == -1:
            return False
        if text.find("PO") != -1:
            return False
        commands = text.split("#")
        timeValCount = 0
        for c in commands[1:]:
            try:
                servo, p, s, t = self.regexp_command.match("#"+c).group(1,3,5,7)
                self.check_command_parameters(text, servo, p, s, t)
                if t is not None:
                    timeValCount += 1
            except AttributeError as e:
                raise Exception ("%s is a badly-formed command"%text)
        if timeValCount > 1:
            raise Exception ("%s can only have 1 time value"%text)
        return True


    def parse(self, text):        
        """check whether command is well-formed, chop into tokens.
        Barf if necessary"""
        self.result = None
        # remove whitespace and convert to uppercase
        text = text.strip()

        if not text:
            self.result = SSC32_Parser.BLANK
            return

        isComment = self.regexp_comment.match(text)
        if isComment:
            self.result = SSC32_Parser.COMMENT
            return 

        isWait = self.regexp_wait.match(text)
        if isWait:
            self.result = SSC32_Parser.WAIT
            howLong = isWait.group(2)
            return howLong

        if self.valid_command(text):
            if self.isFirstCommand:
                ok = self.regexp_firstCmd.match(text)
                if ok == None:
                    raise Exception ("First command issued must be in the form '#<ch> P <pw>', not %s"%text)
                self.isFirstCommand = False
            self.result = SSC32_Parser.COMMAND                        
            return text
        
        isOffset = self.regexp_offset.match(text)
        if isOffset:
            self.check_offset_parameters(text, isOffset.group(1), isOffset.group(2))
            self.result = SSC32_Parser.OFFSET
            return text
        # if we get this far, then it was neither command, comment or wait        
        raise Exception ("'%s' doesn't make sense!  Please consult documentation!"%text)
       
class SSC32(object):
    SERIAL_PORT = "/dev/ttyS0"
    BAUDRATE    = 115200
    LEN_BUFFER  = 80

    def __init__(self, device, baud):
        self.setup(device, baud)
        
    def setup(self, device, baud):
        try:
            self.interface = serial.Serial(device, baud, timeout=None )
        except Exception as e:
            raise Exception ("No arm seems to be attached to %s"%device)
        
    def send(self, text):
        try:
            btext=text.encode()
            self.interface.write(btext)
            self.interface.write(b'\r')
        except Exception as e:
            raise Exception ("Unable to write to arm")
        
    def receive(self):
        return self.interface.read(SSC32.LEN_BUFFER)

    def tearDown(self):
        self.interface.close()

    def __del__(self):
        self.tearDown()

def sleep(howLong):
    print ( "waiting", howLong )
    time.sleep(float(howLong))

def failWith(message):
    print (  message )
    sys.exit(1)

def readFile(fileName):
    fp = open(fileName, 'rt')
    text = fp.readlines()
    fp.close()
    return text

def getArgs():
    parser = OptionParser(usage = usage)
    parser.add_option("-d", "--device", dest="outputDevice", default=SSC32.SERIAL_PORT,
                  help="Device to send output to (default : %s)"%SSC32.SERIAL_PORT, metavar="DEVICE")
    parser.add_option("-b", "--baud", dest="baud", default=SSC32.BAUDRATE,
                  help="baud rate (default : %s)"%SSC32.BAUDRATE, metavar="BAUD")    
    return parser.parse_args()

def execute(text, options):
    parser = SSC32_Parser()
    try:
        ssc32 = SSC32(options.outputDevice, options.baud)
    except Exception as e:
        failWith(e)
    for line in text:
        # check it's sane
        try:
            toExecute = parser.parse(line)
        except Exception as e:
            print ( help )
            failWith(e)

        if parser.result == SSC32_Parser.WAIT:
            sleep(toExecute)
            
        elif parser.result == SSC32_Parser.COMMAND or \
             parser.result == SSC32_Parser.OFFSET:
            # make it upper case
            toExecute = toExecute.upper()
            print ( "Executing", toExecute )
            ssc32.send(toExecute)
            #print ( ssc32.receive()

def main():
    try:
        options, args = getArgs()
        fileName = args[0]
    except Exception:
        print ( usage )
        failWith("No file name supplied")
    commandText = readFile(fileName)
    execute(commandText, options)


if __name__ == "__main__":
    main()

