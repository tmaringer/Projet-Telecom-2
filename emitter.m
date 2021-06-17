function f = emitter()
    setting;
    tablM = [];
    for n = 1:N % générer N messages et ajouter dans un tableau
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
    %disp(tablN);

    %! Création du filtre en cosinus surélvé en bande de base avec α le facteur de rolloff,
    %! L lalongueur du filtre en nombre d'oscillations et β le facteur de suréchantillonnage.
    prefilter = rcosfir(alph,L,bet);
    %disp(size(prefilter))
    %! Création du vecteur temps du filtre de longueur 2Lβ + 1 = 1001 et de cadence Tn
    filter_time = -(L*Tb):Tn:(L*Tb);
    %disp(size(filter_time))

    %! Création des différents filtres pour chaque bande en les multipliant par une proteuse
    tabfilter = [];
    for n = 0:N-1 % création d'un tableau avec les filtres
        filter = prefilter .* cos(2*pi*2*n*filter_time/Tb); %! Multiplication élément par élément
        if n == 0
            plot(filter_time,filter);
            hold off;
        else
            plot(filter_time,filter)
        end
        tabfilter = [tabfilter;filter];
        %hold on
    end
    %disp(tabfilter);
    %disp(size(tabfilter));
    hold off
    %legend('canal 0','canal 1')
    %xlabel("numéro d'échantillon")
    %ylabel('FIR normalisé')

    %! Modulation des signaux par le filtre correspondant
    tabsig = [];
    tabbj = [];
    for n = 0:N-1
        bj = conv(tablN(n+1,:),tabfilter(n+1,:)); %! Convolution entre le filtre et le signal
        w = interpft(bj,gamm*(length(tablN(n+1,:))+2*L*bet)); %! Simulation d'un DAC. Passage à la cadence Ta.
        tabbj = [tabbj;bj]; %! Signal modulé à la cadence Tn
        tabsig = [tabsig;w]; %! Signal analogique à la cadence Ta
    end
%     plot(1:length(tabbj),tabbj(1,:));
%     hold on
%     plot(1:length(tabbj),ones(length(tabbj)));
%     hold on
%     plot(1:length(tabbj),-ones(length(tabbj)));
%     figure();
    %disp(size(interpft(tabbj(3,:), gamm*(Mlen+2*L*bet))));
    %o = plot(1:(length(tablN(1,:))+2*L*bet),tabbj(1,:), 'o');
%     hold off
%     plot(1:(1/gamm):((length(tablN(2,:))+2*L*bet+1)-(1/gamm)), tabsig(2,:));
%     hold on
%     plot(1:(1/gamm):((length(tablN(2,:))+2*L*bet+1)-(1/gamm)), tabsig(2,:), '.');
%     hold off
    %disp(size(tabsig));
    %signal = sum(tabsig);
    %disp(size(signal));
    %plot (1:length(signal), signal);
    %hold on


    for n = 1:N
        RMS = rms(tabsig(n,:)); %! Calcul de la puissance RMS des signaux analogiques
        U = sqrt(Pt*Zc); %! Calcul de la tension RMS nécessaire pour avoir la puissance voulue avec une impédance donnée.
        A = U/RMS; %! Calcul du gain à appliquer au signal analogique pour qu'il ai la puissance désirée.
        tabsig(n,:) = A*tabsig(n,:); %! Application du gain au signal.
        %plot(1:length(tabsig(n,:)),tabsig(n,:));
        %hold on
    end
    figure();
    %disp(A);
    %plot (1:length(tabsig(1,:)), tabsig(1,:));
    %hold off
    %disp(tabsig);
    f = tabsig;
end
