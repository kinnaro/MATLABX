clear all
clc

a1 = readtable('S:\二次实验\用到的V\100.csv');
a2 = readtable('S:\二次实验\用到的V\102.csv');
a3 = readtable('S:\二次实验\用到的V\104.csv');
a4 = readtable('S:\二次实验\用到的V\105.csv');
a5 = readtable('S:\二次实验\用到的V\106.csv');
a6 = readtable('S:\二次实验\用到的V\107.csv');
a7 = readtable('S:\二次实验\用到的V\109.csv');
a8 = readtable('S:\二次实验\用到的V\111.csv');
a9 = readtable('S:\二次实验\用到的V\114.csv');
a10 = readtable('S:\二次实验\用到的V\116.csv');
a11 = readtable('S:\二次实验\用到的V\118.csv');
a12 = readtable('S:\二次实验\用到的V\119.csv');
a13 = readtable('S:\二次实验\用到的V\121.csv');
a14 = readtable('S:\二次实验\用到的V\123.csv');
a15 = readtable('S:\二次实验\用到的V\124.csv');
a16 = readtable('S:\二次实验\用到的V\200.csv');
a17 = readtable('S:\二次实验\用到的V\201.csv');
a18 = readtable('S:\二次实验\用到的V\202.csv');
a19 = readtable('S:\二次实验\用到的V\203.csv');
a20 = readtable('S:\二次实验\用到的V\205.csv');
a21 = readtable('S:\二次实验\用到的V\207.csv');
a22 = readtable('S:\二次实验\用到的V\208.csv');
a23 = readtable('S:\二次实验\用到的V\209.csv');
a24 = readtable('S:\二次实验\用到的V\210.csv');
a25 = readtable('S:\二次实验\用到的V\213.csv');
a26 = readtable('S:\二次实验\用到的V\214.csv');
a27 = readtable('S:\二次实验\用到的V\215.csv');
a28 = readtable('S:\二次实验\用到的V\217.csv');
a29 = readtable('S:\二次实验\用到的V\219.csv');
a30 = readtable('S:\二次实验\用到的V\221.csv');
a31 = readtable('S:\二次实验\用到的V\223.csv');
a32 = readtable('S:\二次实验\用到的V\228.csv');
a33 = readtable('S:\二次实验\用到的V\230.csv');
a34 = readtable('S:\二次实验\用到的V\231.csv');
a35 = readtable('S:\二次实验\用到的V\233.csv');
a36 = readtable('S:\二次实验\用到的V\234.csv');

A = [a1;a2;a3;a4;a5;a6;a7;a8;a9;a10;a11;a12;a13;a14;a15;a16;a17;a18;a19;a20;a21;a22;a23;a24;a25;a26;a27;a28;a29;a30;a31;a32;a33;a34;a35;a36];
writetable(A,'S:\二次实验\用到的V\二次实验V-有RR.csv','Delimiter',',','QuoteStrings',true);