clc
clear all
close all

%in degrees, sin(60)=0.86602540378
sin60deg=0.86602540378;
centerb=0;

centerpx=-140;
centerpy=30;
rotationp=0;
%given dimensions
LAb=290;
LBb=290;
LCb=290;
LAp=130;
LBp=130;
LCp=130;

Al1=170;
Bl1=170;
Cl1=170;
Al2=130;
Bl2=130;
Cl2=130;

bb=2*LAb*sin60deg;
bp=2*LAp*sin60deg;

lbb=sqrt(LAb^2-(bb/2)^2);
lbp=sqrt(LAp^2-(bp/2)^2);

%base coordinates
Abx=centerb-bb/2;
Aby=centerb-lbb;
Bbx=centerb;
Bby=centerb+LBb;
Cbx=centerb+bb/2;
Cby=centerb-lbb;

%platform coordinates
rotationprad=rotationp*pi/180;
Bpoffset = rotationprad+90*pi/180;
Apoffset = Bpoffset+120*pi/180;
Cpoffset = Bpoffset+240*pi/180;

Apx=centerpx + LAp * cos(Apoffset);
Apy=centerpy + LAp * sin(Apoffset);
Bpx=centerpx + LBp * cos(Bpoffset);
Bpy=centerpy + LBp * sin(Bpoffset);
Cpx=centerpx + LCp * cos(Cpoffset);
Cpy=centerpy + LCp * sin(Cpoffset);

%plotting

%plot base
line([Abx,Bbx],[Aby,Bby])
hold on
line([Bbx,Cbx],[Bby,Cby])
hold on
line([Cbx,Abx],[Cby,Aby])
hold on

%plot platform
line([Apx,Bpx],[Apy,Bpy])
hold on
line([Bpx,Cpx],[Bpy,Cpy])
hold on
line([Cpx,Apx],[Cpy,Apy])
hold on

%arm positions

Al3=sqrt((Abx-Apx)^2+(Aby-Apy)^2);
Bl3=sqrt((Bbx-Bpx)^2+(Bby-Bpy)^2);
Cl3=sqrt((Cbx-Cpx)^2+(Cby-Cpy)^2);

C11=acos((Al2^2+Al1^2+Al3^2)/(2*Al2*Al1))*180/pi;
B11=acos((Al2^2+Al1^2+Al3^2)/(2*Al2*Al3))*180/pi;
A11=acos((Al2^2+Al1^2+Al3^2)/(2*Al1*Al3))*180/pi;

C21=acos((Bl2^2+Bl1^2+Bl3^2)/(2*Bl2*Bl1))*180/pi;
B21=acos((Bl2^2+Bl1^2+Bl3^2)/(2*Bl2*Bl3))*180/pi;
A21=acos((Bl2^2+Bl1^2+Bl3^2)/(2*Bl1*Bl3))*180/pi;

C31=acos((Cl2^2+Cl1^2+Cl3^2)/(2*Cl2*Cl1))*180/pi;
B31=acos((Cl2^2+Cl1^2+Cl3^2)/(2*Cl2*Cl3))*180/pi;
A31=acos((Cl2^2+Cl1^2+Cl3^2)/(2*Cl1*Cl3))*180/pi;

%A
[ Aintersect1,Aintersect2 ] = calculate_intersects( Abx,Aby,Apx,Apy,Al2,Al1 );
[ Bintersect1,Bintersect2 ] = calculate_intersects( Bbx,Bby,Bpx,Bpy,Bl2,Bl1 );
[ Cintersect1,Cintersect2 ] = calculate_intersects( Cbx,Cby,Cpx,Cpy,Cl2,Cl1 );


%plot arms
line([Abx,Aintersect1(1)],[Aby,Aintersect1(2)])
hold on
line([Aintersect1(1),Apx],[Aintersect1(2),Apy])
hold on
line([Abx,Aintersect2(1)],[Aby,Aintersect2(2)])
hold on
line([Aintersect2(1),Apx],[Aintersect2(2),Apy])
hold on

line([Bbx,Bintersect1(1)],[Bby,Bintersect1(2)])
hold on
line([Bintersect1(1),Bpx],[Bintersect1(2),Bpy])
hold on
line([Bbx,Bintersect2(1)],[Bby,Bintersect2(2)])
hold on
line([Bintersect2(1),Bpx],[Bintersect2(2),Bpy])
hold on

line([Cbx,Cintersect1(1)],[Cby,Cintersect1(2)])
hold on
line([Cintersect1(1),Cpx],[Cintersect1(2),Cpy])
hold on
line([Cbx,Cintersect2(1)],[Cby,Cintersect2(2)])
hold on
line([Cintersect2(1),Cpx],[Cintersect2(2),Cpy])
hold on

axis equal

%calculate theta's
difference11=abs(Aintersect1(2)-Aby);
difference12=abs(Aintersect2(2)-Aby);
%theta 1
if Aintersect1(2)<Aby
    theta11=360-asin(difference11/Al1)*180/pi;
else
    theta11=asin(difference11/Al1)*180/pi;
end

if Aintersect2(1)>Abx
    theta12=asin(difference12/Al1)*180/pi;
else
    theta12=180-asin(difference12/Al1)*180/pi;
end
%theta 2
difference21=abs(Bintersect1(2)-Bby);
difference22=abs(Bintersect2(2)-Bby);

if Bintersect1(1)<Bbx
    theta21=180+asin(difference21/Bl1)*180/pi;
else
    theta21=360-asin(difference21/Bl1)*180/pi;
end
if Bintersect2(1)>Bbx
    theta22=360-asin(difference22/Bl1)*180/pi;
else
    theta22=180+asin(difference22/Bl1)*180/pi;
end
%theta 3
difference31=abs(Cintersect1(2)-Cby);
difference32=abs(Cintersect2(2)-Cby);

if Cintersect1(1)<Cbx
    theta31=180-asin(difference31/Cl1)*180/pi;
else
    theta31=asin(difference31/Cl1)*180/pi;
end
if Cintersect2(2)>Cby
    theta32=180-asin(difference32/Cl1)*180/pi;
else
    theta32=180+asin(difference32/Cl1)*180/pi;
end

theta11
theta12
theta21
theta22
theta31
theta32





