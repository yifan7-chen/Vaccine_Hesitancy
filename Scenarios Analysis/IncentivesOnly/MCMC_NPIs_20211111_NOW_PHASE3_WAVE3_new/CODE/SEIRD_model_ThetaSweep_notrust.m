function [t, Y, pars_out] = SEIRD_model_ThetaSweep_notrust(Theta, times, Pars)
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




    X0 = [2.01570964530976e-46	74.2386493533311	3421238.55796151	3971604.29201687	5.03783524118810e-38	1.38057802337627e-05	0.370225394261827	0.263038031761402	1.93106959430994e-37	1.16611730141875e-05	0.290091781651302	0.202564797942929	5.63742285279687e-37	1.08614510229365e-05	0.252853675500937	0.173782830315377	0.000234293034511870	0.000253453546711166	1.74165571858776	0.889863512619414	19885.9831788861	7.49218940747276	16.2698990185188	5.24852467538059	234.677319439317	0.0309665953303920	0.0228674722684473	0.00212392440017107	5.45277122867857	-1.03354500846708];    
   
    %% Run ODEs
    opts = odeset('NonNegative',1:28);
    % opts = odeset('RelTol',1e-2,'AbsTol',1e-5);
    [t,Y]=ode45(@SEIRD_model_full, times, X0, opts, pars_in); % model calc
    
    %% Outputs
    pars_out = pars_in;
end
