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

    pars_in.im=0;



    X0 = [1.05936512724097e-21	1626.27299719694	5489858.15185246	1901455.27621882	3.89131204260999e-25	0.000264856246526093	0.538416834784052	0.111059682287561	1.32382602650467e-24	0.000157593481568830	0.304709348724424	0.0603441896662418	3.33390139526159e-24	0.000107558578542230	0.198762696121837	0.0379403096523241	0.00505444917908216	0.000196413144996303	0.207361428268436	0.0357339939483659	19885.9762389792	7.48812220685813	1.57056703843101	0.0545841158750019	234.677220734491	0.0309328918771584	0.00143133474228309	2.18570769111753e-05	5.01095456137068	0.896682801765413]; 
   
    %% Run ODEs
    opts = odeset('NonNegative',1:28);
    [t,Y]=ode45(@SEIRD_model_full, times, X0, opts, pars_in); % model calc
    
    %% Outputs
    pars_out = pars_in;
end

