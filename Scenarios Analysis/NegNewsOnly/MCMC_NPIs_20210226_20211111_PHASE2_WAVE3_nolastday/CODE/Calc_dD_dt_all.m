function D_daily = Calc_dD_dt_all(Y, Pars,handle)   
    
    D_daily = diff(Y(:,Pars.D_ids));
    D_dailyv1 = diff(Y(:,Pars.Dv1_ids));
    D_dailyv2 = diff(Y(:,Pars.Dv2_ids));

    if handle ==25
        D_daily = [0.372522091372306;D_daily + D_dailyv1 + D_dailyv2];
    elseif handle ==50
        D_daily = [0.372522091372306;D_daily + D_dailyv1 + D_dailyv2];
    elseif handle ==75
        D_daily = [0.372522091372306;D_daily + D_dailyv1 + D_dailyv2];
    elseif handle ==85
        D_daily = [0.372522091372306;D_daily + D_dailyv1 + D_dailyv2];
    elseif handle ==90
        D_daily = [0.372522091372306;D_daily + D_dailyv1 + D_dailyv2];
    else
        D_daily = [0.372522091372306;D_daily + D_dailyv1 + D_dailyv2];
    end
    D_daily = abs(D_daily);
end

