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


    pars_in.im = 0;

    X0 = [3.14314651819818e-46	75.3852755394965	3417729.05223799	3975111.68351799	5.21933003349204e-38	1.45589164173458e-05	0.384095970434191	0.273405101506786	2.00063728048244e-37	1.22982781576332e-05	0.300988543990615	0.210562587789043	5.84050615390522e-37	1.14556658099127e-05	0.262374001094156	0.180655147019309	0.000234298418034289	0.000267435601453902	1.80907964121237	0.925539434480657	19885.9810198587	7.49254054849768	16.8630439436645	5.46124955256164	234.677260005741	0.0309689217789166	0.0237321647888631	0.00221000792927938	5.35506431566353	-1.03170215754015];
   
    
   
    %% Run ODEs
    opts = odeset('NonNegative',1:28);

    [t,Y]=ode45(@SEIRD_model_full, times, X0, opts, pars_in); % model calc
    
    %% Outputs
    pars_out = pars_in;
end

