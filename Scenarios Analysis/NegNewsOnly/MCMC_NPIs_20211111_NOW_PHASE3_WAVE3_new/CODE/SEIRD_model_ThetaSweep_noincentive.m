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



    X0 = [4.13024555712439e-17	444.645419771182	16.4683488811540	176677.467682302	1.09868890499246e-10	5.89232605282426e-10	2.73415874424181e-11	1.69951653690784e-08	4.20782669841131e-10	1.52450360394913e-09	8.73731792618160e-11	4.16255353062713e-08	1.22684041179556e-09	5.63133940240696e-09	2.82930083753804e-10	8.38494471145144e-08	46077.9820466238	811.804664430847	7254.76538428080	10783.9955851000	5201813.91833138	76618.8824239607	813306.649663700	1030528.16133296	46544.1095926455	616.401570154174	1163.56038926311	412.187860797848	-4.46211229075667	-1.02817235162220];
   
    %% Run ODEs
    opts = odeset('NonNegative',1:28);
   
    [t,Y]=ode45(@SEIRD_model_full, times, X0, opts, pars_in); % model calc
    
    %% Outputs
    pars_out = pars_in;
end
