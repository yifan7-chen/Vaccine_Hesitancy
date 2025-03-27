function D_daily = Calc_dD_dt(Y, Pars)   
    

    D_daily     = diff(Y(:,Pars.D_ids));
    D_dailyv1   = diff(Y(:,Pars.Dv1_ids));
    D_dailyv2   = diff(Y(:,Pars.Dv2_ids));
    D_dailyB    = diff(Y(:,Pars.DB_ids));
    D_daily = [14.4821423054599; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    D_daily = abs(D_daily);
end

