% % Calculate the Gelman-Rubin diagnostic
% R = gelman_rubin(chain);
% 
% % Display the results
% disp(R);
% 
% 
% function R = gelman_rubin(chain)
% Compute the Gelman-Rubin diagnostic for a MCMC chain
rng(1)

n_chains = size(res, 2);
n_samples = size(res{1,1}{1,2}, 1);
n_params = size(res{1,1}{1,2}, 2);

% Calculate the between-chain variance
mean_chain = [mean(res{1,1}{1,2});
    mean(res{1,2}{1,2})
    mean(res{1,3}{1,2})]; % mean of each parameter over all chains
mean_all = mean(mean_chain, 1); % mean of all parameters over all chains
B = n_samples / (n_chains - 1) * sum((mean_chain - mean_all).^2, 1);

% Calculate the within-chain variance
var_chain = [var(res{1,1}{1,2});
    var(res{1,2}{1,2})
    var(res{1,3}{1,2})];
W = 1/n_chains * sum(var_chain, 1);

% Calculate the estimated variance of the posterior distribution
var_hat = (n_samples - 1) / n_samples * W + 1 / n_samples * B;

% Calculate the potential scale reduction factor (PSRF)
R = sqrt(var_hat ./ W)

% MCMC_Generate_Figures(DATE, PHASE, PARAMETER_SET, LIKELIHOOD_TYPE, N_VARS, 1);

PLOT_CHAIN_NUM = 1;
% t2 = figure(1); clf;
% mcmcplot(res{PLOT_CHAIN_NUM}{2},[],res{PLOT_CHAIN_NUM}{1},'chainpanel');
% set(gcf,'Position',[50 50 900 700])

temp_res = res;
Chains = cellfun(@(x) x{2}, temp_res, 'un', 0);
Ress = cellfun(@(x) x{1}, temp_res, 'un', 0);

% t5 = plot_MCMC_results_fig2(100, Chains, ["I"], pars_in, Ress, PHASE_IN);
% NSamples, Chains, Comps, Pars, Ress, PHASE



NSamples = 500;
Comps = ["I","V1"];
% Comps = ["I"];
% Comps = ["V1"]
Pars = pars_in;

if PHASE == "PHASE_ONE"
    phase_name = 'Phase 1';
elseif PHASE == "PHASE_TWO"
    phase_name = 'Phase 2';
elseif PHASE == "PHASE_THREE"
    phase_name = 'Phase 3';
end

% For all Chains
out = figure('Name', 'Res', 'Position', [50 50 900 700]); clf    
k = 2;
Chain = Chains{k};
Res = Ress{k};

% mean([Ress{1}.mean;Ress{2}.mean;Ress{3}.mean])

% Take full chain
burnIn = floor(length(Chain)/2);% floor(length(Chain)/2); % Was originally sample half.
burnOut = burnIn:length(Chain);
chain_out = Chain(burnOut,:);
% res_out = Res(burnOut,:);

i_samp = randi([1, length(burnOut)], 1,NSamples);
chain_samp = chain_out(i_samp,:);

chainst = chainstats(chain_out,Res);


% Change plot position
x0 = 50;
y0 = 50;
width = 900;
height = 700;


%% no trust + no incentive


chain_out_notrustplusincentive = chain_out;
chain_out_notrustplusincentive(:,6) = normrnd(48.90534418,29.82188402,[length(burnOut),1]);
chain_out_notrustplusincentive(:,7:10) = zeros(length(burnOut),4);


i_samp = randi([1, length(burnOut)], 1,NSamples);
chain_samp_notrustplusincentive = chain_out_notrustplusincentive(i_samp,:);

[t_notrustplusincentive, Y_notrustplusincentive, pars_out_notrustplusincentive] = SEIRD_model_ThetaSweep_notrust_initial(median(chain_out_notrustplusincentive)', pars_phase_2.times, pars_phase_2);

diffIsym_notrustplusincentive =  Calc_dI_dt_notrust(Y_notrustplusincentive, Pars);
diffD_notrustplusincentive=  Calc_dD_dt_notrust(Y_notrustplusincentive, Pars);
diffV_notrustplusincentive = Calc_dV1_dt_notrust(Y_notrustplusincentive,Pars);

hold on

for j = 1:length(Comps)
    j_comp = Comps(j);

    % Subplot based on the # of components
    subplot(length(Comps), 1, j)
    sgtitle(phase_name, 'FontWeight', 'bold', 'FontSize', 30);
    set(gca,'linewidth',1, 'fontsize', 18);
    set(gcf, 'position', [x0,y0,width,height])
    hold on

    % Plot the mean chain

    mean_fit = SEIRD_model_Theta(Res.mean, Pars.times, Pars, j_comp, true).';
    % Sample the rest
    for i = 1:NSamples
        i_th = chain_samp_notrustplusincentive(i,:);
        sampled_fits(i,:) = SEIRD_model_Theta_notrust(i_th, Pars.times, Pars, j_comp, true);
    end

    % x values
    ts = 1:size(sampled_fits,2); % I can only do this b/c I set days as the unit
    ts = ts+Pars.t0;

    % y values
    mean_sampled_fits = mean(sampled_fits);
    std_sampled_fits = std(sampled_fits);

    ci_higher_sampled_fits = mean_sampled_fits + 1.96*std_sampled_fits;
    ci_lower_sampled_fits = mean_sampled_fits - 1.96*std_sampled_fits;
    ci_lower_sampled_fits = max(ci_lower_sampled_fits,0);

    % plots
    fill([ts, fliplr(ts)], ...
        [ci_higher_sampled_fits, fliplr(ci_lower_sampled_fits)], ...
        [0.7, 0.7, 0.7],'LineStyle','none','HandleVisibility','off','FaceAlpha',0.3)

    plot(ts, ci_higher_sampled_fits, '-.', 'LineWidth', 1, 'Color', [1, 0, 1], ...
        'HandleVisibility','off');
    plot(ts, ci_lower_sampled_fits, '-.', 'LineWidth', 1, 'Color', [1, 0, 1], ...
        'HandleVisibility','off');
    plot(ts, mean_sampled_fits, 'LineWidth', 2, 'Color', [0 0 0], ...
        'HandleVisibility','off');

    % For certain components, add additional information to the plot.
    ylabel_xpos = -30;

    if j_comp == "S"            % If we're plotting S, include sero
        plot(Pars.tSero+Pars.t0, (1-Pars.sero/100)*Pars.N, 's', 'Color', [1 0 0], ...
            'MarkerFaceColor',[1 0 0], 'DisplayName', 'S')
        ylabel('Cumulative susceptible','fontweight','bold')

    elseif j_comp == "E"        % Exposed
        ylabel('Exposed individuals','fontweight','bold')

    elseif j_comp == "Isym"    % Infected
        plot(ts, Pars.infect_target, 's', 'Color', [.6 0 0], 'MarkerSize', 15, ...
            'MarkerFaceColor',[1 0 0], 'DisplayName', 'Serology data')
        legend({'Reported cases(local)'},'Location','southeast', 'fontsize', 18)
        legend boxoff
        yl=ylabel('Infected individuals','fontweight','bold');
        pos=get(yl,'Pos');
        set(yl,'Pos',[ylabel_xpos pos(2) pos(3)]);
    elseif j_comp == "A"    % Infected
        plot(ts, Pars.asym_local_target, 's', 'Color', [.6 0 0], 'MarkerSize', 15, ...
            'MarkerFaceColor',[1 0 0], 'DisplayName', 'Serology data')
        legend({'Serology data'},'Location','southeast', 'fontsize', 18)
        legend boxoff
        yl=ylabel('Infected individuals','fontweight','bold');
        pos=get(yl,'Pos');
        set(yl,'Pos',[ylabel_xpos pos(2) pos(3)]); 
    elseif j_comp == "I"    % Infected
        plot(ts, Pars.local_target_mov, 's', 'Color', '#d63031', 'MarkerSize', 10, ...
         'MarkerFaceColor','#d63031',    'DisplayName', 'Serology data')
        legend({'Reported cases(local symptomatic)'},'Location','northwest', 'fontsize', 18)
        legend boxoff
        yl=ylabel('Infected individuals','fontweight','bold');
        pos=get(yl,'Pos');
        set(yl,'Pos',[ylabel_xpos pos(2) pos(3)]);
        hold on 
        plot(ts, diffIsym_notrustplusincentive, 's', 'Color', '#0984e3', 'MarkerSize', 10, ...
    'MarkerFaceColor','#0984e3', 'DisplayName', 'Serology data')
        infect_notrustplusincentive_CI = [mean_sampled_fits' ci_higher_sampled_fits' ci_lower_sampled_fits' Pars.local_target_mov];

    elseif j_comp == "R"        % If we're plotting R, include sero
        plot(Pars.tSero+Pars.t0, Pars.sero/100*Pars.N, 's', 'Color', [.6 0 0], 'MarkerSize', 15, ...
            'MarkerFaceColor',[1 0 0], 'DisplayName', 'Serology data')
        legend({'Serology data'},'Location','southeast', 'fontsize', 18)
        legend boxoff
        yl=ylabel('Recovered','fontweight','bold');
        pos=get(yl,'Pos');
        set(yl,'Pos',[ylabel_xpos pos(2) pos(3)]);

    elseif j_comp == "D"        % If deaths, include data
        plot(ts, Pars.deceased_target, 's', 'Color', [0.2, 0.3, 0.6], 'MarkerSize', 15, ...
            'MarkerFaceColor', [0.3, 0.5, 0.9], 'DisplayName', 'Death data')
        legend({'Death data'},'Location','southeast',  'fontsize', 18)
        legend boxoff
        yl=ylabel('Deaths','fontweight','bold');
        pos=get(yl,'Pos');
        set(yl,'Pos',[ylabel_xpos pos(2) pos(3)]);


    elseif j_comp == "V1"    % Infected
        plot(ts, Pars.vac_count, 's', 'Color', '#8e44ad', 'MarkerSize', 10, ...
         'MarkerFaceColor','#d63031',    'DisplayName', 'Serology data')
        legend({'Reported cases(local symptomatic)'},'Location','northwest', 'fontsize', 18)
        legend boxoff
        yl=ylabel('Infected individuals','fontweight','bold');
        pos=get(yl,'Pos');
        set(yl,'Pos',[ylabel_xpos pos(2) pos(3)]);
        hold on 
        plot(ts, diffV_notrustplusincentive, 's', 'Color', '#0984e3', 'MarkerSize', 10, ...
    'MarkerFaceColor','#0984e3', 'DisplayName', 'Serology data')
        V1_notrustplusincentive_CI = [mean_sampled_fits' ci_higher_sampled_fits' ci_lower_sampled_fits' Pars.vac_count];
    end
    ylim([0, Inf])
    xlim([Pars.t0, Pars.tf])


    box on
end


[mean(chain_out)' median(chain_out)' min(chain_out)' max(chain_out)']
