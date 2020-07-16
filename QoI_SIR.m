% -----------------------------------------------------------------
%  QoI_SIR.m
% -----------------------------------------------------------------
%  This function computes the quantity of interest (QoI) for
%  a given SIR system.
% -----------------------------------------------------------------
%  Input:
%  X - model parameters
%  P - model hyperparameters
%
%  Output:
%  QoI - quantity of interest
% -----------------------------------------------------------------
%  programmers: Michel Tosin
%               michel.tosin@uerj.br
%
%  last update: Mar 20, 2020
% -----------------------------------------------------------------

% -----------------------------------------------------------------
function QoI = QoI_SIR(X,P)

    % number of samples and parameters
    [Ns,Ninput] = size(X);
  
    % model time interval of analysis (years)
    tspan = P.tspan;

    % model initial conditions
    %IC = P.IC;

    N = P.N;
    R0 = P.R0;

    D = N - R0;

    % subset of the temporal mesh with the years indices
    %tQoI = P.tQoI;
    
    % number of ineteger years in the temporal mesh
    %NtQoI = P.NtQoI;
    
    % model input parameters (random variables)
    B = P.Mean(1) + P.Std(1)*X(:,1);
    A = P.Mean(2) + P.Std(2)*X(:,2);
    I0 = P.Mean(3) + P.Std(3)*X(:,3);     
    
    % preallocate memory for the Quantity of Interest (QoI)
    Nint = length(tspan(2:end));
    QoI = zeros(Ns,Nint);
    %opts = odeset('RelTol',1.0e-9,'AbsTol',1.0e-10);
    
    % loop on samples for time integration
    for n=1:Ns
		
	IC = [(D-I0(n)) I0(n) R0];

        % Predator Prey equation right hand side
        dYdt = @(t,Y) [-B(n)*Y(1).*Y(2)/N;
                       (B(n)*Y(1).*Y(2)/N - A(n)*Y(3));
		        A(n)*Y(3)];
                   
        % ODE solver Runge-Kutta45
        [time,Y] = ode45(dYdt,tspan,IC); %,opts
        
        % number of infected in time
        QoI(n,:) = Y(2:end,2);
        
     end
    
        
end
% -----------------------------------------------------------------
