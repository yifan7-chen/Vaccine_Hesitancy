function [t, Y, pars_out] = SEIRD_model_ThetaSweep_notrust_initial(Theta, times, Pars)
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
    
    X0 = [6594804.67112955	540384.046071265	257839.107795338	18.8836188854567	0.471145937847612	0.0549633868220273	17.5198842079864	0.354037483330639	0.0406726807974358	17.8762462490082	0.294590768877034	0.0330978896738070	473.459617048133	0.712809094926719	0.0645272689524229	19288.2364225703	1.40381265090341	0.116891940795980	223.648359783068	0.00450702736740433	9.53843434432702e-05	1.77142062443021];   % X0 = [1.61244524128854e-07	513672.217741711	6880723.55814267	6.05540929863870e-10	3.88239629527540e-08	7.27238392362426e-08	2.21139690459822e-09	6.53765137419546e-08	1.04786176136148e-07	6.04291685325245e-09	1.05729101038338e-07	1.51044918450247e-07	1.51697361877214	0.0234461684357222	0.00643039370458228	18445.6457112598	8.50483326226762	1.43985078004476	218.050576883085	0.0351775281786992	0.00111501622750615	1.14953064805419];
   
    %% Run ODEs
    opts = odeset('NonNegative',1:21,'AbsTol',1e-16);
    [t,Y]=ode45(@SEIRD_model_full, times, X0, opts, pars_in); % model calc
    
    %% Outputs
    pars_out = pars_in;
end

