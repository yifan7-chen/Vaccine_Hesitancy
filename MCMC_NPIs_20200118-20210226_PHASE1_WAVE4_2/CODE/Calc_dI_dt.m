function I_new = Calc_dI_dt(Y, Pars)   
    

    %% Calculate New infections per day
    tot_model_I =  Y(:,[Pars.I_ids Pars.CT_ids Pars.R_ids Pars.D_ids]);   


    dYdt_model_I = diff(tot_model_I);

    
    I_new = [123.8928278; sum(dYdt_model_I,2)];
end
