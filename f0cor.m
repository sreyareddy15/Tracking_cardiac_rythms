function [F0,corr]=f0cor(sn,Fs,R,thr,Fmin,Fmax)
%!==================================================!
%! SYNOPSIS: [F0,corr]=F0COR(sn,Fs,R,thr,Fmin,Fmax) !
%! sn = signal from which the freq. is extracted !
%! Fs = sampling frequency (Hz) !
%! R = oversampling factor !
%! thr = threshold !
%! Fmin = min. frequeny (Hz) !
%! otherwise Fmin=2*Fs/longueur(sn); !
%! Fmax = max. frequency (Hz) !
%! otherwise Fmax=Fs/2-Fmin; !
%! F0 = fundamental frequency (Hz) !
%! corr = correlation sequence !
%!==================================================!
sn=interp(sn,R); 
Fs=R*Fs;
N=length(sn); 
sn=sn(:); 
sn=sn-mean(sn);
lagmin=fix(Fs/Fmax); 
lagmax=fix(Fs/Fmin);
corr=zeros(1,lagmax-lagmin+1);
%===== the effects of the window's size can be tested
% by taking wlg<wlgmax=N-lagmax
wlg=N-lagmax; v0=sn(1:wlg);
for ii=lagmin:lagmax
    vP=sn(ii:ii+wlg-1);
    corr(ii-lagmin+1)=(v0'*vP)/sqrt((v0'*v0)*(vP'*vP));
end
[niv1, indmax]=max(corr);
if niv1<thr
    pf0=0; 
    F0=NaN;  
    return
else
    for ii=lagmin+1:lagmax
        if corr(ii-lagmin+1)>niv1*0.9
            while corr(ii-lagmin+1)>corr(ii-lagmin)
                ii=ii+1;
            end
            pf0=ii-2; F0=Fs/pf0;
            return
        else
            F0=Fs/(indmax+lagmin-1);
        end
    end
end