%%%%%%%%%%%%% Alex Thompson %%%%%%%%%%%

clear all
close all
clc

%% A series of joint angles
% different positions of x
theta1=-80;       %from -100  to 90 degrees
theta2=90;     %from 0     to 180 degrees
theta3=-90;    %from 0     to -170 degrees
theta4=-180;    %from -180  to 0 degrees
theta5=50;       %from 0     to 180 degrees

q1 = theta1*pi/180;
q2 = theta2*pi/180;
q3 = theta3*pi/180;
q4 = theta4*pi/180;
q5 = theta5*pi/180;

%% Link Lengths
d1 = 80;
a3 = 155;
a4 = 153;
d5 = 33;
dE = 65;

%% Plot the robotic arm
x0 = 0;
y0 = 0;
z0 = d1;

x1 = 0 ;
y1 = 0 ;
z1 = d1 ;

x2 =  a3*cos(q1)*cos(q2);
y2 =  a3*cos(q2)*sin(q1);
z2 =  d1 + a3*sin(q2);

x3= cos(q1)*(a4*cos(q2 + q3) + a3*cos(q2));
y3= sin(q1)*(a4*cos(q2 + q3) + a3*cos(q2));
z3= d1 + a4*sin(q2 + q3) + a3*sin(q2);

x4 =  cos(q1)*(a4*cos(q2 + q3) + a3*cos(q2) - d5*sin(q2 + q3 + q4));
y4 = sin(q1)*(a4*cos(q2 + q3) + a3*cos(q2) - d5*sin(q2 + q3 + q4));
z4 =   d1 + a4*sin(q2 + q3) + a3*sin(q2) + d5*cos(q2 + q3 + q4);

xe =  cos(q1)*(a4*cos(q2 + q3) + a3*cos(q2) - (d5+dE)*sin(q2 + q3 + q4))
ye =  sin(q1)*(a4*cos(q2 + q3) + a3*cos(q2) - (d5+dE)*sin(q2 + q3 + q4))
ze =  d1 + a4*sin(q2 + q3) + a3*sin(q2) + (d5+dE)*cos(q2 + q3 + q4)

i=1;
    xx = [ x0(i); x1(i); x2(i); x3(i); x4(i); xe(i) ];
    yy = [ y0(i); y1(i); y2(i); y3(i); y4(i); ye(i) ];
    zz = [ z0(i); z1(i); z2(i); z3(i); z4(i); ze(i) ];
    
    plot3(xx,yy,zz,'ko-','Linewidth',4)
    axis equal
    hold on
    title('arm simulation'); xlabel('x (mm)') ; ylabel('y (mm)'); zlabel('z (mm)');




 