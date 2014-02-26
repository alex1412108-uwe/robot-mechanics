clc
clear all
close all

%in degrees, sin(60)=0.86602540378
sin60deg=0.86602540378;
centerbx=0;
centerby=0;

centerpx=0;
centerpy=0;

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
Abx=centerbx-bb/2;
Aby=centerby-lbb;
Bbx=centerbx;
Bby=centerby+LBb;
Cbx=centerbx+bb/2;
Cby=centerby-lbb;

resolution=10;
resolutionz=1;
rotationp = 0;
rotationprad=rotationp*pi/180;
i=0;
j=0;
k=0;
%arrayx=zeros(600,650,90);
%arrayy=zeros(600,650,90);
%arrayz=zeros(600,650,90);
for rotationprad= 0:resolutionz*pi/180:90*pi/180
    j=0;
for centerpx = -300:resolution:300
    i=0;
    for centerpy = -250:resolution:400
        %platform coordinates

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
        Al1=sqrt((Apx-Abx)^2+(Apy-Aby)^2);
        Al2=sqrt((Bpx-Bbx)^2+(Bpy-Bby)^2);
        Al3=sqrt((Cpx-Cbx)^2+(Cpy-Cby)^2);
        
        
        if (Al1<40) | (Al1>300) | (Al2<40) | (Al2>300) | (Al3<40) | (Al3>300)
            centerpy=centerpy+resolution;
        else
            %arrayx(i,j,k)=centerpx;
            %arrayy(i,j,k)=centerpy;
            %arrayz(i,j,k)=k;
            plot3(centerpx,centerpy,k,'.')
            hold on
        end
        i=i+1;
    end
    j=j+1;
end
k=k+1;
end
%plot3(arrayx,arrayy,arrayz,'.')
%hold on
axis equal
%plot base
%line([Abx,Bbx],[Aby,Bby])
%hold on
%line([Bbx,Cbx],[Bby,Cby])
%hold on
%line([Cbx,Abx],[Cby,Aby])
%hold on






