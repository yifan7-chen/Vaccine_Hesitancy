function dYdt = SEIRD_model_full90(t, X, Pars)
    
    %% (0) Setup ---------------------------------------------------------------
    
    dYdt=zeros(length(X),1);   
    
    %% Update Pars
     
    % Load in Matrix Form

    P       =   X(Pars.P_ids);
    I       =   X(Pars.I_ids);
    CT      =   X(Pars.CT_ids);

    Pv1     =   X(Pars.Pv1_ids);
    Iv1     =   X(Pars.Iv1_ids);
    CTv1    =   X(Pars.CTv1_ids);

    Pv2     =   X(Pars.Pv2_ids);
    Iv2     =   X(Pars.Iv2_ids);
    CTv2    =   X(Pars.CTv2_ids);

    PB      =   X(Pars.PB_ids);
    IB      =   X(Pars.IB_ids);
    CTB     =   X(Pars.CTB_ids);


    
    tot = sum(X(1:24));    %row - sum
    
    %% (1) Derive Contact Matrices ---------------------------------------------

    if t<=Pars.center1
        Pars.AllContacts = Pars.AllContacts * Pars.p_sp;
    else
        Pars.AllContacts = Pars.AllContacts * Pars.p_sp_c;
    end

    ratio_2vac = 1/(1+exp(-X(Pars.Y2vac_ids)));
    ratio_2B   = 1/(1+exp(-X(Pars.Y2B_ids)));
    CM = Pars.AllContacts .* (1 + Pars.contact_reduced(floor(t)+Pars.beforeidx));    


    infec = Pars.alpha * ( P + Pv1 + Pv2 + PB) + Pars.alpha_i * (I + Iv1 + Iv2 + IB); 
    
    
    %% (3) Calculate v_fois ------------------------------------------------------
    
    % Force of infection by group 
    infec2tot = infec./tot.*Pars.relative_susceptibility';


    beta1CM = Pars.beta(1)  * infec2tot;
    beta2CM = Pars.beta(2)  * infec2tot;
    beta3CM = Pars.beta(3)  * infec2tot;
    beta4CM = Pars.beta(4)  * infec2tot;
    beta5CM = Pars.beta(5)  * infec2tot;

    if t >= Pars.t_nov_start && t < Pars.t_omicron_start
        temp_I = 0.06 * beta1CM + 0.94 * beta4CM;
        temp_Iv1 = 0.06 * (1-Pars.dose1_eff_infection(1)) * beta1CM + 0.94 * (1-Pars.dose1_eff_infection(4)) * beta4CM;
        temp_Iv2 = 0.06 * (1-Pars.dose2_eff_infection(1)) * beta1CM + 0.94 * (1-Pars.dose2_eff_infection(4)) * beta4CM;
        temp_IB  = (1-Pars.dosebooster_eff_infection(1)) * beta4CM;
    elseif t >= Pars.t_omicron_start && t < Pars.t_dec21_start
        temp_I = 0.01 * beta1CM + 0.79 * beta4CM + 0.2 *beta5CM;    
        temp_Iv1 = 0.01 * (1-Pars.dose1_eff_infection(1)) * beta1CM + 0.79 * (1-Pars.dose1_eff_infection(4)) * beta4CM + 0.2 * (1-Pars.dose1_eff_infection(5)) *beta5CM;  
        temp_Iv2 = 0.01 * (1-Pars.dose2_eff_infection(1)) * beta1CM + 0.79 * (1-Pars.dose2_eff_infection(4)) * beta4CM + 0.2 * (1-Pars.dose2_eff_infection(5)) *beta5CM;   
        temp_IB  = 0.80 * (1-Pars.dosebooster_eff_infection(1)) * beta4CM + 0.2 * (1-Pars.dosebooster_eff_infection(2)) *beta5CM;  
    elseif t >= Pars.t_dec21_start && t < Pars.t_jan22_start
        temp_I = 0.3 * beta4CM + 0.7 *beta5CM;    
        temp_Iv1 =  0.3 * (1-Pars.dose1_eff_infection(4)) * beta4CM + 0.7 * (1-Pars.dose1_eff_infection(5)) *beta5CM;  
        temp_Iv2 =  0.3 * (1-Pars.dose2_eff_infection(4)) * beta4CM + 0.7 * (1-Pars.dose2_eff_infection(5)) *beta5CM;     
        temp_IB =  0.3 * (1-Pars.dosebooster_eff_infection(1)) * beta4CM + 0.7 * (1-Pars.dosebooster_eff_infection(2)) *beta5CM;
    elseif t >= Pars.t_jan22_start && t < Pars.t_feb22_start
        temp_I = 0.08 * beta4CM + 0.92 *beta5CM;    
        temp_Iv1 =  0.08 * (1-Pars.dose1_eff_infection(4)) * beta4CM + 0.92 * (1-Pars.dose1_eff_infection(5)) *beta5CM;  
        temp_Iv2 =  0.08 * (1-Pars.dose2_eff_infection(4)) * beta4CM + 0.92 * (1-Pars.dose2_eff_infection(5)) *beta5CM; 
        temp_IB =  0.08 * (1-Pars.dosebooster_eff_infection(1)) * beta4CM + 0.92 * (1-Pars.dosebooster_eff_infection(2)) *beta5CM;
    elseif t >= Pars.t_feb22_start && t < Pars.t_mar22_start
        temp_I = 0.03 * beta4CM + 0.97 *beta5CM;    
        temp_Iv1 =  0.03 * (1-Pars.dose1_eff_infection(4)) * beta4CM + 0.97 * (1-Pars.dose1_eff_infection(5)) *beta5CM;  
        temp_Iv2 =  0.03 * (1-Pars.dose2_eff_infection(4)) * beta4CM + 0.97 * (1-Pars.dose2_eff_infection(5)) *beta5CM;    
        temp_IB =  0.03 * (1-Pars.dosebooster_eff_infection(1)) * beta4CM + 0.97 * (1-Pars.dosebooster_eff_infection(2)) *beta5CM;
    else
        temp_I = beta5CM;    
        temp_Iv1 =  (1-Pars.dose1_eff_infection(5)) *beta5CM;  
        temp_Iv2 =  (1-Pars.dose2_eff_infection(5)) *beta5CM;   
        temp_IB  =  (1-Pars.dosebooster_eff_infection(2)) *beta5CM;

    end

    temp_I_CM     =   temp_I/infec2tot*CM;
    temp_Iv2_CM   =   temp_Iv2/infec2tot*CM;
    temp_IB_CM    =   temp_IB/infec2tot*CM;

    
    %% (5) Model Equations -----------------------------------------------------
    
    v_foisVec       =   temp_I*CM*(1 - Pars.q_fixbasic);
    v_foisVec_v1    =   temp_Iv1*CM*(1 - Pars.q_fixbasic);
    v_foisVec_v2    =   temp_Iv2*CM*(1 - Pars.q_fixbasic);
    v_foisVec_B     =   temp_IB*CM*(1 - Pars.q_fixbasic);
    


    S2E     = min(1,v_foisVec).* X(Pars.S_ids);
    V12Ev1  = min(1,v_foisVec_v1) * X(Pars.V1_ids);
    V22Ev2  = min(1,v_foisVec_v2) * X(Pars.V2_ids);
    VB2EB   = min(1,v_foisVec_B) * X(Pars.VB_ids);

    S2V1    = min((X(Pars.S_ids) - S2E),(50000 * ratio_2vac));
    V12V2   = (X(Pars.V1_ids) - V12Ev1) /28;
    V22VB   = min((X(Pars.V2_ids)-V22Ev2),(50000 * ratio_2B));


    E2P     = Pars.mu_a * X(Pars.E_ids);
    Ev12Pv1 = Pars.mu_a * X(Pars.Ev1_ids);
    Ev22Pv2 = Pars.mu_a * X(Pars.Ev2_ids);
    EB2PB   = Pars.mu_a * X(Pars.EB_ids);

    P2I     = Pars.D_p * P; 
    Pv12Iv1 = Pars.D_p * Pv1; 
    Pv22Iv2 = Pars.D_p * Pv2; 
    PB2IB   = Pars.D_p * PB; 

    I2CT    = Pars.ct * I; 
    I2RD    = (1 - Pars.ct)  * Pars.gamma_a * I;
    Iv12CTv1    = Pars.ct * Iv1; 
    Iv12RDv1    = (1 - Pars.ct)  * Pars.gamma_a * Iv1;
    Iv22CTv2    = Pars.ct * Iv2; 
    Iv22RDv2    = (1 - Pars.ct)  * Pars.gamma_a * Iv2;

    IB2CTB    = Pars.ct * IB; 
    IB2RDB    = (1 - Pars.ct)  * Pars.gamma_a * IB;
    
    CT2RD       = CT/28;
    CTv12RDv1   = CTv1/28;
    CTv22RDv2   = CTv2/28;
    CTB2RDB     = CTB/28;

    dYdt(Pars.S_ids)    = - S2E - S2V1;    % S-E
    dYdt(Pars.V1_ids)   = S2V1- V12V2 - V12Ev1;
    dYdt(Pars.V2_ids)   = V12V2 - V22Ev2 - V22VB;
    dYdt(Pars.VB_ids)   = V22VB - VB2EB;
    dYdt(Pars.E_ids)    = S2E - E2P;   %E-I
    dYdt(Pars.Ev1_ids)  = V12Ev1 - Ev12Pv1;
    dYdt(Pars.Ev2_ids)  = V22Ev2 - Ev22Pv2;
    dYdt(Pars.EB_ids)   = VB2EB - EB2PB;
    dYdt(Pars.P_ids)    = E2P -  P2I;
    dYdt(Pars.Pv1_ids)  = Ev12Pv1 - Pv12Iv1;
    dYdt(Pars.Pv2_ids)  = Ev22Pv2 - Pv22Iv2;
    dYdt(Pars.PB_ids)   = EB2PB - PB2IB;
    dYdt(Pars.I_ids)    = P2I- I2RD - I2CT;
    dYdt(Pars.Iv1_ids)  = Pv12Iv1- Iv12RDv1 - Iv12CTv1;
    dYdt(Pars.Iv2_ids)  = Pv22Iv2- Iv22RDv2 - Iv22CTv2;
    dYdt(Pars.IB_ids)   = PB2IB- IB2RDB - IB2CTB;
    dYdt(Pars.CT_ids)   = I2CT - CT2RD; 
    dYdt(Pars.CTv1_ids) = Iv12CTv1 - CTv12RDv1; 
    dYdt(Pars.CTv2_ids) = Iv22CTv2 - CTv22RDv2; 
    dYdt(Pars.CTB_ids)  = IB2CTB - CTB2RDB; 

    
    
    

    if t >= Pars.t_nov_start && t < Pars.t_omicron_start
        Dratio = (0.06 * Pars.epsilon(1) + 0.94 *Pars.epsilon(4)) .* Pars.xi_a';
        Dv1ratio = (0.06 * Pars.epsilon(1)*(1-Pars.dose1_eff_death(1)) + 0.94 * Pars.epsilon(4)*(1-Pars.dose1_eff_death(4))) .* Pars.xi_a';
        Dv2ratio = (0.06 * Pars.epsilon(1)*(1-Pars.dose2_eff_death(1)) + 0.94 * Pars.epsilon(4)*(1-Pars.dose2_eff_death(4))) .* Pars.xi_a';
        DBratio = Pars.epsilon(4)*(1-Pars.dosebooster_eff_death(1)) .* Pars.xi_a';
        
    elseif t >= Pars.t_omicron_start && t < Pars.t_dec21_start
        Dratio = (0.01 * Pars.epsilon(1) + 0.79 * Pars.epsilon(4) + 0.2 *Pars.epsilon(5)) .* Pars.xi_a';
        Dv1ratio = (0.01 * Pars.epsilon(1)*(1-Pars.dose1_eff_death(1)) + 0.79 * Pars.epsilon(4)*(1-Pars.dose1_eff_death(4)) + 0.2 * Pars.epsilon(5)*(1-Pars.dose1_eff_death(5))) .* Pars.xi_a';
        Dv2ratio = (0.01 * Pars.epsilon(1)*(1-Pars.dose2_eff_death(1)) + 0.79 * Pars.epsilon(4)*(1-Pars.dose2_eff_death(4)) + 0.2 * Pars.epsilon(5)*(1-Pars.dose2_eff_death(5))) .* Pars.xi_a';
        DBratio = (0.80 * Pars.epsilon(4)*(1-Pars.dosebooster_eff_death(1)) + 0.2 * Pars.epsilon(5)*(1-Pars.dosebooster_eff_death(2))) .* Pars.xi_a';

    elseif t >= Pars.t_dec21_start && t < Pars.t_jan22_start
        Dratio = (0.3 * Pars.epsilon(4) + 0.7 *Pars.epsilon(5)) .* Pars.xi_a';
        Dv1ratio = (0.3 * Pars.epsilon(4)*(1-Pars.dose1_eff_death(4)) + 0.7 * Pars.epsilon(5)*(1-Pars.dose1_eff_death(5))) .* Pars.xi_a';
        Dv2ratio = (0.3 * Pars.epsilon(4)*(1-Pars.dose2_eff_death(4)) + 0.7 * Pars.epsilon(5)*(1-Pars.dose2_eff_death(5))) .* Pars.xi_a';
        DBratio = (0.3 * Pars.epsilon(4)*(1-Pars.dosebooster_eff_death(1)) + 0.7 * Pars.epsilon(5)*(1-Pars.dosebooster_eff_death(2))) .* Pars.xi_a';
    elseif t >= Pars.t_jan22_start && t < Pars.t_feb22_start
        Dratio = (0.08 * Pars.epsilon(4) + 0.92 *Pars.epsilon(5)) .* Pars.xi_a';
        Dv1ratio = (0.08 * Pars.epsilon(4)*(1-Pars.dose1_eff_death(4)) + 0.92 * Pars.epsilon(5)*(1-Pars.dose1_eff_death(5))) .* Pars.xi_a';
        Dv2ratio = (0.08 * Pars.epsilon(4)*(1-Pars.dose2_eff_death(4)) + 0.92 * Pars.epsilon(5)*(1-Pars.dose2_eff_death(5))) .* Pars.xi_a';
        DBratio = (0.08 * Pars.epsilon(4)*(1-Pars.dosebooster_eff_death(1)) + 0.92 * Pars.epsilon(5)*(1-Pars.dosebooster_eff_death(2))) .* Pars.xi_a';
  elseif t >= Pars.t_feb22_start && t < Pars.t_mar22_start
        Dratio = (0.03 * Pars.epsilon(4) + 0.97 *Pars.epsilon(5)) .* Pars.xi_a';
        Dv1ratio = (0.03 * Pars.epsilon(4)*(1-Pars.dose1_eff_death(4)) + 0.97 * Pars.epsilon(5)*(1-Pars.dose1_eff_death(5))) .* Pars.xi_a';
        Dv2ratio = (0.03 * Pars.epsilon(4)*(1-Pars.dose2_eff_death(4)) + 0.97 * Pars.epsilon(5)*(1-Pars.dose2_eff_death(5))) .* Pars.xi_a';
        DBratio = (0.03 * Pars.epsilon(4)*(1-Pars.dosebooster_eff_death(1)) + 0.97 * Pars.epsilon(5)*(1-Pars.dosebooster_eff_death(2))) .* Pars.xi_a';
    else
        Dratio = Pars.epsilon(5) .* Pars.xi_a';
        Dv1ratio = Pars.epsilon(5)*(1-Pars.dose1_eff_death(5)) .* Pars.xi_a';
        Dv2ratio = Pars.epsilon(5)*(1-Pars.dose2_eff_death(5)) .* Pars.xi_a';
        DBratio = Pars.epsilon(5)*(1-Pars.dosebooster_eff_death(2)) .* Pars.xi_a';

    end
    
    Rratio      =   1 - Dratio;
    Rv1ratio    =   1 - Dv1ratio;
    Rv2ratio    =   1 - Dv2ratio;
    RBratio     =   1 - DBratio;

    

    dYdt(Pars.R_ids) = (I2RD + CT2RD) *Rratio; 
    dYdt(Pars.D_ids) = (I2RD + CT2RD) *Dratio;  

    dYdt(Pars.Rv1_ids) = (Iv12RDv1 + CTv12RDv1) *Rv1ratio; 
    dYdt(Pars.Dv1_ids) = (Iv12RDv1 + CTv12RDv1) *Dv1ratio; 

    dYdt(Pars.Rv2_ids) = (Iv22RDv2 + CTv22RDv2) *Rv2ratio; 
    dYdt(Pars.Dv2_ids) = (Iv22RDv2 + CTv22RDv2) *Dv2ratio; 

    dYdt(Pars.RB_ids) = (IB2RDB + CTB2RDB) *RBratio; 
    dYdt(Pars.DB_ids) = (IB2RDB + CTB2RDB) *DBratio; 

    dYdt(Pars.Y2vac_ids) = Pars.kappa_2vac * (1 - ratio_2vac) .* ratio_2vac.*(temp_I_CM - temp_Iv2_CM + Pars.r_2vac.*(Dratio - Dv2ratio) -57.77790794+ Pars.threshold_2vac);  %25 -33.53178362


        dYdt(Pars.Y2B_ids)          = Pars.kappa_2B * (1 - ratio_2B) .* ratio_2B.*(temp_Iv2_CM - temp_IB_CM + Pars.r_2B.*(Dv2ratio - DBratio) + Pars.threshold_2B); %+ Pars.npi_payoff


