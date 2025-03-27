function loglike = SEIRD_model_LL_logTheta(times, dYdt_target, ThetaLog, Pars, PLOT_RES)
    % Un-logTransform
    % Theta = exp(ThetaLog);
    Theta = ThetaLog;

    %% Forward-simulate with parameters
    [t, y, pars_in] = SEIRD_model_ThetaSweep(Theta, times, Pars);
    
    %% Calculate New infections per Day    
    % dYdt_asym_target_daily = dYdt_target(:,1);   
    dYdt_I_target_daily = dYdt_target(:,1);   

    dYdt_I_daily = Calc_dI_dt(y, pars_in);  

    xs = dYdt_I_target_daily;
    lambds = dYdt_I_daily*pars_in.alpha_rate; 
    b_nonzero = find(lambds~=0);  
    lambds = lambds(b_nonzero);
    xs = xs(b_nonzero);
    lambds = max(lambds,0);
    


    
    %% Calculate Log-Likelihood
    % In the main call, this will be multiplied by -2.    
    RESCALE_FACTOR_infect = 1/Pars.N*500000; 

    loglike = sum(logpoispdf(xs*RESCALE_FACTOR_infect, lambds*RESCALE_FACTOR_infect));

end