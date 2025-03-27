function D_daily = Calc_dD_dt_all(Y, Pars,handle)   
    

    D_daily     = diff(Y(:,Pars.D_ids));
    D_dailyv1   = diff(Y(:,Pars.Dv1_ids));
    D_dailyv2   = diff(Y(:,Pars.Dv2_ids));
    D_dailyB    = diff(Y(:,Pars.DB_ids));
    if handle ==25
        D_daily = [4.19884962565654e-06; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    elseif handle == 50
        D_daily = [3.84442079403811e-05; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    elseif handle ==75
        D_daily = [14.1196400327366; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    elseif handle ==85
        D_daily = [0.000314067609266303; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    elseif handle ==90
        D_daily = [0.00901063587298799; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    else
        D_daily = [0.876710473821749; D_daily + D_dailyv1 + D_dailyv2 + D_dailyB];
    end
    
    D_daily = abs(D_daily);
end

