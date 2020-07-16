% ==============================================================
%  code_main_PCE_nfkb_7vars.m
%
%  This script is the main file for a program that performs
%  a polynomial chaos expansion 
% ==============================================================
%  programmer: Michel Tosin
%              michel.tosin@uerj.br
%              Adriano Cortes                                   
%              adrimacortes@gmail.com 
%
%  last update: March 22, 2020
% ==============================================================

% --------------------------------------------------------------
% Clear figure, variables and command window
% --------------------------------------------------------------
  close all; clear; clc
% --------------------------------------------------------------

% --------------------------------------------------------------
% Program header
% --------------------------------------------------------------
  disp('                                                  ')
  disp('--------------------------------------------------')
  disp('     NF-kB System                                 ')
  disp(' (global sensitivity analysis)                    ')
  disp('                                                  ')
  disp(' by                                               ')
  disp(' Michel Tosin                                     ')
  disp(' michel.tosin@gmail.com                           ')
  disp(' Adriano Cortes                                   ')
  disp(' adrimacortes@gmail.com                           ')
  disp('--------------------------------------------------')
  disp('                                                  ')
% --------------------------------------------------------------

% --------------------------------------------------------------
% Start time lapse
% --------------------------------------------------------------
  tic
% --------------------------------------------------------------

% --------------------------------------------------------------
% Start RNG and fix the statistical seed
% --------------------------------------------------------------
  rng_stream = RandStream('mt19937ar','Seed',30081984);
  RandStream.setGlobalStream(rng_stream);
  %rng(100,'twister')
% --------------------------------------------------------------

% --------------------------------------------------------------
% Initialize UQLab
% --------------------------------------------------------------
  uqlab
% --------------------------------------------------------------
  
% --------------------------------------------------------------
% Model parameters
% --------------------------------------------------------------
% Initial conditions
  Nn_0  = 0.0;
  Im_0  = 0.0;
  I_0   = 0.0;
  N_0   = 1.0;
  NI_0  = 0.0;
  In_0  = 0.0;
  NIn_0 = 0.0;                     	   

% Initial conditions vector
  IC = [Nn_0 Im_0 I_0 N_0 NI_0 In_0 NIn_0];

  
%% --------------------------------------------------------------
% Computational Model
% ---------------------------------------------------------------
% This other constant parameters are used to characterize 
% the scenario; Contant parameters: tspan, and IC.

  t0 = 0;                 	     % initial time of analysis
  t1 = 540;   	                 % final time of analysis
  dt = 0.01;                  	 % time step (time units)
  tspan = t0:dt:t1;              % interval of analysis
  
  CMP.IC = IC;
  CMP.tspan = tspan;
  CMP.dt = dt;
  CMP.IKK = 0.7;
  
% Model settings
  ModelOpts.mFile = 'QoI_spike_dur_nfkb_7vars';
  ModelOpts.isVectorized = true;
  ModelOpts.Parameters = CMP;

  myModel = uq_createModel(ModelOpts);  


%% --------------------------------------------------------------
% Probabilistic Input
% ---------------------------------------------------------------
% This system parameters are the input. 
% Considering Uniform distribution.
% REMARK: In this test the input factor IKK is a fixed factor (check
% section bellow)

  Names = {'kNin' 'kIin' 'kIout' 'kNIout' 'kt' 'ktl' 'kf' 'kfn' 'kb' 'kbn' 'gammam'}; 
  %Names = {'kNin' 'kIin' 'kIout' 'kNIout' 'kt' 'ktl' 'kf' 'kfn' 'kb' 'kbn' 'gammam' 'IKK'};  
  
% Nominal values from [ref.1]
  kNin   =  5.4; 
  kIin   =  0.018;  
  kIout  =  0.012;  
  kNIout =  0.83;  
  kt     =  1.03;  
  ktl    =  0.24;  
  kf     =  30;  
  kfn    =  30; 
  kb     =  0.03;  
  kbn    =  0.03;  
  gammam =  0.017;
  %IKK    =  CMP.IKK;
        
% physical parameters vector
  param = [kNin kIin kIout kNIout kt ktl kf kfn kb kbn gammam]

  %dfactor = [0.02 0.02 0.02 0.02 0.02 0.02 0.02 0.02 0.02 0.02 0.02]; %dispersion factor around the nominal values
  
  dfactor = 0.015;
  sigma = dfactor.*param

  for i = 1:length(param)
      
        InputOpts.Marginals(i).Name = Names{i};    % input names
        InputOpts.Marginals(i).Type = 'uniform';   % distribution
      
        %computing support with dispersion dfactor 
        lbound = (1-sqrt(3)*dfactor)*param(i);
        ubound = (1+sqrt(3)*dfactor)*param(i);
        InputOpts.Marginals(i).Parameters = [lbound ubound]; %support
    
  end
    

  myInput = uq_createInput(InputOpts);   % input initiation

  
%% --------------------------------------------------------------
% PCE metamodel and  PCE-based Sobol indices
% ---------------------------------------------------------------
tic
disp(' ');
disp(' --- PCE-based Sobol indices --- ');
disp(' ');
disp('    ... ');
disp(' ');

% define metamodel tool settings
PCEOpts.Type                        = 'Metamodel';
PCEOpts.MetaType                    = 'PCE';
%PCEOpts.Display                     = 'verbose';
PCEOpts.Degree                      = 1:10;
PCEOpts.TruncOptions.qNorm          = 0.5:0.1:1.0;
%PCEOpts.TruncOptions.MaxInteraction = 3;
PCEOpts.Input                       = myInput;
PCEOpts.FullModel                   = myModel;
%PCEOpts.Method                      = 'OLS';
PCEOpts.Method                      = 'LARS';
%PCEOpts.Method                      = 'OMP';
%PCEOpts.Method                      = 'quadrature';

% define specif options for each method
switch PCEOpts.Method
    
    case 'OLS' 
        PCEOpts.ExpDesign.NSamples          = 200;
        %PCEOpts.ExpDesign.Sampling         = 'MC';
        %PCEOpts.ExpDesign.Sampling         = 'LHS';
        %PCEOpts.ExpDesign.Sampling          = 'Sobol';
        PCEOpts.ExpDesign.Sampling         = 'Halton';
        
    case 'LARS'
        PCEOpts.ExpDesign.NSamples          = 400;
        %PCEOpts.ExpDesign.Sampling         = 'MC';
        %PCEOpts.ExpDesign.Sampling         = 'LHS';
        %PCEOpts.ExpDesign.Sampling          = 'Sobol';
        PCEOpts.ExpDesign.Sampling         = 'Halton';
        %PCEOpts.LARS.TargetAccuracy       = 1e-2;
        
    case 'OMP'
        PCEOpts.ExpDesign.NSamples          = 200;
        %PCEOpts.ExpDesign.Sampling         = 'MC';
        %PCEOpts.ExpDesign.Sampling         = 'LHS';
        %PCEOpts.ExpDesign.Sampling          = 'Sobol';
        PCEOpts.ExpDesign.Sampling         = 'Halton';
        
    case 'quadrature'    
        PCEOpts.Quadrature.Type = 'Smolyak';         
end        


% compute PCE coefficients
myPCEmodel = uq_createModel(PCEOpts);
save PCEmodel.mat myPCEmodel


%%
disp('Starting Sobol Analysis...');
% define PCE-Sobol settings
SobolPCE.Type           = 'Sensitivity';
SobolPCE.Method         = 'Sobol';
SobolPCE.Sobol.Order    = 2;

% compute PCE-Sobol indices
mySobolPCE_Analysis = uq_createAnalysis(SobolPCE);
mySobolPCE_Results  = mySobolPCE_Analysis.Results;

toc    


%% --------------------------------------------------------------
% Validating
% ---------------------------------------------------------------
% Generate sample, model response and PCE response
  samp = 1e2;
  X = uq_getSample(myInput,samp);
  
  Ypce = uq_evalModel(myPCEmodel,X);
  Ymod = uq_evalModel(myModel,X);

% Computation details

%   for j = 1:size(Ymod,2)
%       uq_print(myPCEmodel,j) % print surrogate details
%   end

% Response match
  for j = 1:size(Ymod,2)
        
      figure
      plot(Ymod(:,j),Ypce(:,j),'o','Color','r') % samples

      hold on
      plot([min(Ymod(:,j)) max(Ymod(:,j))],...  % identity line
	   [min(Ymod(:,j)) max(Ymod(:,j))],...
	   '-','Color','b','linewidth',2)
      hold off

      title(['Year ',num2str(j)]); 
      grid on;
      xlabel('computational model')
      ylabel('surrogate model')
      xlim([min(Ymod(:,j)) max(Ymod(:,j))]);
      ylim([min(Ymod(:,j)) max(Ymod(:,j))]);
    
  end

% %% Maximum outlier residual (%)
%   err_p = abs(Ypce-Ymod)./Ymod*100;   % regression residual (%) 
% 
% %% Outlier residual error
%   for j = 1:size(Ymod,2)
%       figure
%       stem(err_p(:,j),'filled','LineStyle','none')
%       title(['Time Units ',num2str(j)]); 
%       grid on;
%       xlabel('simulations')
%       ylabel('error')
%   end
% % --------------------------------------------------------------


% --------------------------------------------------------------
% Finish time lapse
% --------------------------------------------------------------
disp(['Time of simulation:',num2str(toc)])
% --------------------------------------------------------------

%% display metamodel information
%..........................................................
disp(' ');
disp('PCE metamodel');
disp(' ');
uq_print(myPCEmodel)
uq_display(myPCEmodel);
disp(' ');


%% display PCE-based Sobol indices
%..........................................................
disp(' ');
disp('PCE-based Sobol');
disp(' ');
uq_print(mySobolPCE_Analysis)
uq_display(mySobolPCE_Analysis)
disp(' ');


%close all

%sobol_pred_prey

% ==============================================================

