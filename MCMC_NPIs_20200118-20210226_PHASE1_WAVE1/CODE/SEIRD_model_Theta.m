function res = SEIRD_model_Theta(Theta, times, Pars, Comp, RATE)
    [t, Y, pars_out] = SEIRD_model_ThetaSweep(Theta, times, Pars);
    if RATE && Comp =="I"
        res = Calc_dI_dt(Y, Pars)*Theta(4);
    elseif RATE && Comp =="D"
        res = Calc_dD_dt(Y, Pars);
    else
        res=sum(Y(:,Pars.(strcat(Comp, "_ids"))),2);
    end
end