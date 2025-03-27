function [t, Y, pars_out] = SEIRD_model_ThetaSweep_noincentive(Theta, times, Pars)
    %% Set and Update Parameters
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








    X0 = [0.00703836756885785	9685.67287055364	358.725073565610	167862.871014617	201.880611559777	186.287419454011	28.9975312143431	1132.20330058874	686.014015893361	323.064388801754	94.3810289432646	2034.40358905468	1719.32834162827	497.033797436620	237.926264503255	3396.47326306949	992680.370984522	16920.6673878023	156316.869169339	228745.220955870	4260339.66244490	59549.7833968573	664098.368994206	805421.274273377	38808.7535374660	477.343057787515	946.235072674289	321.181472351616	-2.71059674940309	0.900721497850938];    

        
   
    %% Run ODEs
    opts = odeset('NonNegative',1:28);
    [t,Y]=ode45(@SEIRD_model_full, times, X0, opts, pars_in); % model calc
    
    %% Outputs
    pars_out = pars_in;
end

