function V1_new = Calc_dV1_dt_all(Y, Pars,handle)   
    

    tot_model_V1 =  Y(:,[Pars.V1_ids Pars.Ev1_ids Pars.Pv1_ids Pars.Iv1_ids Pars.CTv1_ids Pars.Rv1_ids  Pars.Dv1_ids ]);   
    tot_model_V2 =  Y(:,[Pars.V2_ids Pars.Ev2_ids Pars.Pv2_ids Pars.Iv2_ids Pars.CTv2_ids Pars.Rv2_ids  Pars.Dv2_ids ]);   
    tot_model_VB =  Y(:,[Pars.VB_ids Pars.EB_ids  Pars.PB_ids  Pars.IB_ids  Pars.CTB_ids  Pars.RB_ids   Pars.DB_ids ]);  


    dYdt_model_V1 = diff(tot_model_V1);
    dYdt_model_V2 = diff(tot_model_V2);
    dYdt_model_VB = diff(tot_model_VB);
    if handle ==25
        V1_new =[4.34277378686697e-06; sum(dYdt_model_V1,2) + sum(dYdt_model_V2,2) + sum(dYdt_model_VB,2)];
    elseif handle == 50
        V1_new =[7.53061613067985e-10; sum(dYdt_model_V1,2) + sum(dYdt_model_V2,2) + sum(dYdt_model_VB,2)];
    elseif handle ==75
        V1_new =[3945.32935925111; sum(dYdt_model_V1,2) + sum(dYdt_model_V2,2) + sum(dYdt_model_VB,2)];
    elseif handle ==85
        V1_new =[1.45034100569319e-05; sum(dYdt_model_V1,2) + sum(dYdt_model_V2,2) + sum(dYdt_model_VB,2)];
    elseif handle ==90
        V1_new =[6988.35613015388; sum(dYdt_model_V1,2) + sum(dYdt_model_V2,2) + sum(dYdt_model_VB,2)];
    else
        V1_new =[4000.82617684237; sum(dYdt_model_V1,2) + sum(dYdt_model_V2,2) + sum(dYdt_model_VB,2)];
    end    
    V1_new = abs(V1_new);
end
