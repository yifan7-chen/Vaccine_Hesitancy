function D_daily = Calc_dD_dt(Y, Pars)   
    
    %% Calculate New infections per day

    D_daily = diff(Y(:,Pars.D_ids));
    D_daily = [0;D_daily];
    
end

