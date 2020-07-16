% -----------------------------------------------------------------
%  SoBios_SIR.m
% -----------------------------------------------------------------
%
%  This script is the main file for a program that performs
%  a global sensitivity analysis in the nonlinear dynamics
%  of a Predator Prey system via Sobol indices.
% -----------------------------------------------------------------
%  programmer: Michel Tosin
%              michel.tosin@uerj.br
%
%  last update: March 20, 2020
% -----------------------------------------------------------------


% close figures, clear workspace and command window
% --------------------------------------------------------------
close all; clear; clc
% --------------------------------------------------------------


% Program header
% --------------------------------------------------------------
disp('                                                  ')
disp(' -------------------------------------------------')
disp(' SoBios: Sobol Indices for Biological Systems     ')
disp(' (Predator Prey System)                           ')
disp('                                                  ')
disp(' by                                               ')
disp(' Michel Tosin                                     ')
disp(' michel.tosin@gmail.com                           ')
disp('                                                  ')
disp(' Americo Cunha Jr                                 ')
disp(' americo.cunhajr@gmail.com                        ')
disp(' -------------------------------------------------')
disp('                                                  ')
% --------------------------------------------------------------


% start time counter
% --------------------------------------------------------------
tic
% --------------------------------------------------------------


% start random number generator and fix the statistical seed
% --------------------------------------------------------------
rng_stream = RandStream('mt19937ar','Seed',30081984);
RandStream.setGlobalStream(rng_stream);
% --------------------------------------------------------------


% initialize UQLab
% --------------------------------------------------------------
uqlab
% --------------------------------------------------------------


% simulation information
% -----------------------------------------------------------
case_name = 'SoBios_PredatorPrey';

disp(' '); 
disp([' Case Name: ',num2str(case_name)]);
disp(' ');
% -----------------------------------------------------------        
    

% model parameters
% --------------------------------------------------------------
disp(' '); 
disp(' --- defining model hyperparameters --- ');
disp(' ');
disp('    ... ');
disp(' ');

N = 1000; 
%I0 = 50;            % infected initial population
R0 = 0;             % removed initial population
%S0 = N - I0 - R0;   % susceptible initial population

% initial time of analysis (years)
t0 = 0.0;

% final time of analysis (years)
t1 = 42.0;

% time step (years)
%dt = 7;

% model initial conditions
%IC = [S0 I0 R0];

% model time interval of analysis (years)
tspan = [t0 7:7:t1];

% number of time steps
%Ndt = length(tspan);

% indice of the first year in the temporal mesh
%Nyear = round(1/dt);

% subset of the temporal mesh with the years indices
%tQoI = [(1+Nyear)  (5*(Nyear+2)+1)  Ndt];
%tQoI = [Ndt];

% number of ineteger years in the temporal mesh
%NtQoI = length(tQoI);

% model hyperparameters
%ModelParam.IC    = IC;
ModelParam.tspan = tspan;
ModelParam.N = N;
ModelParam.R0 = R0;
%ModelParam.tQoI  = tQoI;
%ModelParam.NtQoI = NtQoI;


% model input parameters name and bounds
%ModelParam.Names = {'a'  'b'   'c'  'd' };  % names 
%ModelParam.Min   = [0.44  0.02   0.71  0.0226]; % minimum value
%ModelParam.Max   = [0.68  0.044  1.15  0.0354]; % maximum value

delta = [0.4 0.4 0.4];

ModelParam.Names = {'b' 'a' 'Io'};  % names 
ModelParam.Min   = [0.37  0.15  200].*(1 - sqrt(3)*delta); % minimum value
ModelParam.Max   = [0.37  0.15  200].*(1 + sqrt(3)*delta); % maximum value



% model input parameters mean
ModelParam.Mean = 0.5*(ModelParam.Min+ModelParam.Max);

% model input parameters standard deviation
ModelParam.Std = (ModelParam.Max-ModelParam.Min)/sqrt(12);

% model dimension (number of input parameters)
ModelParam.Dim = length(ModelParam.Names);
% --------------------------------------------------------------


% computational model
% --------------------------------------------------------------
disp(' '); 
disp(' --- defining the computational model --- ');
disp(' ');
disp('    ... ');
disp(' ');

% define model characteristics
ModelOpts.mFile        = 'QoI_SIR';
ModelOpts.isVectorized = true;
ModelOpts.Parameters   = ModelParam;

% create model object
myModel = uq_createModel(ModelOpts);
% --------------------------------------------------------------


% probabilistic input model
% -----------------------------------------------------------
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
% -----------------------------------------------------------



% MC-based Sobol indices
% -----------------------------------------------------------
%tic
%disp(' ');
%disp(' --- MC-based Sobol indices --- ');
%disp(' ');
%disp('    ... ');
%disp(' ');

% define MC-Sobol settings
%SobolMC.Type             = 'Sensitivity';
%SobolMC.Method           = 'Sobol';
%SobolMC.Sobol.Order      = 2;
%SobolMC.Sobol.SampleSize = 75000; % samples per variance estimation
%SobolMC.Bootstrap.Replications = 100;
%SobolMC.Bootstrap.Alpha = 0.05;


% compute MC-Sobol indices
%mySobolMC_Analysis = uq_createAnalysis(SobolMC);
%mySobolMC_Results  = mySobolMC_Analysis.Results;


%SFO = zeros(4,100);
%SSO = zeros(6,100);

%for i = 1:200
%
%    SobolMC.Sobol.SampleSize = 500*i;
%
%    Step = i
%
%    mySobolMC_Analysis = uq_createAnalysis(SobolMC);
%    mySobolMC_Results  = mySobolMC_Analysis.Results;
%
%    first = mySobolMC_Results.AllOrders{1,1};
%    second = mySobolMC_Results.AllOrders{1,2};
%
%    SFO(:,i) = first(:,1);
%    SSO(:,i) = second(:,1);
%
%end

%toc
% -----------------------------------------------------------


% PCE-based Sobol indices
% -----------------------------------------------------------
%tic
%disp(' ');
%disp(' --- PCE-based Sobol indices --- ');
%disp(' ');
%disp('    ... ');
%disp(' ');

% define metamodel tool settings
PCEOpts.Type                        = 'Metamodel';
PCEOpts.MetaType                    = 'PCE';
PCEOpts.Degree                      = 10;
PCEOpts.Method                      = 'OLS';
PCEOpts.ExpDesign.NSamples          = 1000;  
%PCEOpts.ExpDesign.qNorm             = 0.75;  

% compute PCE coefficients
myPCE = uq_createModel(PCEOpts);

% define PCE-Sobol settings
SobolPCE.Type           = 'Sensitivity';
SobolPCE.Method         = 'Sobol';
SobolPCE.Sobol.Order    = 3;

% compute PCE-Sobol indices
mySobolPCE_Analysis = uq_createAnalysis(SobolPCE);
mySobolPCE_Results  = mySobolPCE_Analysis.Results;

%toc
% -----------------------------------------------------------


% save simulation results
% -----------------------------------------------------------
%tic

disp(' ')
disp(' --- saving simulation results --- ');
disp(' ');
disp('    ... ');
disp(' ');

save([num2str(case_name),'.mat']);

%toc
% -----------------------------------------------------------


% finish time counter
% --------------------------------------------------------------
%toc
% --------------------------------------------------------------


% post processing
% -----------------------------------------------------------
disp(' ');
disp(' --- post processing --- ');
disp(' ');
disp('    ... ');
disp(' ');

% display MC-based Sobol indices
%..........................................................
%disp(' ');
%disp('MC-based Sobol');
%disp(' ');
%uq_print(mySobolMC_Analysis,1:NtQoI)
%uq_display(mySobolMC_Analysis,1:NtQoI)

%SoBioS_plot(t1,ModelParam.Names,ModelParam.Dim,mySobolMC_Results,length(tspan(2:end)),'MC',SobolMC.Sobol.SampleSize);
%SoBioS_plot(t1,ModelParam.Names,ModelParam.Dim,mySobolMC_Results,2,'MC',SobolMC.Sobol.SampleSize);
%
%disp(' ');


% display metamodel information
%..........................................................
%disp(' ');
%disp('PCE metamodel');
%disp(' ');
%uq_print(myPCE,1:2*NtQoI)
%uq_display(myPCE,1:NtQoI);
%disp(' ');

% --------------------------------------------------------------
% PCE Validating
% --------------------------------------------------------------
% Generate sample, model response and PCE response
samp = 1e4;
X = uq_getSample(myInput,samp);
  
Ypce = uq_evalModel(myPCE,X);
Ymod = uq_evalModel(myModel,X);

% Maximum outlier residual (%)
err_p = abs(Ypce-Ymod);%./Ymod*100;   % regression residual (%) 

% Residual log (base 10)
logerr = log(abs(Ypce-Ymod));%/log(10);

SoBioS_valplot(Ymod,Ypce,err_p,logerr);
%SoBioS_valplot_ft(Ymod,Ypce,err_p);

% display PCE-based Sobol indices
%..........................................................
%disp(' ');
%disp('PCE-based Sobol');
%disp(' ');
%uq_print(mySobolPCE_Analysis,1:2*NtQoI)
%uq_display(mySobolPCE_Analysis,1:2)

%SoBioS_plot2(t1,ModelParam.Names,ModelParam.Dim,mySobolPCE_Results,length(tspan(2:end)),'PCE',PCEOpts.ExpDesign.NSamples);

%disp(' ');


% --------------------------------------------------------------
% Finish time lapse
% --------------------------------------------------------------
  disp(['Time of simulation:',num2str(toc)])
% --------------------------------------------------------------
