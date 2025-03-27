function I_new = Calc_dI_dt_all(Y, Pars,handle)   
    

    tot_model_I     =  Y(:,[Pars.I_ids      Pars.CT_ids     Pars.R_ids      Pars.D_ids]);   
    tot_model_Iv1   =  Y(:,[Pars.Iv1_ids    Pars.CTv1_ids   Pars.Rv1_ids    Pars.Dv1_ids]);  
    tot_model_Iv2   =  Y(:,[Pars.Iv2_ids    Pars.CTv2_ids   Pars.Rv2_ids    Pars.Dv2_ids]); 
    tot_model_IB    =  Y(:,[Pars.IB_ids     Pars.CTB_ids    Pars.RB_ids     Pars.DB_ids]); 


    dYdt_model_I    = diff(tot_model_I);
    dYdt_model_Iv1  = diff(tot_model_Iv1);
    dYdt_model_Iv2  = diff(tot_model_Iv2);
    dYdt_model_IB   = diff(tot_model_IB);
    if handle ==25
        I_new = [0.00398929509384125; sum(dYdt_model_I,2) + sum(dYdt_model_Iv1,2) + sum(dYdt_model_Iv2,2) + sum(dYdt_model_IB,2)];
    elseif handle == 50
        I_new = [0.0371220956653084; sum(dYdt_model_I,2) + sum(dYdt_model_Iv1,2) + sum(dYdt_model_Iv2,2) + sum(dYdt_model_IB,2)];
    elseif handle == 75
        I_new = [0.000573980250038630; sum(dYdt_model_I,2) + sum(dYdt_model_Iv1,2) + sum(dYdt_model_Iv2,2) + sum(dYdt_model_IB,2)];
    elseif handle == 85
        I_new = [0.303596387949036; sum(dYdt_model_I,2) + sum(dYdt_model_Iv1,2) + sum(dYdt_model_Iv2,2) + sum(dYdt_model_IB,2)];
    elseif handle == 90
        I_new = [8.63736872669379; sum(dYdt_model_I,2) + sum(dYdt_model_Iv1,2) + sum(dYdt_model_Iv2,2) + sum(dYdt_model_IB,2)];
    else
        I_new = [767.813064219205; sum(dYdt_model_I,2) + sum(dYdt_model_Iv1,2) + sum(dYdt_model_Iv2,2) + sum(dYdt_model_IB,2)];
    end
    
       I_new = abs(I_new);
end
 

