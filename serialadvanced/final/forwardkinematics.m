syms x1 x2 x3 x4 x5 a3 a4 d1 d5 dE
T1=[cos(x1) -sin(x1) 0 0;sin(x1) cos(x1) 0 0;0 0 1 d1;0 0 0 1];
T2=[cos(x2) -sin(x2) 0 0;0 0 -1 0;sin(x2) cos(x2) 0 0;0 0 0 1];
T3=[cos(x3) -sin(x3) 0 a3;sin(x3) cos(x3) 0 0;0 0 1 0;0 0 0 1];
T4=[cos(x4) -sin(x4) 0 a4;sin(x4) cos(x4) 0 0;0 0 1 0;0 0 0 1];
T5=[cos(x5) -sin(x5) 0 0;0 0 1 d5;-sin(x5) -cos(x5) 0 0;0 0 0 1];
TE=[1 0 0 0; 0 1 0 0;0 0 1 dE;0 0 0 1];
T1E= T1*T2*T3*T4*T5*TE
simplify(T1E)
