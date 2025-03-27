function VB_new = Calc_dB_dt_noincentive(Y, Pars)   
    

    tot_model_VB =  Y(:,[Pars.VB_ids Pars.EB_ids Pars.PB_ids Pars.IB_ids Pars.CTB_ids Pars.RB_ids  Pars.DB_ids ]);   


    dYdt_model_VB = diff(tot_model_VB);

    
    VB_new = [16.7659584325185; sum(dYdt_model_VB,2)];
    VB_new = abs(VB_new);
end

