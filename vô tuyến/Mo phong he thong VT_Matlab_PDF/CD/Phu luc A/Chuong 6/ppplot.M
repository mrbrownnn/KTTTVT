% File: ppplot.m
% ppplot.m is the script file for plotting phase plane plots. If the 
% phase plane is constrained to (-pi,pi) ppplot.m calls pplane.m.

kz = 0;

while kz == 0
    k = menu('Cac tuy chon mat phang pha',...
        'Extended Phase Plane',...
        'Phase Plane mod(2pi)',...
        'Exit');
    if k == 1
        phierrn = phierror/pi;
        plot(phierrn,freqerror,'k')
        title('MÆt ph¼ng pha','fontname','.vntimeH')
        xlabel('Lçi pha/Pi','fontname','.vntime')
        ylabel('Lçi tÇn sè Hz','fontname','.vntime')
        grid
        pause
     elseif k == 2
         pplane(phierror,freqerror,nsettle+1)
         pause
     elseif k == 3
         kz = 1;
     end
end