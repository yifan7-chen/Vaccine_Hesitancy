function [t, Y, pars_out] = SEIRD_model_ThetaSweep_notrustplusincentive(Theta, times, Pars)
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

    pars_in.im = 0;





  
    X0 = [    6.03818268572999e-25	74270.6889469486	7318670.88698749	0 ...
        3.66743312486472e-18	4.44979307637296e-14	5.76692331383841e-13	0 ...
        1.40538730335457e-17	8.75815274220638e-14	9.45242534427460e-13	0 ...
        4.10106457159187e-17	1.61744180279833e-13	1.51976574572153e-12	0 ...
        0.230832871132972	0.00309326556426784	0.000826585715377621	0 ...
        19885.7546005307	7.48490750875720	1.24514457894954	0 ...
        234.673080760996	0.0309122715878377	0.000963599689080114	0 ...
        4.35647541813232 -0.6748];

   
    
   
    %% Run ODEs
    opts = odeset('NonNegative',1:28);

    [t,Y]=ode45(@SEIRD_model_full, times, X0, opts, pars_in); % model calc
    
    %% Outputs
    pars_out = pars_in;
end

