function VB_new = Calc_dB_dt_all(Y, Pars,handle)   
    

    tot_model_VB =  Y(:,[Pars.VB_ids Pars.EB_ids Pars.PB_ids Pars.IB_ids Pars.CTB_ids Pars.RB_ids  Pars.DB_ids ]);   


    dYdt_model_VB = diff(tot_model_VB);

    if handle ==25
        VB_new = [35556.5012656086; sum(dYdt_model_VB,2)];
    elseif handle == 50
        VB_new = [35498.4301259561; sum(dYdt_model_VB,2)];
    elseif handle ==75
        VB_new = [35367.2366080468; sum(dYdt_model_VB,2)];
    elseif handle ==85
        VB_new = [35549.8475760166; sum(dYdt_model_VB,2)];
    elseif handle ==90
        VB_new = [35332.4076089698; sum(dYdt_model_VB,2)];
    else
        VB_new = [35437.3026455782; sum(dYdt_model_VB,2)];
        
    end    

    VB_new = abs(VB_new);
end

