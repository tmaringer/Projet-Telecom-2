function f = canal(tabsig)
    setting

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% génération aléatoire du délai des messages %%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %! Création d'un délai aléatoire différent pour chaque canal
    tau = [];
    for n = 1:N
        taun = rand*Tb; %! Délai aléatoire entre 0 et Tb
        tau = [tau;round(taun*bet*gamm)]; %! Arrondir à un nombre entier d'échantillon de cadence Ta
    end
<<<<<<< HEAD
    maxtau = max(tau); %! Trouver le délai maximum
    tabsig1 = zeros(N,(length(tabsig(1,:))+maxtau)); %! Ajouter des 0

    for n = 1:N
        zero = zeros(1,tau(n)); %! Ajout de n 0 en début de signal
        zero1 = zeros(1,(maxtau-tau(n))); %! Ajout de max-n 0 en fin de signal
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

    %! Atténuation du signal par le canal
    tabsig = tabsig1*alphan;
    %! Ajout du bruit AWGN
    Eb = Pt*((alphan^2))*Tb;
    B = 1/(2*Ta); %! Bande passante moitié de la fréquence d'écahntillonage du DAC.
    No = Eb/SNR; %! Déterminer N0 en fonction du SNR souhaité et de l'énergie d'un bit.
    variance = (No/2)*B; %! Calcul de la variance du bruit blanc
    AWGNoise = sqrt(variance)*randn(1,length(tabsig(1,:))); %! Génération du bruit blanc
    signal = sum(tabsig) + AWGNoise; %! Somme du bruit blanc et de chaque signaux
    hold off
f = signal;
end
