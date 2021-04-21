% taille des messages
Ms = [1 0 1 0];
Mslen = length(Ms);
Mdlen = 11;

% nature des messages
Nature = 'SI'; % SI, SGA, ...

% nombre de modules
K = 3;

% nombre de ressources phys dispo
N = 3;

% débit binaire
Tb = 1;
R = 1/Tb;

% facteur de surechantill
bet = 4*N-2;
%bet = 1000;
% paramètres du FIR
alph = 0.1;
L = 5;
nb = 3;

% puissance transmise et impédance du câble
Pt = 1;
Zc = 50;

% facteur de suréchantillonnage
gamm = 10;

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
fp = 10000;
Tn = Tb/bet;
Ta = Tn/gamm;
f = 0:Ta*gamm:0.5/Ta;
fn = f*2;
Mlen = Mslen + Mdlen;