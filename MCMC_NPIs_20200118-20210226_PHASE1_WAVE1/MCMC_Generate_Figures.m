function out_plots = MCMC_Generate_Figures(DATE_IN, PHASE_IN, PARAMETER_SET_IN, LIKELIHOOD_TYPE_IN, N_VARS_IN, PLOT_CHAIN_NUM)
    % PLOT_CHAIN_NUM: 1 is fminsearch initial conditions; >1 is the actual
    % chains, but note indices are 1-shifted. Chain 2 is PLOT_CHAIN_NUM=3

    if isfile(strcat("OUTPUT/", DATE_IN,"_MCMCRun_", PHASE_IN, "_", PARAMETER_SET_IN, "_", LIKELIHOOD_TYPE_IN, "_NVarsFit", int2str(N_VARS_IN), ".mat"))
        load(strcat("OUTPUT/", DATE_IN,"_MCMCRun_", PHASE_IN, "_", PARAMETER_SET_IN, "_", LIKELIHOOD_TYPE_IN, "_NVarsFit", int2str(N_VARS_IN), ".mat"))    

        t1 = figure(1); clf;
        mcmcplot(res{PLOT_CHAIN_NUM}{2},[],res{PLOT_CHAIN_NUM}{1},'chainpanel');
        set(gcf,'Position',[50 50 900 700])
        saveas(t1, strcat('OUTPUT/', PHASE_IN, '/', DATE_IN, '_', PHASE_IN, '_', PARAMETER_SET_IN, '_', LIKELIHOOD_TYPE_IN, "_NVarsFit", int2str(N_VARS_IN), '_', int2str(PLOT_CHAIN_NUM), '_chainpanel.png'));

        if N_VARS_IN < 10
            t2 = figure(2); clf;
            mcmcplot(res{PLOT_CHAIN_NUM}{2},[],res{PLOT_CHAIN_NUM}{1},'pairs');
            set(gcf,'Position',[50 50 900 700])
            saveas(t2, strcat('OUTPUT/', PHASE_IN, '/', DATE_IN, '_', PHASE_IN, '_',  PARAMETER_SET_IN, '_', LIKELIHOOD_TYPE_IN, "_NVarsFit", int2str(N_VARS_IN), '_', int2str(PLOT_CHAIN_NUM), '_pairs.png'));
        else
            "Too Many Variables - Skipping Pairplots"
        end
% 
        temp_res = res;
        Chains = cellfun(@(x) x{2}, temp_res, 'un', 0);
        Ress = cellfun(@(x) x{1}, temp_res, 'un', 0);

        t5 = plot_MCMC_results_fig2(500, Chains, ["I"], pars_in, Ress, PHASE_IN);
        
        if N_VARS_IN == 5
            saveas(t5, strcat('OUTPUT/', PHASE_IN, '/', DATE_IN, '_', PHASE_IN, '_',  PARAMETER_SET_IN, '_', LIKELIHOOD_TYPE_IN, "_NVarsFit", int2str(N_VARS_IN), '_', int2str(PLOT_CHAIN_NUM), '_fits_fig2.png'));
        else
            saveas(t5, strcat('OUTPUT/', PHASE_IN, '/', DATE_IN, '_', PHASE_IN, '_',  PARAMETER_SET_IN, '_', LIKELIHOOD_TYPE_IN, "_NVarsFit", int2str(N_VARS_IN), '_', int2str(PLOT_CHAIN_NUM), '_fits.png'));
        end

    else
        'WARNING: MISSING .mat FILE. DOUBLE CHECK INPUTS'
    end
end
