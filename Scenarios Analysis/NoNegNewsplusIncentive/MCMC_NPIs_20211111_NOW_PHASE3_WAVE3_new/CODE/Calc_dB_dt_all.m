function VB_new = Calc_dB_dt_all(Y, Pars,handle)   
    


    tot_model_VB =  Y(:,[Pars.VB_ids Pars.EB_ids Pars.PB_ids Pars.IB_ids Pars.CTB_ids Pars.RB_ids  Pars.DB_ids ]);   


    dYdt_model_VB = diff(tot_model_VB);

    if handle ==25
        VB_new = [22886.6936811671; sum(dYdt_model_VB,2)];
    elseif handle == 50
        VB_new = [33914.0677755213; sum(dYdt_model_VB,2)];
    elseif handle ==75
        VB_new = [40605.8183261321; sum(dYdt_model_VB,2)];
    else
        VB_new = [43720.4853381845; sum(dYdt_model_VB,2)];
    end    

    VB_new = abs(VB_new);
end

