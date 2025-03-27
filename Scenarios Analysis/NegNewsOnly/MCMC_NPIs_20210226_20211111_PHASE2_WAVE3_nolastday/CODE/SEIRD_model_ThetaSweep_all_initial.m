function [t, Y, pars_out] = SEIRD_model_ThetaSweep_all_initial(Theta, times, Pars,handle)
    %% Set and Update Parameters
    pars_in = Pars;
   

    pars_in.p_sp_c        = Theta(1);
    pars_in.alpha_rate    = Theta(2);
    pars_in.center_vac    = Theta(3);
    pars_in.q_fixbasic  = 0.66;
    pars_in.alpha       = 0.2727;   % transmission rate of asym and pre-sym
    pars_in.alpha_i     = 1;
    pars_in.ct          = 0.2273;
    pars_in.kappa_2vac    = exp(Theta(4));
    pars_in.r_2vac    = Theta(5);  
    pars_in.threshold_2vac    = Theta(6);  
    pars_in.threshold1_2vac   = Theta(7);  
    pars_in.threshold2_2vac   = Theta(8);  
    pars_in.threshold3_2vac   = Theta(9);  
    pars_in.threshold4_2vac   = Theta(10);      



    pars_in.AllContacts = pars_in.AllContacts.*pars_in.p_sp_c;

    if handle  ==25
        X0 = pars_in.X0_target;
    elseif handle ==50
        X0 = pars_in.X0_target;
    elseif handle ==75
        X0 = pars_in.X0_target;
    elseif handle ==85
        X0 = pars_in.X0_target;
    elseif handle ==90
        X0 = pars_in.X0_target;
    else 
        X0 = pars_in.X0_target;
    end

   
    %% Run ODEs
    opts = odeset('NonNegative',1:21,'AbsTol',1e-16);
    [t,Y]=ode45(@SEIRD_model_full, times, X0, opts, pars_in); % model calc
    
    %% Outputs
    pars_out = pars_in;
end
