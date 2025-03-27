function [t, Y, pars_out] = SEIRD_model_ThetaSweep_notrust(Theta, times, Pars)

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







    X0 = [6.79324933636464e-22	1601.53669228161	5491198.73885451	1900139.49565449	3.75775793947786e-25	0.000250689241278175	0.517613224994917	0.106669898605298	1.28035231721317e-24	0.000149180462284527	0.292979947692886	0.0579707934727834	3.22670916638979e-24	0.000101720725537643	0.190893934098032	0.0364011976007531	0.00505433304197267	0.000189704131944006	0.199538984576924	0.0343486814063226	19885.9783981165	7.48800272678790	1.55839843002675	0.0524866149450030	234.677280168918	0.0309324545561887	0.00141386953461609	2.10171808329219e-05	5.16558499653600	0.894721520548695];    
   
    %% Run ODEs
    opts = odeset('NonNegative',1:28);

    [t,Y]=ode45(@SEIRD_model_full, times, X0, opts, pars_in); % model calc
    
    %% Outputs
    pars_out = pars_in;
end

