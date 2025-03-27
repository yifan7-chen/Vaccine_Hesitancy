function D_daily = Calc_dD_dt_all(Y, Pars,handle)   

    D_daily     = diff(Y(:,Pars.D_ids));
    D_dailyv1   = diff(Y(:,Pars.Dv1_ids));
    D_dailyv2   = diff(Y(:,Pars.Dv2_ids));
    D_dailyB    = diff(Y(:,Pars.DB_ids));
    if handle ==25
        D_daily = [1.60819464467538e-06; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    elseif handle == 50
        D_daily = [1.60813192187390e-06; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    elseif handle ==75
        D_daily = [1.60808535008313e-06; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    else
        D_daily = [1.60805124942465e-06; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    end
    
    D_daily = abs(D_daily);
end

