function [t, Y, pars_out] = SEIRD_model_ThetaSweep(Theta, times, Pars)
    %% Set and Update Parameters
    pars_in = Pars;
   
    pars_in.alpha       = 0.2727;   % transmission rate of asym and pre-sym

    pars_in.alpha_i     = 1;
    pars_in.ct          = 0.2273;
    pars_in.q_fixbasic  = 0.66;  %0.83
    
    pars_in.alpha_rate          =   Theta(1);
    pars_in.p_sp                =   Theta(2);
    pars_in.p_sp_c              =   Theta(3);

    pars_in.center1           =   Theta(4);


    pars_in.kappa_2vac          =   exp(Theta(5));
    pars_in.kappa_2B            =   exp(Theta(6));

    pars_in.r_2vac              =   Theta(7);  
    pars_in.r_2B                =   Theta(8);  

    pars_in.threshold_2vac      =   Theta(9);  


    pars_in.threshold_2B        =   Theta(10); 
    pars_in.threshold1_2B        =   Theta(11); 
    pars_in.im = 0;



    X0 = pars_in.X0_target;
   
    %% Run ODEs
    opts = odeset('NonNegative',1:28);

    [t,Y]=ode45(@SEIRD_model_full, times, X0, opts, pars_in); % model calc
    
    %% Outputs
    pars_out = pars_in;
end
