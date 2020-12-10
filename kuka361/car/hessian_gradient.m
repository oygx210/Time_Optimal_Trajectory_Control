function [h, gf] = hessian_gradient(x,b0,s_phi,Mv,Cv,Dv,R,angle,d_phi)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global Mu FN Wf;
gf = zeros(size(x,1),1);
h = zeros(size(x,1),size(x,1));
A = zeros(size(x,1)*3/4,size(x,1));

gf(1)=-(s_phi(3)-s_phi(2))/(x(5)^(1/2)*x(1)^(1/2)+1)-(s_phi(2)-s_phi(1))/(x(1)^(1/2)*b0^(1/2)+1);
gf(2)=0;
gf(3)=-2*x(3)/((Mu*FN)^2-(x(3)^2+x(4)^2))-2*x(3)/((Wf*Mu*FN)^2-x(3)^2);
gf(4)=-2*x(4)/((Mu*FN)^2-(x(3)^2+x(4)^2));
h(1,1)=(s_phi(3)-s_phi(2))/(2*(x(5)^(1/2)*x(1)^(1/2)+1)^2)*x(5)^(1/2)*x(1)^(-1/2)+...
    (s_phi(2)-s_phi(1))/(2*(x(1)^(1/2)*b0^(1/2)+1)^2)*b0^(1/2)*x(1)^(-1/2);
h(3,3)=-2/((Mu*FN)^2-(x(3)^2+x(4)^2))+4*x(3)^2/(((Mu*FN)^2-(x(3)^2+x(4)^2))^2)...
    -2/(((Wf*Mu*FN)^2-x(3))^2)+4*x(3)/((Wf*Mu*FN)^2-x(3)^2)^2;
h(4,4)=-2/((Mu*FN)^2-(x(3)^2+x(4)^2))+4*x(4)^2/(((Mu*FN)^2-(x(3)^2+x(4)^2))^2);
h(3,4)=4*x(3)*x(4)/(((Mu*FN)^2-(x(3)^2+x(4)^2))^2);
h(4,3)=h(3,4);
h(1,5)=(s_phi(3)-s_phi(2))/(2*(x(5)^(1/2)*x(1)^(1/2)+1)^2)*x(1)^(1/2)*x(5)^(-1/2);
h(5,1)=h(1,5);
for k=2:size(x)/4-1
    gf((k-1)*4+1)= -(s_phi(k+2)-s_phi(k+1))/((x(k*4+1)^(1/2)*x((k-1)*4+1)^(1/2))+1)...
        -(s_phi(k+1)-s_phi(k))/((x((k-1)*4+1)^(1/2)*(x((k-1)*4-3))^(1/2))+1);
    gf((k-1)*4+2)=0;
    gf((k-1)*4+3)=-2*x((k-1)*4+3)/((Mu*FN)^2-(x((k-1)*4+3)^2+x((k-1)*4+4)^2))-2*x((k-1)*4+3)/((Wf*Mu*FN)^2-x((k-1)*4+3)^2);
    gf((k-1)*4+4)=-2*x((k-1)*4+4)/((Mu*FN)^2-(x((k-1)*4+3)^2+x((k-1)*4+4)^2));
    
    h((k-1)*4+1,(k-1)*4+1)=(s_phi(k+2)-s_phi(k+1))/(2*((x((k-1)*4+5)^(1/2)*x((k-1)*4+1)^(1/2))+1)^2)*(x((k-1)*4+5))^(1/2)*(x((k-1)*4+1))^(-1/2)+...
        (s_phi(k+1)-s_phi(k))/(2*((x((k-1)*4+1)^(1/2)*(x((k-1)*4-3))^(1/2))+1)^2)*(x((k-1)*4-3))^(1/2)*(x((k-1)*4+1))^(-1/2);
    h((k-1)*4+3,(k-1)*4+3)=-2/((Mu*FN)^2-(x((k-1)*4+3)^2+x((k-1)*4+4)^2))+4*(x((k-1)*4+3))^2/(((Mu*FN)^2-(x((k-1)*4+3)^2+x((k-1)*4+4)^2))^2)...
        -2/((Wf*Mu*FN)^2-x((k-1)*4+3)^2)+4*x((k-1)*4+3)/((Wf*Mu*FN)^2-x((k-1)*4+3)^2)^2;
    h((k-1)*4+4,(k-1)*4+4)=-2/((Mu*FN)^2-(x((k-1)*4+3)^2+x((k-1)*4+4)^2))+4*(x((k-1)*4+4))^2/(((Mu*FN)^2-(x((k-1)*4+3)^2+x((k-1)*4+4)^2))^2);
    h((k-1)*4+3,(k-1)*4+4)=4*(x((k-1)*4+4)*x((k-1)*4+3)/(((Mu*FN)^2-(x((k-1)*4+3)^2+x((k-1)*4+4)^2))^2);
    h((k-1)*4+4,(k-1)*4+3)=h((k-1)*4+3,(k-1)*4+4);
    h((k-1)*4+5,(k-1)*4+1)=(s_phi(k+2)-s_phi(k+1))/(2*((x((k-1)*4+5)^(1/2)*x((k-1)*4+1)^(1/2))+1)^2)*(x((k-1)*4+1))^(1/2)*(x((k-1)*4+5))^(-1/2);
    h((k-1)*4+1,(k-1)*4+5)=h((k-1)*4+5,(k-1)*4+1);
end
gf(end-3)=-(s_phi(end)-s_phi(end-1))/((x(end-3)^(1/2)*x(end-7)^(1/2))+1);
gf(end-2)=0;
gf(end-1)=-2*x(end-1)/((Mu*FN)^2-(x(end-1)^2+x(end)^2))-2*x(end-1)/((Wf*Mu*FN)^2-x(end-1)^2);
gf(end)=-2*x(end)/((Mu*FN)^2-(x(end-1)^2+x(end)^2));

h(end-3,end-3)=(s_phi(end)-s_phi(end-1))/(2*((x(end-3)^(1/2)*x(end-7)^(1/2))+1)^2)*(x(end-7))^(1/2)*(x(end-3))^(-1/2);
h(end-1,end-1)=-2/((Mu*FN)^2-((x(end-1))^2+(x(end))^2))+4*(x(end-1))^2/(((Mu*FN)^2-((x(end-1))^2+(x(end))^2))^2)...
    -1/((Wf*Mu*FN)^2-x(end-1)^2)+4*x(end-1)/((Wf*Mu*FN)^2-x(end-1)^2)^2;
h(end,end)=-2/((Mu*FN)^2-((x(end-1))^2+(x(end))^2))+4*(x(end))^2/(((Mu*FN)^2-((x(end-1))^2+(x(end))^2))^2);
h(end-1,end)=4*(x(end-1)*x(end))/(((Mu*FN)^2-((x(end-1))^2+(x(end))^2))^2);
h(end,end-1)=h(end-1,end);


A(1:2,2:4)=[Mv(1),R(1)];
A(3,1:2)=[-1,2*d_phi(1)];
for k=2:size(x,1)/4
    A((k-1)*3+1:(k-1)*3+2,(k-1)*4+2:(k-1)*4+4)=[Mv(k),R(k)];
    A((k-1)*3+3,(k-1)*4+1:(k-1)*4+2)=[-1,2*d_phi(k)];
    A((k-1)*3+3,(k-1)*4-3)=1;
end
end
