function f = emitter()
    setting;
    tablM = [];
    for n = 1:N % générer N messages et ajouter dans un tableau
        Md = round(rand(1,Mdlen)); % génération aléatoire
        M = cat(2,Ms,Md);
        tablM = [tablM;M];
    end
    tablM(tablM == 0) = -1; % codage des 0 en -1
    tablM(tablM == 1) = +1; % codage des 1 en +1
    %b = rcosdesign(alph, L, bet); % add-on Communication
    %b = rcosfir(0, L, bet, 1); % alpha = vitesse atténuation, centré en L*bet
    
    Tbvec = ((-Mlen+1)/2)*Tb:Tb:((Mlen-1)/2)*Tb;
    Tnvec = ((-Mlen+1)/2)*Tb:Tn:((Mlen-1)/2)*Tb;
    [row,col] = size(tablM);
    time = 0:1:(2*L*bet);
    freq = 0;
    disp(size(time))
    prefilter = rcosfir(alph,L,bet);
    disp(size(prefilter))
    filter_time = -(L*Tb):Tn:(L*Tb);
    disp(size(filter_time))
    filter = prefilter .* cos(2*pi*freq*filter_time);
    b = plot(filter_time,filter);
    filter = prefilter .* cos(2*pi*1000*filter_time);
    hold on
    plot(filter_time,filter)
    filter = prefilter .* cos(2*pi*2000*filter_time);
    hold on
    plot(filter_time,filter)
    f = b;
end