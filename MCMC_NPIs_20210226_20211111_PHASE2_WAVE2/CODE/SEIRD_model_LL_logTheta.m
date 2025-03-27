function loglike = SEIRD_model_LL_logTheta(times, dYdt_target, ThetaLog, Pars, PLOT_RES)
    % Un-logTransform
    % Theta = exp(ThetaLog);
    Theta = ThetaLog;

    %% Forward-simulate with parameters
    [t, y, pars_in] = SEIRD_model_ThetaSweep(Theta, times, Pars);
    
    %% Calculate New infections per Day    
    dYdt_I_target_daily = dYdt_target(:,1);   
    dYdt_vac_target_daily = dYdt_target(:,3);   
  
    dYdt_I_daily   = Calc_dI_dt(y, pars_in);  
    dYdt_vac_daily = Calc_dV1_dt(y,pars_in);
    
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
    




    
    %% Calculate Log-Likelihood
    % In the main call, this will be multiplied by -2.    
    RESCALE_FACTOR_infect = 1/Pars.N*3000000; 

    RESCALE_FACTOR_vac = RESCALE_FACTOR_infect/1000;

    loglike = sum(logpoispdf(xs*RESCALE_FACTOR_infect, lambds*RESCALE_FACTOR_infect))+...
        sum(logpoispdf(xvac*RESCALE_FACTOR_vac, lambdvac*RESCALE_FACTOR_vac));

end