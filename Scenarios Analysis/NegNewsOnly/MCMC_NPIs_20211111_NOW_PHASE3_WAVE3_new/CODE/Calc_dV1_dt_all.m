function V1_new = Calc_dV1_dt_all(Y, Pars,handle)   
    

    tot_model_V1 =  Y(:,[Pars.V1_ids Pars.Ev1_ids Pars.Pv1_ids Pars.Iv1_ids Pars.CTv1_ids Pars.Rv1_ids  Pars.Dv1_ids ]);   
    tot_model_V2 =  Y(:,[Pars.V2_ids Pars.Ev2_ids Pars.Pv2_ids Pars.Iv2_ids Pars.CTv2_ids Pars.Rv2_ids  Pars.Dv2_ids ]);   
    tot_model_VB =  Y(:,[Pars.VB_ids Pars.EB_ids  Pars.PB_ids  Pars.IB_ids  Pars.CTB_ids  Pars.RB_ids   Pars.DB_ids ]);  


    dYdt_model_V1 = diff(tot_model_V1);
    dYdt_model_V2 = diff(tot_model_V2);
    dYdt_model_VB = diff(tot_model_VB);
    if handle ==25
        V1_new =[1.29148247651756e-10; sum(dYdt_model_V1,2) + sum(dYdt_model_V2,2) + sum(dYdt_model_VB,2)];
    elseif handle == 50
        V1_new =[7.82165443524718e-11; sum(dYdt_model_V1,2) + sum(dYdt_model_V2,2) + sum(dYdt_model_VB,2)];
    elseif handle == 75
        V1_new =[2.05432115762960e-10; sum(dYdt_model_V1,2) + sum(dYdt_model_V2,2) + sum(dYdt_model_VB,2)];
    elseif handle == 85
        V1_new =[3.81987774744630e-10; sum(dYdt_model_V1,2) + sum(dYdt_model_V2,2) + sum(dYdt_model_VB,2)];
    elseif handle == 90
        V1_new =[2.41925590671599e-10; sum(dYdt_model_V1,2) + sum(dYdt_model_V2,2) + sum(dYdt_model_VB,2)];
    else
        V1_new =[3.45607986673713e-11; sum(dYdt_model_V1,2) + sum(dYdt_model_V2,2) + sum(dYdt_model_VB,2)];
    end    
    V1_new = abs(V1_new);
end

