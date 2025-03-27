function [t, Y, pars_out] = SEIRD_model_ThetaSweep_noincentive(Theta, times, Pars)
    %% Set and Update Parameters
    pars_in = Pars;
   
    pars_in.alpha       = 0.2727;   % transmission rate of asym and pre-sym

    pars_in.alpha_i     = 1;
    pars_in.ct          = 0.2273;
    pars_in.q_fixbasic  = 0.66;
    
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





    X0 = [    5435677.29695392	42669.4567237472	1914549.15786968	0 ...
        0.102576675588254	0.000350204126864219	0.00285299835054969	0 ...
        0.0842828799159521	0.000294775004128381	0.00234018987776975	0 ...
        0.0765467294086855	0.000273780103339018	0.00212324672296850	0 ...
        0.981507828616593	0.00662763691151518	0.0195503066931192	0 ...
        19931.8729767786	4.92103386309783	1.27643697270216	0 ...
        235.718098313800	0.0199714536687558	0.000904428145280403	0 ...
        -3.76508317988992 -0.6748];
        
    

   
    %% Run ODEs
    opts = odeset('NonNegative',1:28,'AbsTol',1e-16);

    [t,Y]=ode45(@SEIRD_model_full, times, X0, opts, pars_in); % model calc
    
    %% Outputs
    pars_out = pars_in;
end

