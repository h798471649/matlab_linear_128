%%�����ӳ���


Pitch=0.3; %mm;

Num=32;  %  array Num;
C=1.540e-3;  %mm/ns

T=0.0003;   %300us
Ts=(1000/50)*1e-9;  %50MHz

DeltaF=0.0154 %mm ,50Mbps sampling rate

t=[-T/2:Ts:T/2];





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%��ż����һ���ġ�
for j=1:1:16384
    F=Ts*j*1e9*C/2;
    for i=1:1:16
        %Delay_Interlace(j,i)= round((sqrt(R*R+(R+F)*(R+F)-2*R*(R+F)*cos(beta*abs(i-(Num+1)/2)))-F)/C/Ts/1e9);
        
        Delay_Interlace(j,i) = round((sqrt(F*F+ (i-(Num+1)/2)*Pitch*(i-(Num+1)/2)*Pitch)-F)/C/Ts/1e9);
                                
    end
end



%% ����ͣ�ı�Ϊ1���1��Ϊ����ͣ��



PACE =zeros(16384,16);
for j=2:1:16384
    for i=1:1:16
        if(Delay_Interlace(j,i) == Delay_Interlace(j-1,i))  %% �ӳ��ޱ仯������
            PACE(j,i)= 1;
        else                                                %% �ӳ��б仯��ͣ��
             PACE(j,i)= 0;           
        end
    end
end

for i=1:1:16
    PACE(1,i)= 1;   
end


%%%%%����ͣ���ļ�

fid2=fopen('Dynamic_Start_Delay.txt','w+');
fid=fopen('Dynamic_Focus.txt','w+');

%%%%%��������16ͨ��ͣ���ļ�
for j=1:1:16384
    for i=9:1:16
       fprintf(fid,'%X',PACE(j,i));      
    end
    fprintf(fid,'\r\n');
end

%%%%%��������16ͨ��ͣ���ļ�
for j=1:1:16384
    for i=1:1:8
       fprintf(fid,'%X',PACE(j,i));      
    end
    fprintf(fid,'\r\n');
end


%%%%%��������15ͨ����ʼ�ӳ��ļ�
for i=9:1:16
    fprintf(fid2,'%04X',Delay_Interlace(1,i));   
    
end
fprintf(fid2,'\r\n');

%%%%%��������16ͨ����ʼ�ӳ��ļ�
for i=1:1:8
    fprintf(fid2,'%04X',Delay_Interlace(1,i));   
    
end
fprintf(fid2,'\r\n');

fclose(fid);
fclose(fid2)


