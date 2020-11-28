load fetus.dat
xp=fetus(:,8)-mean(fetus(:,8));
xv=fetus(:,2)-mean(fetus(:,2));
N=length(xv);
Fe = 300
%===== estimation of h
L=20; % L causal
M=3; % M anticausal
Xv=xv(L:N-M);
col=xp(L+M:N); lig=xp(M+L:-1:1);
Xp=toeplitz(col,lig);
h=Xp \ Xv; % resolution
cf=Xv-Xp*h; % fetal heart beats
Nmax=1000; indx=[1:Nmax];
subplot(311); plot(xp(indx)); grid
subplot(312); plot(xv(indx)); grid
subplot(313); plot([zeros(L-1,1);cf(L:Nmax)]); 
grid