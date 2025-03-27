function D_daily = Calc_dD_dt_all(Y, Pars,handle)   

    D_daily     = diff(Y(:,Pars.D_ids));
    D_dailyv1   = diff(Y(:,Pars.Dv1_ids));
    D_dailyv2   = diff(Y(:,Pars.Dv2_ids));
    D_dailyB    = diff(Y(:,Pars.DB_ids));
    if handle ==25
        D_daily = [3.40440542592105e-06; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    elseif handle == 50
        D_daily = [1.62736593052998e-05; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    elseif handle ==75
        D_daily = [648.181485171119; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    elseif handle ==85
        D_daily = [0.000120689548096652; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    elseif handle ==90
        D_daily = [0.00348285992130441; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    else
        D_daily = [0.452553227046895; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    end
    
    D_daily = abs(D_daily);
end

