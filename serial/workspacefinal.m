clear all
close all
clc

d1=80;
a3=155;
a4=153;
d5=33;
dE=65;

x1=(-100*pi)/180:pi/18:pi/2;    %from -100 to 90 degrees with an increment size of pi/18
x2=0:pi/18:pi;                  %from 0 to 180 degrees with an increment size of pi/18
x3=-pi+((10*pi)/180):pi/5:0;     %from 0 to 170 degrees with an increment size of pi/5
x4=-pi:pi/2:0;                  %from -180 to 0 degrees with an increment size of pi/3
x5=0;                           %set to 0 as its rotation won’t affect the position of
                                %the end effector, just its orientation.

xposition=zeros(360,360);
yposition=zeros(360,360);
zposition=zeros(360,360);

[~,lengthofx1]=size(x1);
[~,lengthofx2]=size(x2);
[~,lengthofx3]=size(x3);
[~,lengthofx4]=size(x4);


for i=1:lengthofx1
    for j=1:lengthofx2
        for k=1:lengthofx3
            for l=1:1%lengthofx4
                xposition=cos(x1(1,i))*(a4*cos(x2(1,j) + x3(1,k)) + a3*cos(x2(1,j)) - d5*sin(x2(1,j) + x3(1,k) + x4(1,l)) - dE*sin(x2(1,j) + x3(1,k) + x4(1,l)));
                yposition=sin(x1(1,i))*(a4*cos(x2(1,j) + x3(1,k)) + a3*cos(x2(1,j)) - d5*sin(x2(1,j) + x3(1,k) + x4(1,l)) - dE*sin(x2(1,j) + x3(1,k) + x4(1,l)));
                zposition=d1 + a4*sin(x2(1,j) + x3(1,k)) + a3*sin(x2(1,j)) + d5*cos(x2(1,j) + x3(1,k) + x4(1,l)) + dE*cos(x2(1,j) + x3(1,k) + x4(1,l));
                figure (1)
                plot(xposition,yposition,'.');
                hold on
                title('workspace xy') ; xlabel('x (mm)') ; ylabel('y (mm)'); zlabel('z (mm)') ;
                
                figure (2)
                plot(xposition,zposition,'.');
                hold on
                title('workspace xz') ; xlabel('x (mm)') ; ylabel('z (mm)');
                
                figure (3)
                plot(yposition,zposition,'.');
                hold on
                title('workspace yz') ; xlabel('y (mm)') ; ylabel('z (mm)');
                
                figure (4)
                plot3(xposition,yposition,zposition,'.');
                hold on
                title('workspace xyz') ; xlabel('x (mm)') ; ylabel('y (mm)'); zlabel('z (mm)') ;
            end
        end
    end
end
axis equal