%%%%DBFdelay
%%���㲨���ϳ�ʱ�ĸ�ͨ���ӳ���
%%%%%%%%%%%%%%%%%%%%%
%�޸�˵������ǰ��������Ὣ��С�������һ��Ϊ0���������Ǵ���ģ���Ϊ����ż���ɨ�������£�Ӧ�ý������ⲿͳһ�����������ڲ��Ĺ�һ��Ҫȡ��
%%%%%%%%%%%%%%%%%%%%%
function [realtao,tao]=DBFdelay_New(NUM,F,delaystep,Pitch)
% F:����
% NUM��ͨ����
% delaystep: �ӳپ���
% Pitch ��Ԫ��࣬��λmm
close all;
tao=ones(1,NUM);    %��ͨ���ӳ������飬���жԳ���
c=0.00154; %�������٣���λmm/ns


if(rem(NUM,2)==1)
    taonum=(NUM-1)/2;
    odd=1;
    even=0;
else
    taonum=NUM/2;
    odd=0;
    even=1;
end
R = ones(1,taonum+odd) ; 
if(odd==1)
    R(1)=F;
end
xdis=zeros(1,taonum+odd);
if(odd==1)
    xdis(1)=0;
end

for n=1+odd:taonum+odd
    xdis(n)=(n-1+even*0.5)*Pitch;
    R(n)=(F^2+(xdis(n))^2)^(1/2);
end
taohalf=ones(1,taonum+odd);
if(odd==1)
    taohalf(1)=0;
end

for k=1+odd:taonum+odd
    if(k==1)
        taohalf(k)=(R(k)-F)/c;
    else
        taohalf(k)=(R(k)-R(k-1))/c+taohalf(k-1);
    end
end
Dis=zeros(1,NUM);
Dis(1:taonum+odd)=fliplr(xdis);
Dis(taonum+1+odd:NUM)=xdis(1+odd:taonum+odd);
Rn=zeros(1,NUM);
Rn(1:taonum+odd)=fliplr(R);
Rn(taonum+1+odd:NUM)=R(1+odd:taonum+odd);
tao(1:taonum+odd)=fliplr(taohalf);
tao(taonum+1+odd:NUM)=taohalf(1+odd:taonum+odd);
%tao=max(tao)-tao;
plot(tao);grid on;hold on;title('��ȷ��ʱ');
% figure;plot(Rn);grid on;


realtao=zeros(1,NUM);
error=zeros(1,NUM);
for i=1:NUM  
    realtao(i)=delaystep*round(tao(i)/delaystep);
    error(i)=(tao(i)-realtao(i))*c;
    if(i<=NUM/2)
        xerror(i)=-error(i)/Rn(i)*Dis(i);
    else
        xerror(i)=error(i)/Rn(i)*Dis(i);
    end
        yerror(i)=error(i)/Rn(i)*F;
end
    plot(realtao,'r');grid on;
%   figure; plot(error);grid on;
  figure;plot(xerror,yerror,'o');grid on;hold on;
    plot(xerror,yerror,'r');
  
end