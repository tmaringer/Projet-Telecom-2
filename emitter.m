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
    
    for n = 1:N
        value = tablM(n,:);
        tablN = [tablN;reshape([value;zeros(bet-1,numel(value))],1,[])]; % message Tb -> Tn
    end
    
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
    
    tabsig = [];
    tabbj = [];
    for n = 0:N-1
        bj = conv(tablN(n+1,:),tabfilter(n+1,:));
        w = interpft(bj,gamm*(length(tablN(n+1,:))+2*L*bet));
        tabbj = [tabbj;bj];
        tabsig = [tabsig;w];
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% mise à niveau de l'amplitude %%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for n = 1:N
        RMS = rms(tabsig(n,:));
        U = sqrt(Pt*Zc);
        A = U/RMS; 
        tabsig(n,:) = A*tabsig(n,:);
    end
    figure();
    f = tabsig;
end