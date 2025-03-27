function loglike = SEIRD_model_LL_logTheta(times, dYdt_target, ThetaLog, Pars, PLOT_RES)
    % Un-logTransform
    Theta = ThetaLog;

    %% Forward-simulate with parameters
    [t, y, pars_in] = SEIRD_model_ThetaSweep(Theta, times, Pars);
    

    dYdt_I_target_daily        = dYdt_target(:,1);   
    dYdt_vac_target_daily      = dYdt_target(:,3);   
    dYdt_B_target_daily        = dYdt_target(:,4);  
  
    dYdt_I_daily   = Calc_dI_dt(y, pars_in); 
    dYdt_vac_daily = Calc_dV1_dt(y,pars_in);
    dYdt_B_daily   = Calc_dB_dt(y,pars_in);
    
    xs = dYdt_I_target_daily;
    lambds = dYdt_I_daily*pars_in.alpha_rate;  
    b_nonzero = find(lambds~=0);  
    lambds = lambds(b_nonzero);
    xs = xs(b_nonzero);
    lambds = max(lambds,0);

    xvac = dYdt_vac_target_daily;
    lambdvac = dYdt_vac_daily; 

    b_nonzerovac = find(lambdvac~=0);  
    lambdvac = lambdvac(b_nonzerovac);
    xvac = xvac(b_nonzerovac);
    lambdvac = max(lambdvac,0);

    xB = dYdt_B_target_daily;
    lambdB = dYdt_B_daily; 

    b_nonzeroB = find(lambdB~=0);  
    lambdB = lambdB(b_nonzeroB);
    xB = xB(b_nonzeroB);
    lambdB = max(lambdB,0);
    





    
    %% Calculate Log-Likelihood
    % In the main call, this will be multiplied by -2.    
    RESCALE_FACTOR_infect = 1/Pars.N*10; 
    infect_factor =10;

    RESCALE_FACTOR_vac = RESCALE_FACTOR_infect;
%       RESCALE_FACTOR = 10;
    loglike = sum(logpoispdf(xs*RESCALE_FACTOR_infect*infect_factor, lambds*RESCALE_FACTOR_infect*infect_factor))+...
        sum(logpoispdf(xvac*RESCALE_FACTOR_vac*10, lambdvac*RESCALE_FACTOR_vac*10))+...
        sum(logpoispdf(xB*RESCALE_FACTOR_vac,lambdB*RESCALE_FACTOR_vac));

end