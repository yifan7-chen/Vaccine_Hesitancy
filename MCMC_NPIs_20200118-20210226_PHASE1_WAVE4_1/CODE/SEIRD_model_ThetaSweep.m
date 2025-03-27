function [t, Y, pars_out] = SEIRD_model_ThetaSweep(Theta, times, Pars)
    %% Set and Update Parameters
    pars_in = Pars;
   

    pars_in.p_sp = Theta(1);
    pars_in.p_sp_c = Theta(2);

    pars_in.center1 = Theta(3);

    pars_in.q_fixbasic = 0.66;
    pars_in.alpha_rate = Theta(4);

    pars_in.alpha = 0.2727;   % transmission rate of asym and pre-sym

    pars_in.alpha_i = 1;

    pars_in.ct = 0.2273;





    
    X0 = pars_in.X0_target;

   
    %% Run ODEs
    opts = odeset('NonNegative',1:7);

    [t,Y]=ode45(@SEIRD_model_full, times, X0, opts, pars_in); % model calc
    
    %% Outputs
    pars_out = pars_in;
end

