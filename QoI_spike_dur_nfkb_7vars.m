% ===========================================================================
% Function for Polynomial Chaos with fixedIC
% ===========================================================================
% Input:
% SP = Matrix RxM of system parameters 
%   R realizations of the M components
% CMP = computational model parameters
%   CMP.IC = fixed initial conditions
%   CMP.dt = time step
%   CMP.tspan = time interval for analysis
%
% Output:
% V = RxNt preys evaluated at tspan
% P = RxNt predators evaluated at tspan 
%   R realizations of the tspan components
% ===========================================================================
%  programmer: Michel Tosin
%              michel.tosin@uerj.br
%              Adriano Cortes
%              adriano@nacad.ufrj.br
%
%  last update: Jul 02, 2020
% ===========================================================================

% ===========================================================================
% Function
% ===========================================================================
  function QoI = QoI_spike_dur_nfkb_7vars(SP,CMP)
  
     % number of samples and parameters
     [Ns,Ninput] = size(SP);
     
     tspan = CMP.tspan;
     dt = CMP.dt;

     % model parameters
     IC = CMP.IC;
     IKK = CMP.IKK;

     % preallocate memory for the Quantity of Interest (QoI)
     NumQoI = 1;
     QoI = zeros(Ns,NumQoI);
     
     opts = odeset('RelTol',1.0e-5,'AbsTol',1.0e-6);

     % loop on samples for time integration
     for n = 1:Ns

         if mod(n,10) == 0
            disp(n)
         end
        
         param = [SP(n,:) IKK];
         
         % ODE solver
        [time,y] = ode15s(@(t,x)rhs_nfkb_7vars(t,x,param),tspan,IC,opts);
        
        %QoI is the spike duration of the free nuclear NF-kB concentration, 
        % defined as the time the concentration is above its mean.
        Nn_mean = mean(y(:,1));
        idx = (y(:,1) >= Nn_mean);
        spike_dur = (sum(idx)-1)*dt;

        QoI(n) = spike_dur;
        
     end
    
  end
% ===========================================================================
