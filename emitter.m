function f = emitter()
    setting;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% générer N messages et ajouter dans un tableau %%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    tablM = [];
    for n = 1:N
        %Md = round(rand(1,Mdlen)); % génération aléatoire
        Md = [0 0 0 1 1 0 0 1];
        M = cat(2,Ms,Md);
        tablM = [tablM;M];
    end
    tablM(tablM == 0) = -1; % codage des 0 en -1
    tablM(tablM == 1) = +1; % codage des 1 en +1
    tablN = [];
    disp(tablM(1,:));

    %! Passage de la cadence Tb à Tn en ajoutant des (beta - 1) zeros entre chaque symboles.
    for n = 1:N
        value = tablM(n,:);
        tablN = [tablN;reshape([value;zeros(bet-1,numel(value))],1,[])]; % message Tb -> Tn
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% création d'un tableau avec les filtres %%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %! Création du filtre en cosinus surélvé en bande de base avec α le facteur de rolloff,
    %! L lalongueur du filtre en nombre d'oscillations et β le facteur de suréchantillonnage.
    prefilter = rcosfir(alph,L,bet);

    %! Création du vecteur temps du filtre de longueur 2Lβ + 1 = 1001 et de cadence Tn
    filter_time = -(L*Tb):Tn:(L*Tb);

    %! Création des différents filtres pour chaque bande en les multipliant par une proteuse
    tabfilter = [];
    for n = 0:N-1
        filter = prefilter .* cos(2*pi*2*n*filter_time/Tb);
        if n == 0
            plot(filter_time,filter);
            hold off;
        else
            plot(filter_time,filter)
        end
        tabfilter = [tabfilter;filter];
    end
    hold off

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% convolution filtre avec message %%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %! Modulation des signaux par le filtre correspondant
    tabsig = [];
    tabbj = [];
    for n = 0:N-1
        bj = conv(tablN(n+1,:),tabfilter(n+1,:)); %! Convolution entre le filtre et le signal
        w = interpft(bj,gamm*(length(tablN(n+1,:))+2*L*bet)); %! Simulation d'un DAC. Passage à la cadence Ta.
        tabbj = [tabbj;bj]; %! Signal modulé à la cadence Tn
        tabsig = [tabsig;w]; %! Signal analogique à la cadence Ta
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% mise à niveau de l'amplitude %%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for n = 1:N
        RMS = rms(tabsig(n,:)); %! Calcul de la puissance RMS des signaux analogiques
        U = sqrt(Pt*Zc); %! Calcul de la tension RMS nécessaire pour avoir la puissance voulue avec une impédance donnée.
        A = U/RMS; %! Calcul du gain à appliquer au signal analogique pour qu'il ai la puissance désirée.
        tabsig(n,:) = A*tabsig(n,:); %! Application du gain au signal.
    end
    figure();
    f = tabsig;
end
