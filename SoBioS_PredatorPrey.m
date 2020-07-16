% -----------------------------------------------------------------
%  SoBioS_PredatorPrey.m
% -----------------------------------------------------------------
%
%  This script is the main file for a program that performs
%  a global sensitivity analysis in the nonlinear dynamics
%  of a Predator Prey system via Sobol indices.
% -----------------------------------------------------------------
%  programmer: Michel Tosin
%              michel.tosin@uerj.br
%
%  last update: Apr 06, 2020
% -----------------------------------------------------------------


% close figures, clear workspace and command window
% -----------------------------------------------------------------
  close all; clear; clc
% -----------------------------------------------------------------


% Program header
% -----------------------------------------------------------------
  disp('                                                        ')
  disp(' -------------------------------------------------------')
  disp('     SoBios: Sobol Indices for Biological Systems       ')
  disp('                 (Predator Prey System)                 ')
  disp('                                                        ')
  disp(' by                                                     ')
  disp(' Michel Tosin                                           ')
  disp(' michel.tosin@uerj.br                                   ')
  disp('                                                        ')
  disp(' Americo Cunha Jr                                       ')
  disp(' americo.cunhajr@gmail.com                              ')
  disp('                                                        ')
  disp(' Adriano Côrtes                                         ')
  disp(' adriano@caxias.ufrj.br                                 ')
  disp(' -------------------------------------------------------')
  disp('                                                        ')
% -----------------------------------------------------------------


% start time counter
% -----------------------------------------------------------------
  tic
% -----------------------------------------------------------------


% start random number generator and fix the statistical seed
% -----------------------------------------------------------------
  rng_stream = RandStream('mt19937ar','Seed',30081984);
  RandStream.setGlobalStream(rng_stream);
% -----------------------------------------------------------------


% initialize UQLab
% -----------------------------------------------------------------
  uqlab
% -----------------------------------------------------------------


% simulation information
% -----------------------------------------------------------------
  case_name = 'SoBioS_PredatorPrey';

  disp(' '); 
  disp([' Case Name: ',num2str(case_name)]);
  disp(' ');
% -----------------------------------------------------------------
    

% model parameters
% -----------------------------------------------------------------
  disp(' '); 
  disp(' --- defining model hyperparameters --- ');
  disp(' ');
  disp('    ... ');
  disp(' ');

% prey initial population
  Prey0 = 33;

% predator initial population
  Predator0 = 6.2;

% initial time of analysis (years)
  t0 = 0.0;

% final time of analysis (years)
  t1 = 10.0;

% model initial conditions
  IC = [Prey0 Predator0];

% model time interval of analysis (years)
  tspan = [t0 1 6 t1];

% model hyperparameters
  ModelParam.IC    = IC;
  ModelParam.tspan = tspan;

% model input parameters name and bounds
  ModelParam.Names = { 'a'   'b'    'c'    'd' };  % names 
  ModelParam.Min   = [0.44  0.02   0.71  0.0226]; % minimum value
  ModelParam.Max   = [0.68  0.044  1.15  0.0354]; % maximum value

% model input parameters mean
  ModelParam.Mean = 0.5*(ModelParam.Min+ModelParam.Max);

% model input parameters standard deviation
  ModelParam.Std = (ModelParam.Max-ModelParam.Min)/sqrt(12);

% model dimension (number of input parameters)
  ModelParam.Dim = length(ModelParam.Names);
% -----------------------------------------------------------------


% computational model
% -----------------------------------------------------------------
  disp(' '); 
  disp(' --- defining the computational model --- ');
  disp(' ');
  disp('    ... ');
  disp(' ');

% define model characteristics
  ModelOpts.mFile        = 'QoI_PredatorPrey';
  ModelOpts.isVectorized = true;
  ModelOpts.Parameters   = ModelParam;

% create model object
  myModel = uq_createModel(ModelOpts);
% -----------------------------------------------------------------


% probabilistic input model
% -----------------------------------------------------------------
  disp(' ');
  disp(' --- defining the probabilistic model input --- ');
  disp(' ');
  disp('    ... ');
  disp(' ');

% define input parameters marginal distributions
  for i = 1:ModelParam.Dim
    InputOpts.Marginals(i).Name       = ModelParam.Names{i}; % names
    InputOpts.Marginals(i).Type       = 'uniform';           % distribution
    InputOpts.Marginals(i).Parameters = sqrt(3)*[-1 1];      % support
  end

% create input object
  myInput = uq_createInput(InputOpts);
% -----------------------------------------------------------------

% MC-based Sobol indices
% -----------------------------------------------------------------
% tic
% disp(' ');
% disp(' --- MC-based Sobol indices --- ');
% disp(' ');
% disp('    ... ');
% disp(' ');

% define MC-Sobol settings
% SobolMC.Type             = 'Sensitivity';
% SobolMC.Method           = 'Sobol';
% SobolMC.Sobol.Order      = 2;
% SobolMC.Sobol.SampleSize = 75000; % samples per variance estimation
% SobolMC.Bootstrap.Replications = 100;
% SobolMC.Bootstrap.Alpha = 0.05;

% compute MC-Sobol indices
% mySobolMC_Analysis = uq_createAnalysis(SobolMC);
% mySobolMC_Results  = mySobolMC_Analysis.Results;

% -----------------------------------------------------------------


% PCE-based Sobol indices
% -----------------------------------------------------------------
  disp(' ');
  disp(' --- PCE-based Sobol indices --- ');
  disp(' ');
  disp('    ... ');
  disp(' ');

% define metamodel tool settings
  PCEOpts.Type                        = 'Metamodel';
  PCEOpts.MetaType                    = 'PCE';
  PCEOpts.Degree                      = 6;
  PCEOpts.Method                      = 'OLS';
  PCEOpts.ExpDesign.NSamples          = 1000;  

% compute PCE coefficients
  myPCE = uq_createModel(PCEOpts);

% define PCE-Sobol settings
  SobolPCE.Type           = 'Sensitivity';
  SobolPCE.Method         = 'Sobol';
  SobolPCE.Sobol.Order    = 2;

% compute PCE-Sobol indices
  mySobolPCE_Analysis = uq_createAnalysis(SobolPCE);
  mySobolPCE_Results  = mySobolPCE_Analysis.Results;

% -----------------------------------------------------------------


% save simulation results
% -----------------------------------------------------------------
  disp(' ')
  disp(' --- saving simulation results --- ');
  disp(' ');
  disp('    ... ');
  disp(' ');

  save([num2str(case_name),'.mat']);
% ----------------------------------------------------------------


% post processing
% ----------------------------------------------------------------
  disp(' ');
  disp(' --- post processing --- ');
  disp(' ');
  disp('    ... ');
  disp(' ');

% display MC-based Sobol indices
% .................................................................
% disp(' ');
% disp('MC-based Sobol');
% disp(' ');
% uq_print(mySobolMC_Analysis,1:NtQoI)
% uq_display(mySobolMC_Analysis,1:NtQoI)

% display metamodel information
% .................................................................
 disp(' ');
 disp('PCE metamodel');
 disp(' ');
 uq_print(myPCE,1:NtQoI)
 uq_display(myPCE,1:NtQoI);
 disp(' ');

% ----------------------------------------------------------------
% PCE Validating
% ----------------------------------------------------------------
% Generate sample, model response and PCE response
  samp = 1e4;                      % size of the validation set
  X = uq_getSample(myInput,samp);  % validation set
  
  Ypce = uq_evalModel(myPCE,X);    % PCE evaluations
  Ymod = uq_evalModel(myModel,X);  % real model evaluations

% Maximum outlier residual (%)
  err_p = abs(Ypce-Ymod);  % regression residual 

  SoBioS_valplot(Ymod,Ypce,err_p,logerr);

% display PCE-based Sobol indices
% .................................................................
 disp(' ');
 disp('PCE-based Sobol');
 disp(' ');
 NtQoI = length(tspan(2:end));
 uq_print(mySobolPCE_Analysis,1:NtQoI)    % show the results details
 uq_display(mySobolPCE_Analysis,1:NtQoI)  % plot the results

% -----------------------------------------------------------------
% Finish time lapse
% -----------------------------------------------------------------
  disp(['Time of simulation:',num2str(toc)])
% -----------------------------------------------------------------
