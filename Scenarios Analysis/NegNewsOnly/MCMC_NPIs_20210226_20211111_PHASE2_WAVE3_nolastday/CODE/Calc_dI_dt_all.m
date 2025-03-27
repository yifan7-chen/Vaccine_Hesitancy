function I_new = Calc_dI_dt_all(Y, Pars,handle)   

    tot_model_I =  Y(:,[Pars.I_ids Pars.CT_ids Pars.R_ids Pars.D_ids]);   
    tot_model_Iv1 =  Y(:,[Pars.Iv1_ids Pars.CTv1_ids Pars.Rv1_ids Pars.Dv1_ids]);  
    tot_model_Iv2 =  Y(:,[Pars.Iv2_ids Pars.CTv2_ids Pars.Rv2_ids Pars.Dv2_ids]);  


    dYdt_model_I = diff(tot_model_I);
    dYdt_model_Iv1 = diff(tot_model_Iv1);
    dYdt_model_Iv2 = diff(tot_model_Iv2);
    if handle ==25
        I_new = [8.17645617426289; sum(dYdt_model_I,2) + sum(dYdt_model_Iv1,2) + sum(dYdt_model_Iv2,2)];
    elseif handle ==50
        I_new = [8.17645617426289; sum(dYdt_model_I,2) + sum(dYdt_model_Iv1,2) + sum(dYdt_model_Iv2,2)];
    elseif handle ==75
        I_new = [8.17645617426289; sum(dYdt_model_I,2) + sum(dYdt_model_Iv1,2) + sum(dYdt_model_Iv2,2)];
    elseif handle ==85
        I_new = [8.17645617426289; sum(dYdt_model_I,2) + sum(dYdt_model_Iv1,2) + sum(dYdt_model_Iv2,2)];
    elseif handle ==90
        I_new = [8.17645617426289; sum(dYdt_model_I,2) + sum(dYdt_model_Iv1,2) + sum(dYdt_model_Iv2,2)];
    else
        I_new = [8.17645617426289; sum(dYdt_model_I,2) + sum(dYdt_model_Iv1,2) + sum(dYdt_model_Iv2,2)];
    end
    I_new = abs(I_new);
end

