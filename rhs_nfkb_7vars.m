%% Right hand side of the
% -----------------------------------------------------------------
% This function defines the system of ODEs of a seven species
% NF-kB signalling pathway as defined in
%
% S. Krishna, M.H. Jensen, K. Sneppen, Minimal model of spiky 
% oscillations in NF-􏲴B signaling, Proceedings of the National 
% Academy of Sciences (PNAS) 103(29), 10840 (2006). 
% DOI 10.1073/pnas.0604085103
%   
% ----------------------------------------------------------------- 
%   Species:
%   
%   Nn  = free nuclear NF-kB concentration
%   N   = cytoplasmic NF-kB concentration
%   Im  = IkB mRNA concentration
%   In  = free nuclear IkB concentration
%   I   = cytoplasmic IkB concentration
%   NIn = nuclear NF-kB:IkB complex concentration
%   NI  = cytoplasmic NF-kB:IkB complex concentration
%
%   Parameters:
%
%   kNin   =  NF-kB nuclear import rate (min^-1)
%   kIin   =  IkB nuclear import rate (min^-1)
%   kIout  =  IkB cytoplasm export rate (min^-1)
%   kNIout =  NF-kB:IkB complex export rate (min^-1)
%   kt     =  IκB mRNA transcription rate (muM^-1 * min^-1)
%   ktl    =  IκB mRNA translation rate (min^-1)
%   kf     =  NF-κB:IκB cytoplasm association rate (muM^-1 * min^-1)
%   kfn    =  NF-κB:IκB nuclear association rate (muM^-1 * min^-1)
%   kb     =  NF-κB:IκB cytoplasm dissociation rate (min^-1)
%   kbn    =  NF-κB:IκB nuclear dissociation rate (min^-1)
%   gammam =  mRNA degradation rate (min^-1)
%   IKK    =  IkB Kinase initial concentration
% ----------------------------------------------------------------- 
%  
%  Adriano Cortes
%  adriano@nacad.ufrj.br
%
%  last update: Jul, 02 2020
% -----------------------------------------------------------------

%% Function
% -----------------------------------------------------------------
function ydot = rhs_nfkb_7vars(t,y,param)

% Species:
  Nn  = y(1);
  Im  = y(2);
  I   = y(3);
  N   = y(4);
  NI  = y(5);
  In  = y(6);
  NIn = y(7);
 
% Parameters:
  kNin   =  param(1); 
  kIin   =  param(2);  
  kIout  =  param(3);  
  kNIout =  param(4);  
  kt     =  param(5);  
  ktl    =  param(6);  
  kf     =  param(7);  
  kfn    =  param(8); 
  kb     =  param(9);  
  kbn    =  param(10);  
  gammam =  param(11);  
  IKK    =  param(12);
  
  % alpha := IκB degradation rate (by phosphorylation)
  alpha  = 1.05*IKK;

  ydot = zeros(size(y));

  ydot(1) =  kNin*N - kfn*Nn*In + kbn*NIn; % d(Nn)/dt         
  ydot(2) =  kt*Nn*Nn - gammam*Im; % d(Im)/dt
  ydot(3) =  ktl*Im - kf*N*I + kb*NI - kIin*I + kIout*In; % dI/dt
  ydot(4) = -kf*N*I + (kb + alpha)*NI - kNin*N; % dN/dt
  ydot(5) =  kf*N*I - (kb + alpha)*NI + kNIout*NIn; % d(NI)/dt
  ydot(6) =  kIin*I - kIout*In - kfn*Nn*In + kbn*NIn; % d(In)/dt
  ydot(7) =  kfn*Nn*In - (kbn + kNIout)*NIn; % d(NIn)/dt

end
% -----------------------------------------------------------------
