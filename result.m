%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% PROJET TELECOM 2 LANDRY ET THIBAUT %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% emitter -> canal -> receiver 
%                         ^
%                         |
%                     reference

emit = emitter;
ref = references;
signal = canal(emit);
disp(receiver(ref, signal));