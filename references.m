function f = references()
    setting;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% générer N messages et ajouter dans un tableau %%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    tablM = [];
    for n = 1:N
        tablM = [tablM;Ms];
    end
    tablM(tablM == 0) = -1; % codage des 0 en -1
    tablM(tablM == 1) = +1; % codage des 1 en +1
    tablN = [];
    disp(tablM(1,:));
    
    for n = 1:N
        value = tablM(n,:);
        tablN = [tablN;reshape([value;zeros(bet-1,numel(value))],1,[])]; % message Tb -> Tn
    end
    %disp(tablN);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% création d'un tableau avec les filtres %%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    prefilter = rcosfir(alph,L,bet);
    filter_time = -(L*Tb):Tn:(L*Tb);
    
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
    
    tabbj = [];
    for n = 0:N-1
        bj = conv(tablN(n+1,:),tabfilter(n+1,:));
        tabbj = [tabbj;bj];
        if n == 0
            plot(1:length(tabbj),tabbj(n+1,:));
            hold on
            plot(1:length(tabbj),ones(length(tabbj)));
            hold on
            plot(1:length(tabbj),-ones(length(tabbj)));
            figure();
        end
    end
    f = tabbj;
end