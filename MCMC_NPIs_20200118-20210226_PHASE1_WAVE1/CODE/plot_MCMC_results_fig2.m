function out = plot_MCMC_results_fig2(NSamples, Chains, Comps, Pars, Ress, PHASE)
%% Predictions from MCMC

if PHASE == "PHASE_ONE"
    phase_name = 'Phase 1';
elseif PHASE == "PHASE_TWO"
    phase_name = 'Phase 2';
elseif PHASE == "PHASE_THREE"
    phase_name = 'Phase 3';
end

% For all Chains
out = figure('Name', 'Res', 'Position', [6 6 1000 1000]); clf    
k = 2;
Chain = Chains{k};
Res = Ress{k};

% Take full chain
burnIn = floor(length(Chain)/2);% floor(length(Chain)/2); % Was originally sample half.
burnOut = burnIn:length(Chain);
chain_out = Chain(burnOut,:);

i_samp = randi([1, length(burnOut)], 1,NSamples);
chain_samp = chain_out(i_samp,:);

% Change plot position
x0 = 50;
y0 = 50;
width = 900;
height = 700;

% Plot by component.
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
        i_th = chain_samp(i,:);
        sampled_fits(i,:) = SEIRD_model_Theta(i_th, Pars.times, Pars, j_comp, true);
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
        [0.7, 0.7, 0.7],'LineStyle','none','HandleVisibility','off')
    
    plot(ts, ci_higher_sampled_fits, '-.', 'LineWidth', 1, 'Color', [0.3, 0.3, 0.3], ...
        'HandleVisibility','off');
    plot(ts, ci_lower_sampled_fits, '-.', 'LineWidth', 1, 'Color', [0.3, 0.3, 0.3], ...
        'HandleVisibility','off');
    plot(ts, mean_sampled_fits, 'LineWidth', 2, 'Color', [0 0 0], ...
        'HandleVisibility','off');
    
    % For certain components, add additional information to the plot.
    ylabel_xpos = -30;



        plot(ts, Pars.local_target_mov, 's', 'Color', '#d63031', 'MarkerSize', 10, ...
         'MarkerFaceColor','#d63031',    'DisplayName', 'Serology data')
        legend({'Reported cases'},'Location','northwest', 'fontsize', 18)
        legend boxoff
        yl=ylabel('Infected individuals','fontweight','bold');
        pos=get(yl,'Pos');
        set(yl,'Pos',[ylabel_xpos pos(2) pos(3)]);        
        
    end
    ylim([0, Inf])
    xlim([Pars.t0, Pars.tf])
    
    
    box on
end

