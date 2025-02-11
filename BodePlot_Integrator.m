%% PLL OPEN and CLOSED LOOP TRANSFER FUNCTIONS

%clear;
%clc;


%% PARAMETERS

% IIR Filter Coefficients
A = 0.021823956197987285;
B = 0.95635208760402546;

% GAIN 
q = 0;
G = 2^(-q);


N=256*1024;                         % number of points
Fs = 338000000/6;                  % sampling frequency
Ts = 1/Fs;


%% TRANSFER FUNCTIONS BY STAGES

% Phase Detector Comparator
b1=[0 1];                         % nominator
a1=[1];                           % denominator

% Phase Detector LPF (IIR)
b2=[A  A];   
a2=[1 -B];                        
 
% GAIN
b3=[G];
a3=[1];
 
% NCO
b4=[1];
a4=[1 -1];


%% OPEN LOOP TRANSFER FUNCTION
%nom=conv(b1,b2);    nom  =conv(nom,  b3);  nom  =conv(nom,  b4);
%denom=conv(a1,a2);  denom=conv(denom,a3);  denom=conv(denom,a4);
nom=conv(b3,b4);   % nom  =conv(nom,  b4);
denom=conv(a3,a4); % denom=conv(denom,a4);


% PLOTTING
%[Hol,F]=freqz(nom,denom,N,Fs); Hol=abs(Hol); dBol=20*log10(Hol); % 
%plot(F,dBol, 'r-');

HOL=tf(nom,denom,Ts); % Open   Loop Transfer Function
[Hol,F]=freqz(nom,denom,N,Fs); Hol=abs(Hol); dBol=20*log10(Hol);
plot(F,dBol, 'r-');

HCL=HOL/(1-HOL);      % Closed Loop Transfer Function
[Hcl,F]=freqz(nom,(denom-nom),N,Fs); Hcl=abs(Hcl); dBcl=20*log10(Hcl);
plot(F,dBcl, 'b-');

% PLOTTING  ( for multiplot see ">help plot"

plot(2*pi*F,dBol, 'r-', 2*pi*F, dBcl, 'b--');
