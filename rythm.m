% Rhythm estimation
% This program uses signals from separeg.m
% with the file fetus.mat
% Uses: f0cor.m
pulsemin=50; %==== beats per mn
pulsemax=300; %==== beats per mn
%===== oversampling rati
R=2;
maxcor_apriori=0.25;
[F_mother, corr_mother]=...
f0cor(xp,Fe,R,maxcor_apriori,pulsemin/60,pulsemax/60);
[F_fetus, corr_fetus]=...
f0cor(cf,Fe,R,maxcor_apriori,pulsemin/60,pulsemax/60);
%===== displaying the results
disp('*****************************')
fprintf('* Pulses (mother): %5.2f\n',60*F_mother);
fprintf('* Pulses (fetus) : %5.2f\n',60*F_fetus);
disp('*****************************')
lagminM=fix(60*Fe*R/pulsemax);
lagminF=fix(60*Fe*R/pulsemax);
MinCM=min(corr_mother);
LCM=length(corr_mother); 
MaxCM=max(corr_mother);
subplot(211);
plot((lagminM:LCM+lagminM-1)/R,corr_mother)
grid; hold on;
plot(Fe/F_mother*[1 1]+1,[min(corr_mother) MaxCM],':');
hold off
%=====
MinCF=min(corr_fetus); MaxCF=max(corr_fetus);
subplot(212);
plot((lagminF:length(corr_fetus)+lagminF-1)/R,...
corr_fetus)
grid; hold on;
plot(Fe/F_fetus*[1 1]+1,[MinCF MaxCF],':');
hold off