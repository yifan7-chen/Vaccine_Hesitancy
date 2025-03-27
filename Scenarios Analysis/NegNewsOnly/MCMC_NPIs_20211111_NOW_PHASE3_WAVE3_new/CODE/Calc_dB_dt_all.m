function VB_new = Calc_dB_dt_all(Y, Pars,handle)   
    


    tot_model_VB =  Y(:,[Pars.VB_ids Pars.EB_ids Pars.PB_ids Pars.IB_ids Pars.CTB_ids Pars.RB_ids  Pars.DB_ids ]);   


    dYdt_model_VB = diff(tot_model_VB);

    if handle ==25
        VB_new = [13440.3426792601; sum(dYdt_model_VB,2)];
    elseif handle == 50
        VB_new = [13387.4260449819; sum(dYdt_model_VB,2)];
    elseif handle ==75
        VB_new = [37.2537765313256; sum(dYdt_model_VB,2)];
    elseif handle ==85
        VB_new = [13434.2242998771; sum(dYdt_model_VB,2)];
    elseif handle ==90
        VB_new = [13238.7765324764; sum(dYdt_model_VB,2)];
    else
        VB_new = [13330.8664249050; sum(dYdt_model_VB,2)];
        
    end    

    VB_new = abs(VB_new);
end
