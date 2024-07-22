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
    ylabel('X¸c suÊt lçi Pe','FontName','.VnTime','color','b','FontSize',Ysize);
%--------------------------------------------------------------------------    
if rfade==0     % AWGN
    if seq ==1
        title('M« pháng SER cho DS-SS-CDMA/QPSK; trong kªnh AWGN; dïng m· M',...
            'FontName','.VnTime','color','b','FontSize',Tsize);
    elseif seq ==2
        title('M« pháng SER cho DS-SS-CDMA/QPSK; trong kªnh AWGN; dïng m· Gold',...
            'FontName','.VnTime','color','b','FontSize',Tsize);        
    else
        title('M« pháng SER cho DS-SS-CDMA/QPSK; trong kªnh AWGN; dïng m· Gold trùc giao',...
            'FontName','.VnTime','color','b','FontSize',Tsize);        
    end    
%--------------------------------------------------------------------------    
else            % Fading channel: Rayleigh
    if seq ==1
        title('M« pháng SER cho DS-SS-CDMA/QPSK;trong kªnh pha®inh Rayleigh; dïng m· M',...
            'FontName','.VnTime','color','b','FontSize',Tsize);
    elseif seq ==2
        title('M« pháng SER cho DS-SS-CDMA/QPSK;trong kªnh pha®inh Rayleigh; dïng m· Gold',...
            'FontName','.VnTime','color','b','FontSize',Tsize);        
    else
        title('M« pháng SER cho DS-SS-CDMA/QPSK;trong kªnh pha®inh Rayleigh; dïng m· Gold trùc giao',...
            'FontName','.VnTime','color','b','FontSize',Tsize);
    end    
end
LT = legend('Sè ng­êi dïng =1','Sè ng­êi dïng =4','Sè ng­êi dïng = 7');
set(LT,'FontName','.VnTime','FontSize',Lsize');
grid on;

%==========================================================================
%     LT = legend('BER: \it Kh«ng m· hãa kªnh lý thuyÕt',...
%         'BER: \it Kh«ng m· hãa kªnh m« pháng',...
%         'BER: \it Cã m· hãa kªnh, \bf G1, r=1/2',...
%         'BER: \it Cã m· hãa kªnh, \bf G2, r=1/2',...
%         'BER: \it Cã m· hãa kªnh, \bf G3, r=2/3');    
%     set(LT,'fontname','.vntime','fontsize',18); 
%     text(1,7e-5,'M« h×nh hãa vµ m« pháng hiÖu n¨ng c¸c bé m· hãa kªnh',...
%         'FontName','.VnTimeh','Color','r','FontSize',14);    
%     text(0.5,min(theo_Antipodal_err_prb),'TÝnh chÝnh x¸c cña kÕt qu¶ m« pháng, x¸c nhËn vµ phª chuÈn m« h×nh',...
%         'FontName','.VnUniverseH','Color','b','FontSize',22);