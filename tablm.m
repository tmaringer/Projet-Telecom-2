tablM = [];
for n = 1:N % générer N messages et ajouter dans un tableau
    Md = round(rand(1,Mdlen)); % génération aléatoire
    M = cat(2,Ms,Md);
    tablM = [tablM;M];
end
tablM(tablM == 0) = -1; % codage des 0 en -1
tablM(tablM == 1) = +1; % codage des 1 en +1