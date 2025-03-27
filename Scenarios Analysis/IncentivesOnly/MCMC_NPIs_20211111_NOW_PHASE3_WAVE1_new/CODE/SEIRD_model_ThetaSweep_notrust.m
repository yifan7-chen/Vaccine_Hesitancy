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
    pars_in.threshold1_2B        =   Theta(11); 


  
    X0 = [   6.99893288270723e-25	73140.9982220639	7319800.57565224	0 ...
       3.19295602496609e-18	4.14135910714305e-14	5.44909496173143e-13	0 ...
       1.22358550476974e-17	8.15253886440787e-14	8.93451700154834e-13	0 ...
       3.57064225750736e-17	1.50564771021255e-13	1.43651731329594e-12	0 ...
       0.230827564935937	0.00309405078123313	0.000826230968727049	0 ...
       19885.7567649465	7.48479804475469	1.24509568092403	0 ...
       234.673140107006	0.0309119167785091	0.000963565249601058	0 ...
       4.64339458202668 -0.6748];
    
   
    %% Run ODEs
    opts = odeset('NonNegative',1:28);

    [t,Y]=ode45(@SEIRD_model_full, times, X0, opts, pars_in); % model calc
    
    %% Outputs
    pars_out = pars_in;
end

