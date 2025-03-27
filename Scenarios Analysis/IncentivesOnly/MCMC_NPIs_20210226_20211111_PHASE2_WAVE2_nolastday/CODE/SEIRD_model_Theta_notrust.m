function res = SEIRD_model_Theta_notrust(Theta, times, Pars, Comp, RATE)
    [t, Y, pars_out] = SEIRD_model_ThetaSweep_notrust(Theta, times, Pars);

    if RATE && Comp =="I"
        res=Calc_dI_dt(Y, Pars)*Theta(2);
    elseif RATE && Comp =="A"
        res =Calc_dA_dt(Y, Pars);
    elseif RATE && Comp =="Isym"
        res =Calc_dI_dt(Y, Pars);
    elseif RATE && Comp =="V1"
        res =Calc_dV1_dt_notrust(Y, Pars);
    else
        res=sum(Y(:,Pars.(strcat(Comp, "_ids"))),2);
    end
end