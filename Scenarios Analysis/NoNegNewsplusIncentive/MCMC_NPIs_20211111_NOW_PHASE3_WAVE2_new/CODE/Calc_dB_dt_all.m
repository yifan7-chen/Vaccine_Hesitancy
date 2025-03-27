function VB_new = Calc_dB_dt_all(Y, Pars,handle)   
    

    tot_model_VB =  Y(:,[Pars.VB_ids Pars.EB_ids Pars.PB_ids Pars.IB_ids Pars.CTB_ids Pars.RB_ids  Pars.DB_ids ]);   


    dYdt_model_VB = diff(tot_model_VB);

    if handle ==25
        VB_new = [40469.8145089470; sum(dYdt_model_VB,2)];
    elseif handle == 50
        VB_new = [43352.2860068617; sum(dYdt_model_VB,2)];
    elseif handle ==75
        VB_new = [45020.2386314405; sum(dYdt_model_VB,2)];
    else
        VB_new = [46066.9563344887; sum(dYdt_model_VB,2)];
    end    

    VB_new = abs(VB_new);
end

