% taille des messages
Ms = [1 0 1 0];
Mslen = length(Ms);
Mdlen = 12;

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
bet = 20;

% paramètres du FIR
alph = 0.25;
L = 20;
nb = 3;

% puissance transmise et impédance du câble
Pt = 10;
Zc = 5;

% facteur de suréchantillonnage
gamm = 4;

% paramètre du canal
alphan = 2;
taun = 3;

% SNR
Eb = 5;
N0 = 5;
SNR = Eb/N0;

% seuil pour le récepteur simplifié
V = 4;


% calcul de variables
Tn = Tb/bet;
Ta = Tn/gamm;
f = [0;0.5/Ta];
fn = f*2;
Mlen = Mslen + Mdlen;