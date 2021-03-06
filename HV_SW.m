


fid=fopen('HV_SW.txt','w+');  %高压开关，128线，64开关位置
TX=[1,17,33,49,65,81,97,113,
    2,18,34,50,66,82,98,114,
    3,19,35,51,67,83,99,115,
    4,20,36,52,68,84,100,116,
    5,21,37,53,69,85,101,117,
    6,22,38,54,70,86,102,118,
    7,23,39,55,71,87,103,119,
    8,24,40,56,72,88,104,120,
    9,25,41,57,73,89,105,121,
    10,26,42,58,74,90,106,122,
    11,27,43,59,75,91,107,123,
    12,28,44,60,76,92,108,124,
    13,29,45,61,77,93,109,125,
    14,30,46,62,78,94,110,126,
    15,31,47,63,79,95,111,127,
    16,32,48,64,80,96,112,128];

TX=TX';

	
  %顺序：中心16通道 128个高压开关配置，奇偶线一样；外周16通道 128个高压开关配置，奇偶线一样。  总共256线
  %发射15通道，接收16通道， 高压开关需要全部打开。
  %偶数线发射左边15通道，接收全通道；奇数线发射右边15通道，接收全通道；
%中心16通道
for i=-7:1:120
    SW_PHY=[i:1:i+15];
    SW_VIR=zeros(1,128);
    for j=1:1:128
       for k=1:1:16
            if(SW_PHY(k)== TX(j)) 
                SW_VIR(j)=1;
            end
       end
       fprintf(fid,'%d',SW_VIR(j));
    end
    fprintf(fid,'\r\n');
end


%外周16通道

for i=-7:1:120
    SW_PHY=[i-8:1:i-1,i+16:1:i+23];
    SW_VIR=zeros(1,128);
    for j=1:1:128
       for k=1:1:16
            if(SW_PHY(k)== TX(j)) 
                SW_VIR(j)=1;
            end
       end
       fprintf(fid,'%d',SW_VIR(j));
    end
    fprintf(fid,'\r\n');
end


fclose(fid);


