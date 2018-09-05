a1 = readtable('S:\MIT相关文件\MIT数据采样点\MIT_SingleWaveR\118.csv');
a2 = readtable('S:\MIT相关文件\MIT数据采样点\MIT_SingleWaveR\124.csv');
a3 = readtable('S:\MIT相关文件\MIT数据采样点\MIT_SingleWaveR\207.csv');
a4 = readtable('S:\MIT相关文件\MIT数据采样点\MIT_SingleWaveR\212.csv');
a5 = readtable('S:\MIT相关文件\MIT数据采样点\MIT_SingleWaveR\231.csv');
a6 = readtable('S:\MIT相关文件\MIT数据采样点\MIT_SingleWaveR\232.csv');
% a7 = readtable('S:\MIT相关文件\MIT数据采样点\MIT_SingleWaveR\106.csv');


% A = [a1;a2;a3;a4;a5;a6;a7;a8;a9;a10;a11;a12;a13;a14;a15;a16;a17;a18;a19;a20;a21;a22;a23;a24;a25;a26;a27;a28;a29;a30;a31;a32;a33;a34;a35;a36;a37;a38;a39'];
A = [a1;a2;a3;a4;a5;a6];
writetable(A,'S:\MIT相关文件\MIT数据采样点\MIT_SingleWaveR\三次实验R-有RR.csv','Delimiter',',','QuoteStrings',true);


