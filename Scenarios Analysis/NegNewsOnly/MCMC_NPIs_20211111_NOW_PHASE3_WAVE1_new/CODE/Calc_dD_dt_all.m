function D_daily = Calc_dD_dt_all(Y, Pars,handle)   
    
    D_daily     = diff(Y(:,Pars.D_ids));
    D_dailyv1   = diff(Y(:,Pars.Dv1_ids));
    D_dailyv2   = diff(Y(:,Pars.Dv2_ids));
    D_dailyB    = diff(Y(:,Pars.DB_ids));
    if handle ==25
        D_daily = [0.000244413060242840; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    elseif handle == 50
        D_daily = [0.000251173411038835; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    elseif handle == 75
        D_daily = [0.000316369921593206; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    elseif handle == 85
        D_daily = [0.000264875950510818; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    elseif handle == 90
        D_daily = [0.000272631704530614; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    else
        D_daily = [0.000281441472143548; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    end
    
    D_daily = abs(D_daily);
end

