% -----------------------------------------------------------------
%  QoI_PredatorPrey.m
% -----------------------------------------------------------------
%  This function computes the quantity of interest (QoI) for
%  the following Predator Prey system.
% -----------------------------------------------------------------
%
%  dPrey/dt = a*Prey - b*Prey*Pred,
%  dPred/dt = -c*Pred + d*Prey*Pred
%
%  Input:
%  X - model parameters
%    -> a
%    -> b
%    -> c
%    -> d
%  P - model hyperparameters
%    -> mean  - double [4x1]
%    -> std   - double [4x1]
%    -> IC    - double [2x1]
%    -> tspan - double [*x1]
%
%  Output:
%  QoI - quantity of interest
%
% -----------------------------------------------------------------
%  programmers: Michel Tosin
%               michel.tosin@uerj.br
%
%               Americo Cunha Jr
%               americo@ime.uerj.br
%
%               Adriano Côrtes
%               adriano@caxias.ufrj.br
%
%  last update: Apr 06, 2020
% -----------------------------------------------------------------

% -----------------------------------------------------------------
  function QoI = QoI_PredatorPrey(X,P)
  
    % number of samples and parameters
      [Ns,Ninput] = size(X);
  
    % model time interval of analysis (years)
      tspan = P.tspan;

    % model initial conditions
      IC = P.IC;
      
    % model input parameters (random variables)
      A = P.Mean(1) + P.Std(1)*X(:,1); 
      B = P.Mean(2) + P.Std(2)*X(:,2);   % normalizing random 
      C = P.Mean(3) + P.Std(3)*X(:,3);   % variables is a
      D = P.Mean(4) + P.Std(4)*X(:,4);   % good practice
    
    % preallocate memory for the Quantity of Interest (QoI)
      Nint = length(tspan(2:end)); % number of instants of interest
      QoI = zeros(Ns,Nint);        % prealocation
    
    % loop on samples for time integration
      for n=1:Ns
    
        % Predator Prey equation right hand side
          dYdt = @(t,Y) [Y(1).*( A(n)-B(n)*Y(2));    % predator-prey
                         Y(2).*(-C(n)+D(n)*Y(1))];   % ODE system
                   
        % ODE solver Runge-Kutta45
          [time,Y] = ode45(dYdt,tspan,IC);
        
        % number of Prey at integer years
        QoI(n,1:Nint) = Y(2:end,1);   
        %QoI(n,1:Nint) = Y(2:end,2); % for predators   
        
      end
      
  end
% -----------------------------------------------------------------
