function res = SEIRD_model_Theta_all(Theta, times, Pars, Comp, RATE,handle)
    [t, Y, pars_out] = SEIRD_model_ThetaSweep_all(Theta, times, Pars,handle);

    if RATE && Comp =="I"
        res=Calc_dI_dt_all(Y, Pars,handle)*Theta(1);
    elseif RATE && Comp =="A"
        res =Calc_dA_dt(Y, Pars);
    elseif RATE && Comp =="Isym"
        res =Calc_dI_dt(Y, Pars);
    elseif RATE && Comp =="V1"
        res =Calc_dV1_dt_all(Y, Pars,handle);
    elseif RATE && Comp =="VB"
        res =Calc_dB_dt_all(Y, Pars,handle);
    else
        res=sum(Y(:,Pars.(strcat(Comp, "_ids"))),2);
    end
end