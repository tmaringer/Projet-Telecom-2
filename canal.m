function f = canal(tabsig)
    setting
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% génération aléatoire du délai des messages %%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    tau = [];
    for n = 1:N
        taun = rand*Tb;
        tau = [tau;round(taun*bet*gamm)];
    end
    maxtau = max(tau); 
    tabsig1 = zeros(N,(length(tabsig(1,:))+maxtau)); % trouver le max et ajouter des 0
    for n = 1:N
        zero = zeros(1,tau(n));
        zero1 = zeros(1,(maxtau-tau(n)));
        tabsig1(n,:) = cat(2,cat(2,zero,tabsig(n,:)),zero1);
    end
    figure();
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% affichage des différents canaux %%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    t = tiledlayout(N/Lar,Lar);
    t.Padding = 'compact';
    t.TileSpacing = 'compact';
    for n = 1:N
        nexttile
        plot(1:length(tabsig1(n,:)),tabsig1(n,:));
        hold on
    end
    hold on
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% atténuation et génération du SNR %%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    tabsig = tabsig1*alphan;
    Eb = Pt*((alphan^2))*Tb;
    B = 1/(2*Ta);
    No = Eb/SNR;
    variance = (No/2)*B;
    AWGNoise = sqrt(variance)*randn(1,length(tabsig(1,:)));
    signal = sum(tabsig) + AWGNoise;
    hold off
f = signal;
end

