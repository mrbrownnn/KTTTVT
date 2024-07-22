%==========================================================================
%================== function Presentation_Sim_MA_05========================
%==========================================================================

function Presentation_Sim_MA_05(ber, ebn0, rfade, seq, num_fig)

if num_fig ~=0
    figure(num_fig);
    Xsize = 14;
    Ysize = 18;
    Tsize = 18;
    Lsize = 16;
else
    Xsize = 12;
    Ysize = 14;
    Tsize = 9; 
    Lsize = 12;
end

    %------------------------
    semilogy(ebn0,ber(1,:),...
        '-vr','LineWidth',1.5,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','b',...
        'MarkerSize',7);
    hold on;
    %------------------------
    semilogy(ebn0,ber(2,:),...
        '-ob','LineWidth',1.5,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','m',...
        'MarkerSize',7);
    hold on;    
    %------------------------
    semilogy(ebn0,ber(3,:),...
        ':sk','LineWidth',2.5,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','b',...
        'MarkerSize',12);
    hold on;
    AX      = gca;
    set(AX,'FontSize',14);
    xlabel('SNR [dB]','FontName','.VnTime','color','b','FontSize',Xsize);
    ylabel('X�c su�t l�i Pe','FontName','.VnTime','color','b','FontSize',Ysize);
%--------------------------------------------------------------------------    
if rfade==0     % AWGN
    if seq ==1
        title('M� ph�ng SER cho DS-SS-CDMA/QPSK; trong k�nh AWGN; d�ng m� M',...
            'FontName','.VnTime','color','b','FontSize',Tsize);
    elseif seq ==2
        title('M� ph�ng SER cho DS-SS-CDMA/QPSK; trong k�nh AWGN; d�ng m� Gold',...
            'FontName','.VnTime','color','b','FontSize',Tsize);        
    else
        title('M� ph�ng SER cho DS-SS-CDMA/QPSK; trong k�nh AWGN; d�ng m� Gold tr�c giao',...
            'FontName','.VnTime','color','b','FontSize',Tsize);        
    end    
%--------------------------------------------------------------------------    
else            % Fading channel: Rayleigh
    if seq ==1
        title('M� ph�ng SER cho DS-SS-CDMA/QPSK;trong k�nh pha�inh Rayleigh; d�ng m� M',...
            'FontName','.VnTime','color','b','FontSize',Tsize);
    elseif seq ==2
        title('M� ph�ng SER cho DS-SS-CDMA/QPSK;trong k�nh pha�inh Rayleigh; d�ng m� Gold',...
            'FontName','.VnTime','color','b','FontSize',Tsize);        
    else
        title('M� ph�ng SER cho DS-SS-CDMA/QPSK;trong k�nh pha�inh Rayleigh; d�ng m� Gold tr�c giao',...
            'FontName','.VnTime','color','b','FontSize',Tsize);
    end    
end
LT = legend('S� ng��i d�ng =1','S� ng��i d�ng =4','S� ng��i d�ng = 7');
set(LT,'FontName','.VnTime','FontSize',Lsize');
grid on;

%==========================================================================
%     LT = legend('BER: \it Kh�ng m� h�a k�nh l� thuy�t',...
%         'BER: \it Kh�ng m� h�a k�nh m� ph�ng',...
%         'BER: \it C� m� h�a k�nh, \bf G1, r=1/2',...
%         'BER: \it C� m� h�a k�nh, \bf G2, r=1/2',...
%         'BER: \it C� m� h�a k�nh, \bf G3, r=2/3');    
%     set(LT,'fontname','.vntime','fontsize',18); 
%     text(1,7e-5,'M� h�nh h�a v� m� ph�ng hi�u n�ng c�c b� m� h�a k�nh',...
%         'FontName','.VnTimeh','Color','r','FontSize',14);    
%     text(0.5,min(theo_Antipodal_err_prb),'T�nh ch�nh x�c c�a k�t qu� m� ph�ng, x�c nh�n v� ph� chu�n m� h�nh',...
%         'FontName','.VnUniverseH','Color','b','FontSize',22);