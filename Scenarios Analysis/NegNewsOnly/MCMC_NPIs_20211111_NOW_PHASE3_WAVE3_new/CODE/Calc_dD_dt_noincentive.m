function D_daily = Calc_dD_dt_noincentive(Y, Pars)   
    

    D_daily     = diff(Y(:,Pars.D_ids));
    D_dailyv1   = diff(Y(:,Pars.Dv1_ids));
    D_dailyv2   = diff(Y(:,Pars.Dv2_ids));
    D_dailyB    = diff(Y(:,Pars.DB_ids));
    D_daily = [14.3387676775005; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    D_daily = abs(D_daily);

end

