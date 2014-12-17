import SendCommands
#import serial

class Options:
    pass

options  = Options()
options.outputDevice = "COM4"
options.baud = 115200

#listOfNumbers = [ 1, 2 , 3 ]

############## Reset position #################
# Base
SendCommands.execute( ["#5 P2000","#0 P1550 T5000","wait 1"], options )
# Shoulder
SendCommands.execute( ["#5 P2000","#1 P2500 T5000","wait 1"], options )
# Elbow
SendCommands.execute( ["#5 P2000","#2 P2500 T5000","wait 1"], options )
# Wrist
SendCommands.execute( ["#5 P2000","#3 P1200 T5000","wait 1"], options )
# Wrist roll
SendCommands.execute( ["#5 P2000","#4 P1550 T5000","wait 1"], options )
# Grip
SendCommands.execute( ["#5 P2000","#5 P2000 T5000","wait 1"], options )


################## Tests ######################
#SendCommands.execute( ["#1 P750","#2 P1000 T3000","wait 1"], options )
#SendCommands.execute( ["#1 P750","#1 P2250 T10", "wait 1"], options )


############## Change position #################
#SendCommands.execute( ["#1 P2000","#2 P1400","#3 P1900","#4 P1200","wait 2"], options )
#SendCommands.execute( ["#2 P1260","#5 P2000 #6 P500 ","wait 1"], options )
#SendCommands.execute( ["#6 P2500","wait 1"], options )
#SendCommands.execute( ["#2 P1500","#1 P1600 #3 P1200 #4 P1500 ","wait 2"], options )
#SendCommands.execute( ["#1 P1600","#1 P800 #3 P800"], options )

##################example 1###################
#SendCommands.execute( ["#5 P2000","#0 P2400 #1 P2400 #2 P2400 #3 P2400 #4 P2400 #5 P2400 T5000","wait 5"], options )
#SendCommands.execute( ["#5 P2000","#0 P600 #1 P600 #2 P600 #3 P1500 #4 P600 #5 P600 T5000","wait 5"], options )
#SendCommands.execute( ["#5 P2000","#1 P2500 #2 P2000 #3 P600 #4 P600 #5 P600 T5000","wait 5"], options )
#SendCommands.execute( ["#5 P2000","#0 P1550 T2000","wait 2"], options )
#SendCommands.execute( ["#5 P2000","#0 P1550 T2000","wait 0"], options )
#SendCommands.execute( ["#5 P2000","#3 P1250 #4 P1550 #5 P2000 T1000","wait 1"], options )
#SendCommands.execute( ["#5 P2000","#0 P1550 #1 P2500 #2 P2500 #3 P1200 #4 P1550 #5 P2000 T1000","wait 2"], options )

#ssc32.close()