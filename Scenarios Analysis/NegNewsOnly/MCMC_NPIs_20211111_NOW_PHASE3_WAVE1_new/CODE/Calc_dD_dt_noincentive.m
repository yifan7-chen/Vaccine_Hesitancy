function D_daily = Calc_dD_dt_noincentive(Y, Pars)   
    
%     %% Calculate New infections per day
%     tot_model_infections =  sum(Y(:,Pars.S_ids),2);   
%     temp_model_infections = tot_model_infections;
%     
%     dYdt_model_infections = temp_model_infections(1:(length(temp_model_infections)-1)) - ...
%         temp_model_infections(2:length(temp_model_infections));
%     
%     % Bin by week
%     dI_dt = dYdt_model_infections;

    %% Calculate New infections per day
    %D_daily = sum(Y(:,Pars.D_ids),2);
    D_daily     = diff(Y(:,Pars.D_ids));
    D_dailyv1   = diff(Y(:,Pars.Dv1_ids));
    D_dailyv2   = diff(Y(:,Pars.Dv2_ids));
    D_dailyB    = diff(Y(:,Pars.DB_ids));
    D_daily = [0.00141196119278322; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    D_daily = abs(D_daily);

end

%SEIR_model_shields_LL(pars_nyc.times,  pars_nyc.target, [0.1; 0.25; 0.25; 0.25; 100], pars_nyc, true)