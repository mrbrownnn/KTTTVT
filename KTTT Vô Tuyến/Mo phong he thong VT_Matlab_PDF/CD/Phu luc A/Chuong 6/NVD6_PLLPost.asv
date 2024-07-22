% File: NVD6_pllpost.m
kk = 0;
while kk == 0
k = menu('Chuong trinh hau xu ly PLL',...
        'Tan so dau vao & Tan so ra VCO',...
        'Pha dau vao & Pha VCO',...
        'Loi tan so','Loi pha','Mat phang pha',...
        'Mat phang pha & ve mien thoi gian','Exit Program');
        if k == 1
                plot(t,fin,'k',t,fvco,'k')
                title('TÇn sè ®Çu vµo vµ tÇn sè VCO','fontname','.Vntime','fontsize',14)
                xlabel('Thêi gian - Gi©y','fontname','.Vntime','fontsize',14);
                ylabel('TÇn sè - Hz','fontname','.Vntime','fontsize',14);
                pause
        elseif k ==2
                pvco=phin-phierror;
                plot(t,phin,t,pvco);
                title('Pha ®Çu vµo vµ pha VCO','fontname','.Vntime','fontsize',14)
                xlabel('Thêi gian - Gi©y','fontname','.Vntime','fontsize',14);
                ylabel('Pha- Rad','fontname','.Vntime','fontsize',14);
                pause
        elseif k == 3
                plot(t,freqerror);
                title('Lçi tÇn sè','fontname','.Vntime','fontsize',14)
                xlabel('Thêi gian - Gi©y','fontname','.Vntime','fontsize',14);
                ylabel('Lçi tÇn sè- Hz','fontname','.Vntime','fontsize',14);
                pause
        elseif k == 4
                plot(t,phierror);
                title('Lçi pha','fontname','.Vntime','fontsize',14)
                xlabel('Thêi gian - Gi©y','fontname','.Vntime','fontsize',14);
                ylabel('Lçi pha - Rad','fontname','.Vntime','fontsize',14);
                pause
        elseif k == 5
           		 ppplot
        elseif k == 6   
           		subplot(211);
                phierrn = phierror/pi;
                plot(phierrn,freqerror,'k');grid;
                title('MÆt ph¼ng pha','fontname','.Vntime','fontsize',14);
                xlabel('Lçi pha/Pi','fontname','.Vntime','fontsize',14);
                ylabel('Lçi tÇn sè - Hz','fontname','.Vntime','fontsize',14);
                subplot(212)
                plot(t,fin,'k',t,fvco,'k');
                grid
                title('TÇn sè ®Çu vµo vµ tÇn sè VCO','fontname','.Vntime','fontsize',14)
                xlabel('Thêi gian- Gi©y','fontname','.Vntime','fontsize',14);
                ylabel('TÇn sè - Hz','fontname','.Vntime','fontsize',14);
                subplot(111)
        elseif k == 7
                kk = 1;
        end
end