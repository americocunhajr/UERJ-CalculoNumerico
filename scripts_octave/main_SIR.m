% -----------------------------------------------------------
% EPIDEMIC - Epidemiology Educational Code
% www.EpidemicCode.org
% -----------------------------------------------------------
% This is the main file for the SIR epidemic model, which
% divides a population in 3 compartments:
%
%   S = susceptible
%   I = infected
%   R = recovered
%
% Infection spreads via direct contact between
% a susceptible and infected individual, with no delay.
% No deaths are considered, all infected become recovered.
%
% This model has 3 parameters:
%
%   N     = population size   (number of individuals)
%   beta  = transmission rate (days^-1)
%   gamma = recovery rate     (days^-1)
%
% This codes uses rhs_SIR.m to define the ODE system
% and outputs the plots and R_nought value. Calculations
% are made on a day time scale.
% -----------------------------------------------------------
% programmers: Eber Dantas
%              Americo Cunha
%
% last update: May 19, 2020
% -----------------------------------------------------------

clc
clear
close all


% parameters and initial conditions [USER INPUT]
% -----------------------------------------------------------  

% population size (number of individuals)
N = 1;
        
% transmission rate (days^-1)
beta = 1/3;

% recovery period (days)
Tgamma = 10;

% recovery rate (days^-1)
gamma  = 1/Tgamma;

% initial conditions
%
% -- Set the initial number of infected.
% -- The number of susceptible will be the remaining population.
% -- For an invasion scenario, set initial infected to 1.

R0 = 0;        % initial recovered   (number of individuals)
I0 = 10e-6;        % initial infected    (number of individuals)
S0 = N-I0-R0;  % initial susceptible (number of individuals)

% initial cumulative infected (number of individuals)
C0 = I0;
% -----------------------------------------------------------


% display program header on screen
% -----------------------------------------------------------

% computing the basic reproduction number R_nought
R_nought = beta/gamma;

disp(' ')
disp('================================================')
disp('   EPIDEMIC - Epidemiology Educational Code     ')
disp('   by A. Cunha, E. Dantas, et al.               ')
disp('                                                ')
disp('   This is an easy to run educational toolkit   ')
disp('   for epidemiological analysis.                ')
disp('                                                ')
disp('   www.EpidemicCode.org                         ')
disp('================================================')
disp(' ')
disp(' --------------------------------------'      )
disp(' ++++++++++++ SIR model +++++++++++++++'      )
disp(' --------------------------------------'      )
disp(['  * population        = ',num2str(N)]        )
disp( '    (individuals)       '                    )
disp(['  * transmission rate = ',num2str(beta)]     )
disp( '    (days^-1)           '                    )
disp(['  * recovery rate     = ',num2str(gamma)]    )
disp( '    (days^-1)           '                    )
disp(['  * R_nought          = ',num2str(R_nought)] )
disp( '    (adimensional)      '                    )
disp(' --------------------------------------'      )
% -----------------------------------------------------------


% integration of the initial value problem
% -----------------------------------------------------------

% parameters vector
param = [N beta gamma];

% initial conditions vector
IC = [S0 I0 R0 C0];

% time interval of analysis
   t0 = 1;                  % initial time (days)
   t1 = 365;                % final time   (days)
   dt = 1;                  % time steps   (days)
tspan = t0:dt:t1;           % interval of analysis
Ndt   = length(tspan);      % number of time steps

% ODE solver Runge-Kutta45
[time, y] = ode45(@(t,y)rhs_SIR(t,y,param),tspan,IC);

% time series
S = y(:,1);  % susceptible         (number of individuals)
I = y(:,2);  % infected            (number of individuals)
R = y(:,3);  % recovered           (number of individuals)
C = y(:,4);  % cumulative infected (number of individuals)
% -----------------------------------------------------------


% post-processing
% -----------------------------------------------------------

% number of time steps for a single day/week
Nsteps_day  = round(1/dt);

% time instants of interest
time_days  = time(1:Nsteps_day :end);

% news cases per day (number of individuals/day)
NewCases = C(2:Nsteps_day:end)-C(1:Nsteps_day:end-Nsteps_day);

% plot all populalations of SIR model
figure(1)
hold on
figS = plot(time,S,'DisplayName','Suscetiveis' ,'Color','b');
figI = plot(time,I,'DisplayName','Infectados'  ,'Color','r');
figR = plot(time,R,'DisplayName','Recuperados' ,'Color','g');
figC = plot(time,C,'DisplayName','Cum. de Inf.','Color','m');
hold off

% plot labels
 title('modelo SIR'    );
xlabel('tempo (dias)'          );
ylabel('numero de individuos');

% legend
leg = [figS; figI; figR; figC];
leg = legend(leg,'Location','Best');

% set plot settings
set(0,'DefaultAxesFontSize',18);
set(0,'DefaultLineLineWidth',2);
set(leg,'FontSize',10);

% axis limits
xlim([t0 t1]);
ylim([0 N]);
% -----------------------------------------------------------


CumCases = C;
NewCases = [NewCases; 0.0];
save('EpidemicData','CumCases','NewCases')