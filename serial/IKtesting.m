d1=0;
a3=155;
a4=153;
d5=33;
dE=65;

x4=185;
z4=133+(d5+dE)-d1; %needs to be fixed when zd is determined



C=180-acos((x4^2+z4^2+a3^2-a4^2)/(2*a3*sqrt(x4^2+z4^2+a3)))-acos((a4^2+a3^2-x4^2-z4^2)/(2*a4*a3));

theta2=acos((x4^2+z4^2+a3^2-a4^2)/(2*a3*sqrt(x4^2+z4^2+a3)))+atan(z4/x4);
theta3=acos((a4^2+a3^2-x4^2-z4^2)/(2*a4*a3));
%theta4=C+atan(x4/z4)+90-F

theta2*180/pi
theta3*180/pi