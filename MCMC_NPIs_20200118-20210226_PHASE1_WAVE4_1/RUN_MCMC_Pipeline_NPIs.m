close all
clear
addpath(genpath(pwd))  
%% Set MCMC Pars
CHAIN_LENGTH = 20000;
CHAIN_REP = 1;
N_CHAINS = 3;


%% Set Run Details
PARAMETER_SET = "20200118_20210226_WAVE4_1_500000";
DATE = "2025-03-18";
LIKELIHOOD_TYPE = "LL";
N_VARS = 4;

             
% for PHASE = 1:3
%% RUN
PHASE = "PHASE_ONE";
DATE = strcat(DATE);
MCMC_find_optimal_parms_for_phase(DATE, PHASE, PARAMETER_SET,LIKELIHOOD_TYPE, N_VARS, CHAIN_LENGTH, CHAIN_REP, N_CHAINS);

MCMC_Generate_Figures(DATE, PHASE, PARAMETER_SET, LIKELIHOOD_TYPE, N_VARS, 1); % Only plot the first chain
