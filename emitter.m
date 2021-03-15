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
    [row,col] = size(tablM);
    for m = 1:row
        z= zeros(1,(bet*2*L1+1)+(2*bet)*(col-1));
        for n = 1:col
            disp(n)
            %L = 10 + 1 * (n-1);
            L = L1 + 1 * (n-1);
            k = tablM(m,n);
            disp(size(k*rcosfir(0, L, bet)));
            w = k*rcosfir(0, L, bet);
            w = [w zeros(1,(2*bet)*(col-n))];
            z = z + w;
            %g = plot(1:length(w),w);
            %hold on
        end
        b = plot(1:length(z),z);
        hold on
    end
    f = b;
end