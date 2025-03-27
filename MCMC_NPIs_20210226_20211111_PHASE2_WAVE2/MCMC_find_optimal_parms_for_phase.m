function res = MCMC_find_optimal_parms_for_phase(DATE_IN, PHASE_IN, PARAMETER_SET_IN, LIKELIHOOD_TYPE_IN, N_VARS_IN, CHAIN_LENGTH, CHAIN_REP, N_CHAINS)
    %% Load Data
    PHASE = PHASE_IN;
    PARAMETER_SET = PARAMETER_SET_IN;
    LIKELIHOOD_TYPE = LIKELIHOOD_TYPE_IN;
    
    if PHASE_IN == "PHASE_ONE"
        input_phase_1
        pars_in = pars_phase_1;
    elseif PHASE_IN == "PHASE_TWO"
        input_phase_2
        pars_in = pars_phase_2;
    elseif PHASE_IN == "PHASE_THREE"
        input_phase_3
        pars_in = pars_phase_3;
    else 
        print("ERROR: Can't load phase data")
    end
    
    %% Setup Data & Functions
    data.xdata = pars_in.times';
    data.ydata = [pars_in.local_target_mov, pars_in.deceased_target_mov, pars_in.vac_count]; 
    ssfun = @(Theta_in, Data_in) -2*SEIRD_model_LL_logTheta(Data_in.xdata, Data_in.ydata, Theta_in, pars_in, false); % technically is llfun
    
    % Likelihood min function (wrapper)    
    ssminfun = @(Theta_in) ssfun(Theta_in, data);

    %% Set up MCMC
    model.ssfun  = ssfun;
    model.N = length(data.ydata);  % total number of observations
    base_options.nsimu = CHAIN_LENGTH;
    base_options.waitbar = false; 
    
    % Burn-in options
    options_burnin = base_options;
    options_burnin.nsimu = CHAIN_LENGTH*CHAIN_REP; 
    % Sampling options
    options_sample = base_options;
    options_sample.nsimu = CHAIN_LENGTH;
    
    % Default Parameters

    params = {
        {'p_sp_c',                    0.5+2.5*rand(1),           0.5,          3}
        {'alpha_rate'               0.3 + 0.6*rand(1),           0.3,          1}
        {'kappa_npi_2vac',           log(100*rand(1)),    log(0.001),   log(100)}
        {'r_2vac',                       1000*rand(1),             1,       1000}
        {'threshold_2vac',             -200+300*rand(1),           -200,         100}
      
        };
    params = params(1:N_VARS_IN); % Subset for variables we're interested in.
    
    % Log-Transform
    params_log = params;
    for i_param=1:length(params)        
        for j_param=2:4
            % params_log{i_param}{j_param} = log(params_log{i_param}{j_param});
            params_log{i_param}{j_param} = params_log{i_param}{j_param};
        end        
    end
    
    ParBounds = [
        [  2    0.5     log(10)        50       1       ]; 
        [0.5    0.3     log(0.001)      1     -200   ];
        [  3      1     log(100)     1000      100   ]
        ];

    
    % LHS Sampling
    LHSamples = LHSmid(10000, ParBounds(2,1:N_VARS_IN), ParBounds(3,1:N_VARS_IN));
    LHS_ERROR = zeros(1,10000);
    parfor i=1:10000
        % init_para = log(LHSamples(i,:));
        init_para = LHSamples(i,:);
        LHS_LL(i) = ssminfun(init_para); % ssminfun takes in log-parameters 
    end
    
    % Sort & retrieve bottom N_CHAINS for initializing each chain
    [minLHS, i_minLHS] = mink(LHS_LL, N_CHAINS);   %minimum k values
    min_LHS_inits = LHSamples(i_minLHS,:); % take the smallest values
    

    % Setup Parameter bounds with initial guess of LHS sample
    for i_paramChainSetup = 1:N_CHAINS     
        temp_params = params_log;
        for i_param=1:N_VARS_IN            
            temp_params{i_param}{2} = min_LHS_inits(i_paramChainSetup, i_param);
            % temp_params{i_param}{2} = log(temp_params{i_param}{2}); % log-transform.  
            temp_params{i_param}{2} = temp_params{i_param}{2};
        end
        params_LHS{i_paramChainSetup} = temp_params;
    end
        
    %% Run MCMC
    RES_OUT = cell(1,N_CHAINS);
    parfor iter=1:N_CHAINS        
        % Modify params_in to take the optimal LHC samples     
        iter_params = params_LHS{iter};
        
        [res_burnin,chain__burnin,s2chain__burnin] = mcmcrun(model,data,iter_params,options_burnin);
        [res_sample,chain__sample,s2chain__sample] = mcmcrun(model,data,iter_params,options_sample, res_burnin);


        RES_OUT{iter} = {res_sample,chain__sample,s2chain__sample}
    end
    res = RES_OUT;
    
    %% Save results
    save(strcat("OUTPUT/", DATE_IN,"_MCMCRun_", PHASE_IN, "_", PARAMETER_SET_IN, "_", LIKELIHOOD_TYPE_IN, "_NVarsFit", int2str(N_VARS_IN), ".mat"))

end