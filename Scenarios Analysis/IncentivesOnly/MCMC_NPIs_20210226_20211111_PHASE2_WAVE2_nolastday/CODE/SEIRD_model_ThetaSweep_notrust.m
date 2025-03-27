function [t, Y, pars_out] = SEIRD_model_ThetaSweep_notrust(Theta, times, Pars)
    %% Set and Update Parameters
    pars_in = Pars;
   

    pars_in.p_sp_c        = Theta(1);
    pars_in.alpha_rate    = Theta(2);
    pars_in.q_fixbasic  = 0.66;
    pars_in.alpha       = 0.2727;   % transmission rate of asym and pre-sym

    pars_in.alpha_i     = 1;
    pars_in.ct          = 0.2273;
    pars_in.kappa_2vac    = exp(Theta(3));

    pars_in.r_2vac    = Theta(4);  

    pars_in.threshold_2vac    = Theta(5);  



    pars_in.AllContacts = pars_in.AllContacts.*pars_in.p_sp_c;

    

    X0 = [7013801.749	282280.2237	97028.10083	45.47287276	0.365509324	0.034545266	37.42538014	0.248320085	0.02200715	34.01088169	0.1890711	0.015738378	622.397585	0.296155648	0.019119513	19000.68333	0.49489067	0.029910369	219.2201907	0.001234218	2.44E-05	0.491211275];   % X0(Pars.I_ids) = X0(Pars.I_ids)/pars_in.alpha;
   
    %% Run ODEs
    opts = odeset('NonNegative',1:21);
    [t,Y]=ode45(@SEIRD_model_full, times, X0, opts, pars_in); % model calc
    
    %% Outputs
    pars_out = pars_in;
end

