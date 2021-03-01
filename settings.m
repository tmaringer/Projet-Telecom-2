% taille des messages
Ms = 10;
Md = 12;
M = Ms + Md;
disp(M)

% nature des messages
Nature = 'SI'; % SI, SGA, ...

% nombre de modules
K = 3;

% nombre de ressources phys dispo
N = 4;

% débit binaire
Tb = 1;
R = 1/Tb;

% facteur de surechantill
beta = 2;

% paramètres du FIR
alpha = 1;
L = 5;
nb = 3;

% puissance transmise et impédance du câble
Pt = 10;
Zc = 5;

% facteur de suréchantillonnage
gamma = 4;

% paramètre du canal
alphan = 2;
taun = 3;

% SNR
Eb = 5;
N0 = 5;
SNR = Eb/N0;

% seuil pour le récepteur simplifié
V = 4;