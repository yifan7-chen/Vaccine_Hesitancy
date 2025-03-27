function V1_new = Calc_dV1_dt_noincentive(Y, Pars)   
    

    %% Calculate New infections per day
    tot_model_V1 =  Y(:,[Pars.V1_ids Pars.Ev1_ids Pars.Pv1_ids Pars.Iv1_ids Pars.CTv1_ids Pars.Rv1_ids  Pars.Dv1_ids ]);   
    tot_model_V2 =  Y(:,[Pars.V2_ids Pars.Ev2_ids Pars.Pv2_ids Pars.Iv2_ids Pars.CTv2_ids Pars.Rv2_ids  Pars.Dv2_ids ]);   
    tot_model_VB =  Y(:,[Pars.VB_ids Pars.EB_ids  Pars.PB_ids  Pars.IB_ids  Pars.CTB_ids  Pars.RB_ids   Pars.DB_ids ]);  


    dYdt_model_V1 = diff(tot_model_V1);
    dYdt_model_V2 = diff(tot_model_V2);
    dYdt_model_VB = diff(tot_model_VB);
    
    V1_new =[1135.68022517296; sum(dYdt_model_V1,2) + sum(dYdt_model_V2,2) + sum(dYdt_model_VB,2)];
    V1_new = abs(V1_new);   
end

%SEIR_model_shields_LL(pars_nyc.times,  pars_nyc.target, [0.1; 0.25; 0.25; 0.25; 100], pars_nyc, true)