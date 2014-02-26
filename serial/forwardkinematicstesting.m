
theta1=-80;       %from -100  to 90 degrees
theta2=90;     %from 0     to 180 degrees
theta3=-90;    %from 0     to -170 degrees
theta4=-180;    %from -180  to 0 degrees
theta5=50;       %from 0     to 180 degrees


x1 = theta1*pi/180;
x2 = theta2*pi/180;
x3 = theta3*pi/180;
x4 = theta4*pi/180;
x5 = theta5*pi/180;

d1=80;
a3=155;
a4=153;
d5=33;
dE=65;

T1=[cos(x1) -sin(x1) 0 0;sin(x1) cos(x1) 0 0;0 0 1 d1;0 0 0 1];
T2=[cos(x2) -sin(x2) 0 0;0 0 -1 0;sin(x2) cos(x2) 0 0;0 0 0 1];
T3=[cos(x3) -sin(x3) 0 a3;sin(x3) cos(x3) 0 0;0 0 1 0;0 0 0 1];
T4=[cos(x4) -sin(x4) 0 a4;sin(x4) cos(x4) 0 0;0 0 1 0;0 0 0 1];
T5=[cos(x5) -sin(x5) 0 0;0 0 1 d5;-sin(x5) -cos(x5) 0 0;0 0 0 1];
TE=[1 0 0 0; 0 1 0 0;0 0 1 dE;0 0 0 1];
T1E= T1*T2*T3*T4*T5*TE




%plot3([0;0;0],[T1E(1,4);T1E(2,4);T1E(3,4)],[2;0;0],'g');
%hold on
%plot3([0;0;0],[T1E(1,4);T1E(2,4);T1E(3,4)],[0;1;0]);
%hold on
%plot3(5,5,6,'m');


