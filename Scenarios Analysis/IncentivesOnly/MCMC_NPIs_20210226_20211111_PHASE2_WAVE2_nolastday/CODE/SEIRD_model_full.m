function dYdt = SEIRD_model_full(t, X, Pars)
    
    %% (0) Setup ---------------------------------------------------------------
    
    dYdt=zeros(length(X),1);   
    
    %% Update Pars
     


    P       = X(Pars.P_ids);
    I       = X(Pars.I_ids);
    CT      = X(Pars.CT_ids);

    Pv1       = X(Pars.Pv1_ids);
    Iv1       = X(Pars.Iv1_ids);
    CTv1      = X(Pars.CTv1_ids);

    Pv2       = X(Pars.Pv2_ids);
    Iv2       = X(Pars.Iv2_ids);
    CTv2      = X(Pars.CTv2_ids);

    
    % Population sizes at time t    
    
    tot = sum(X(1:18));    %row - sum
    
    %% (1) Derive Contact Matrices ---------------------------------------------


    ratio_2vac = 1/(1+exp(-X(Pars.Y2vac_ids)));

    CM = Pars.AllContacts .* (1 + Pars.contact_reduced(floor(t)+Pars.beforeidx));

    infec = Pars.alpha * ( P + Pv1 + Pv2) + Pars.alpha_i * (I + Iv1 + Iv2); 
    
    
    %% (3) Calculate v_fois ------------------------------------------------------
    
    % Force of infection by group 
    infec2tot = infec./tot.*Pars.relative_susceptibility';


    beta1CM = Pars.beta(1)  * infec2tot;
    beta2CM = Pars.beta(2)  * infec2tot;
    beta3CM = Pars.beta(3)  * infec2tot;
    beta4CM = Pars.beta(4)  * infec2tot;
    beta5CM = Pars.beta(5)  * infec2tot;
    if t < Pars.t_alpha_start
        temp_I = beta1CM; 
        temp_Iv1 = (1-Pars.dose1_eff_infection(1)) * beta1CM;
        temp_Iv2 = (1-Pars.dose2_eff_infection(1)) * beta1CM;
        
    elseif t >= Pars.t_alpha_start && t < Pars.t_beta_start
        temp_I = 0.95 * beta1CM + 0.05 * beta2CM;  
        temp_Iv1 = 0.95 * (1-Pars.dose1_eff_infection(1)) * beta1CM + 0.05 * (1-Pars.dose1_eff_infection(2)) * beta2CM;  
        temp_Iv2 = 0.95 * (1-Pars.dose2_eff_infection(1)) * beta1CM + 0.05 * (1-Pars.dose2_eff_infection(2)) * beta2CM;  

    elseif t >= Pars.t_beta_start && t < Pars.t_jan_start
        temp_I = 0.95 * beta1CM + 0.05 * beta3CM; 
        temp_Iv1 = 0.95 * (1-Pars.dose1_eff_infection(1)) * beta1CM + 0.05 * (1-Pars.dose1_eff_infection(3)) * beta3CM; 
        temp_Iv2 = 0.95 * (1-Pars.dose2_eff_infection(1)) * beta1CM + 0.05 * (1-Pars.dose2_eff_infection(3)) * beta3CM; 
    elseif t >= Pars.t_jan_start && t < Pars.t_feb_start
        temp_I = 0.97 * beta1CM + 0.03 * beta2CM;   
        temp_Iv1 = 0.97 * (1-Pars.dose1_eff_infection(1)) * beta1CM + 0.03 * (1-Pars.dose1_eff_infection(2)) * beta2CM;
        temp_Iv2 = 0.97 * (1-Pars.dose2_eff_infection(1)) * beta1CM + 0.03 * (1-Pars.dose2_eff_infection(2)) * beta2CM;   
    elseif t >= Pars.t_feb_start && t < Pars.t_mar_start
        temp_I = 0.88 * beta1CM + 0.12 * beta3CM; 
        temp_Iv1 = 0.88 * (1-Pars.dose1_eff_infection(1)) * beta1CM + 0.12 * (1-Pars.dose1_eff_infection(3)) * beta3CM; 
        temp_Iv2 = 0.88 * (1-Pars.dose2_eff_infection(1)) * beta1CM + 0.12 * (1-Pars.dose2_eff_infection(3)) * beta3CM; 
    elseif t >= Pars.t_mar_start && t < Pars.t_delta_start 
        temp_I = 0.78 * beta1CM + 0.10 * beta2CM + 0.12 * beta3CM;
        temp_Iv1 = 0.78 * (1-Pars.dose1_eff_infection(1)) * beta1CM + 0.10 * (1-Pars.dose1_eff_infection(2)) * beta2CM + 0.12 * (1-Pars.dose1_eff_infection(3)) * beta3CM;
        temp_Iv2 = 0.78 * (1-Pars.dose2_eff_infection(1)) * beta1CM + 0.10 * (1-Pars.dose2_eff_infection(2)) * beta2CM + 0.12 * (1-Pars.dose2_eff_infection(3)) * beta3CM;
    elseif t >= Pars.t_delta_start && t < Pars.t_apr_start
        temp_I = 0.33 * beta1CM + 0.33 * beta2CM + 0.27 * beta3CM + 0.07 * beta4CM;
        temp_Iv1 = 0.33 * (1-Pars.dose1_eff_infection(1)) * beta1CM + 0.33 * (1-Pars.dose1_eff_infection(2)) * beta2CM + 0.27 * (1-Pars.dose1_eff_infection(3)) * beta3CM + 0.07 * (1-Pars.dose1_eff_infection(4)) * beta4CM;
        temp_Iv2 = 0.33 * (1-Pars.dose2_eff_infection(1)) * beta1CM + 0.33 * (1-Pars.dose2_eff_infection(2)) * beta2CM + 0.27 * (1-Pars.dose2_eff_infection(3)) * beta3CM + 0.07 * (1-Pars.dose2_eff_infection(4)) * beta4CM;
    elseif t >= Pars.t_apr_start && t < Pars.t_may_start
        temp_I = 0.32 * beta1CM + 0.13 * beta2CM + 0.31 * beta3CM + 0.23 * beta4CM;
        temp_Iv1 = 0.32 * (1-Pars.dose1_eff_infection(1)) * beta1CM + 0.13 * (1-Pars.dose1_eff_infection(2)) * beta2CM + 0.31 * (1-Pars.dose1_eff_infection(3)) * beta3CM + 0.23 * (1-Pars.dose1_eff_infection(4)) * beta4CM;
        temp_Iv2 = 0.32 * (1-Pars.dose2_eff_infection(1)) * beta1CM + 0.13 * (1-Pars.dose2_eff_infection(2)) * beta2CM + 0.31 * (1-Pars.dose2_eff_infection(3)) * beta3CM + 0.23 * (1-Pars.dose2_eff_infection(4)) * beta4CM;
    elseif t >= Pars.t_may_start && t < Pars.t_jun_start
        temp_I = 0.19 * beta1CM + 0.1 * beta2CM + 0.45 * beta3CM + 0.26 * beta4CM;
        temp_Iv1 = 0.19 * (1-Pars.dose1_eff_infection(1)) * beta1CM + 0.1 * (1-Pars.dose1_eff_infection(2)) * beta2CM + 0.45 * (1-Pars.dose1_eff_infection(3)) * beta3CM + 0.26 * (1-Pars.dose1_eff_infection(4)) * beta4CM;
        temp_Iv2 = 0.19 * (1-Pars.dose2_eff_infection(1)) * beta1CM + 0.1 * (1-Pars.dose2_eff_infection(2)) * beta2CM + 0.45 * (1-Pars.dose2_eff_infection(3)) * beta3CM + 0.26 * (1-Pars.dose2_eff_infection(4)) * beta4CM;
    elseif t >= Pars.t_jun_start && t < Pars.t_jul_start
        temp_I = 0.05 * beta1CM + 0.09 * beta2CM + 0.01 * beta3CM + 0.85 * beta4CM;
        temp_Iv1 = 0.05 * (1-Pars.dose1_eff_infection(1)) * beta1CM + 0.09 * (1-Pars.dose1_eff_infection(2)) * beta2CM + 0.01 * (1-Pars.dose1_eff_infection(3)) * beta3CM + 0.85 * (1-Pars.dose1_eff_infection(4)) * beta4CM;
        temp_Iv2 = 0.05 * (1-Pars.dose2_eff_infection(1)) * beta1CM + 0.09 * (1-Pars.dose2_eff_infection(2)) * beta2CM + 0.01 * (1-Pars.dose2_eff_infection(3)) * beta3CM + 0.85 * (1-Pars.dose2_eff_infection(4)) * beta4CM;
    elseif t >= Pars.t_jul_start && t < Pars.t_aug_start
        temp_I = 0.04 * beta1CM + 0.07 * beta2CM + 0.89 * beta4CM;
        temp_Iv1 = 0.04 * (1-Pars.dose1_eff_infection(1)) * beta1CM + 0.07 * (1-Pars.dose1_eff_infection(2)) * beta2CM + 0.89 * (1-Pars.dose1_eff_infection(4)) * beta4CM;
        temp_Iv2 = 0.04 * (1-Pars.dose2_eff_infection(1)) * beta1CM + 0.07 * (1-Pars.dose2_eff_infection(2)) * beta2CM + 0.89 * (1-Pars.dose2_eff_infection(4)) * beta4CM;
    elseif t >= Pars.t_aug_start && t < Pars.t_sep_start
        temp_I = 0.03 * beta2CM + 0.97 * beta4CM; 
        temp_Iv1 = 0.03 * (1-Pars.dose1_eff_infection(2)) * beta2CM + 0.97 * (1-Pars.dose1_eff_infection(4)) * beta4CM; 
        temp_Iv2 = 0.03 * (1-Pars.dose2_eff_infection(2)) * beta2CM + 0.97 * (1-Pars.dose2_eff_infection(4)) * beta4CM; 
    elseif t >= Pars.t_sep_start && t < Pars.t_nov_start
        temp_I = beta4CM;
        temp_Iv1 = (1-Pars.dose1_eff_infection(4)) * beta4CM;
        temp_Iv2 = (1-Pars.dose2_eff_infection(4)) * beta4CM;
    elseif t >= Pars.t_nov_start && t < Pars.t_omicron_start
        temp_I = 0.06 * beta1CM + 0.94 * beta4CM;
        temp_Iv1 = 0.06 * (1-Pars.dose1_eff_infection(1)) * beta1CM + 0.94 * (1-Pars.dose1_eff_infection(4)) * beta4CM;
        temp_Iv2 = 0.06 * (1-Pars.dose2_eff_infection(1)) * beta1CM + 0.94 * (1-Pars.dose2_eff_infection(4)) * beta4CM;
    else
        temp_I = 0.01 * beta1CM + 0.79 * beta4CM + 0.2 *beta5CM;    
        temp_Iv1 = 0.01 * (1-Pars.dose1_eff_infection(1)) * beta1CM + 0.79 * (1-Pars.dose1_eff_infection(4)) * beta4CM + 0.2 * (1-Pars.dose1_eff_infection(5)) *beta5CM;  
        temp_Iv2 = 0.01 * (1-Pars.dose2_eff_infection(1)) * beta1CM + 0.79 * (1-Pars.dose2_eff_infection(4)) * beta4CM + 0.2 * (1-Pars.dose2_eff_infection(5)) *beta5CM;        
    end

    temp_I_CM     =   temp_I/infec2tot*CM;
    temp_Iv2_CM  =   temp_Iv2/infec2tot*CM;

    

    
    %% (5) Model Equations -----------------------------------------------------
    
    v_foisVec = temp_I*CM*(1 - Pars.q_fixbasic);
    v_foisVec_v1 = temp_Iv1*CM*(1 - Pars.q_fixbasic);
    v_foisVec_v2 = temp_Iv2*CM*(1 - Pars.q_fixbasic);
    

    S2E     = min(1,v_foisVec) .* X(Pars.S_ids);
    S2V1    = min((X(Pars.S_ids) - S2E),(50000 *ratio_2vac));
    V12Ev1  = min(1,v_foisVec_v1) * X(Pars.V1_ids);
    V12V2   = (X(Pars.V1_ids)-V12Ev1)/28;
    V22Ev2  = min(1,v_foisVec_v2) * X(Pars.V2_ids);

    E2P     = Pars.mu_a * X(Pars.E_ids);
    Ev12Pv1 = Pars.mu_a * X(Pars.Ev1_ids);
    Ev22Pv2 = Pars.mu_a * X(Pars.Ev2_ids);

    P2I     = Pars.D_p * P; 
    Pv12Iv1 = Pars.D_p * Pv1; 
    Pv22Iv2 = Pars.D_p * Pv2; 

    I2CT    = Pars.ct * I; 
    I2RD    = (1 - Pars.ct)  * Pars.gamma_a * I;
    Iv12CTv1    = Pars.ct * Iv1; 
    Iv12RDv1    = (1 - Pars.ct)  * Pars.gamma_a * Iv1;
    Iv22CTv2    = Pars.ct * Iv2; 
    Iv22RDv2    = (1 - Pars.ct)  * Pars.gamma_a * Iv2;
    
    CT2RD       = CT/28;
    CTv12RDv1   = CTv1/28;
    CTv22RDv2   = CTv2/28;

    dYdt(Pars.S_ids)    = - S2E - S2V1;    % S-E
    dYdt(Pars.V1_ids)   = S2V1  - V12V2 - V12Ev1;
    dYdt(Pars.V2_ids)   = V12V2 - V22Ev2;
    dYdt(Pars.E_ids)    = S2E - E2P;   %E-I
    dYdt(Pars.Ev1_ids)  = V12Ev1 - Ev12Pv1;
    dYdt(Pars.Ev2_ids)  = V22Ev2 - Ev22Pv2;
    dYdt(Pars.P_ids)    = E2P -  P2I;
    dYdt(Pars.Pv1_ids)  = Ev12Pv1 - Pv12Iv1;
    dYdt(Pars.Pv2_ids)  = Ev22Pv2 - Pv22Iv2;
    dYdt(Pars.I_ids)    = P2I- I2RD - I2CT;
    dYdt(Pars.Iv1_ids)  = Pv12Iv1- Iv12RDv1 - Iv12CTv1;
    dYdt(Pars.Iv2_ids)  = Pv22Iv2- Iv22RDv2 - Iv22CTv2;
    dYdt(Pars.CT_ids)   = I2CT - CT2RD; 
    dYdt(Pars.CTv1_ids) = Iv12CTv1 - CTv12RDv1; 
    dYdt(Pars.CTv2_ids) = Iv22CTv2 - CTv22RDv2; 

    
    
    
    if t < Pars.t_alpha_start
        Dratio = Pars.epsilon(1).*Pars.xi_a';
        Dv1ratio = Pars.epsilon(1).*Pars.xi_a'*(1-Pars.dose1_eff_death(1));
        Dv2ratio = Pars.epsilon(1).*Pars.xi_a'*(1-Pars.dose2_eff_death(1));
    elseif t > Pars.t_alpha_start && t < Pars.t_beta_start
        Dratio = (0.95 * Pars.epsilon(1) + 0.05 * Pars.epsilon(2)) .* Pars.xi_a';
        Dv1ratio = (0.95 * Pars.epsilon(1) *(1-Pars.dose1_eff_death(1)) + 0.05 * Pars.epsilon(2)*(1-Pars.dose1_eff_death(2))) .* Pars.xi_a';
        Dv2ratio = (0.95 * Pars.epsilon(1) *(1-Pars.dose2_eff_death(1)) + 0.05 * Pars.epsilon(2)*(1-Pars.dose2_eff_death(2))) .* Pars.xi_a';
    elseif t >= Pars.t_beta_start && t < Pars.t_jan_start
        Dratio = (0.95 * Pars.epsilon(1) + 0.05 * Pars.epsilon(3)) .* Pars.xi_a';
        Dv1ratio = (0.95 * Pars.epsilon(1)*(1-Pars.dose1_eff_death(1)) + 0.05 * Pars.epsilon(3)*(1-Pars.dose1_eff_death(3))) .* Pars.xi_a';
        Dv2ratio = (0.95 * Pars.epsilon(1)*(1-Pars.dose2_eff_death(1)) + 0.05 * Pars.epsilon(3)*(1-Pars.dose2_eff_death(3))) .* Pars.xi_a';
    elseif t >= Pars.t_jan_start && t < Pars.t_feb_start
        Dratio = (0.97 * Pars.epsilon(1) + 0.03 * Pars.epsilon(2)) .* Pars.xi_a';
        Dv1ratio = (0.97 * Pars.epsilon(1)*(1-Pars.dose1_eff_death(1)) + 0.03 * Pars.epsilon(2)*(1-Pars.dose1_eff_death(2))) .* Pars.xi_a';
        Dv2ratio = (0.97 * Pars.epsilon(1)*(1-Pars.dose2_eff_death(1)) + 0.03 * Pars.epsilon(2)*(1-Pars.dose2_eff_death(2))) .* Pars.xi_a';
    elseif t >= Pars.t_feb_start && t < Pars.t_mar_start
        Dratio = (0.88 * Pars.epsilon(1) + 0.12 * Pars.epsilon(3)) .* Pars.xi_a';
        Dv1ratio = (0.88 * Pars.epsilon(1)*(1-Pars.dose1_eff_death(1)) + 0.12 * Pars.epsilon(3)*(1-Pars.dose1_eff_death(3))) .* Pars.xi_a';
        Dv2ratio = (0.88 * Pars.epsilon(1)*(1-Pars.dose2_eff_death(1)) + 0.12 * Pars.epsilon(3)*(1-Pars.dose2_eff_death(3))) .* Pars.xi_a';
    elseif t >= Pars.t_mar_start && t < Pars.t_delta_start
        Dratio = (0.78 * Pars.epsilon(1) + 0.10 * Pars.epsilon(2) + 0.12 * Pars.epsilon(3)) .* Pars.xi_a';
        Dv1ratio = (0.78 * Pars.epsilon(1)*(1-Pars.dose1_eff_death(1)) + 0.10 * Pars.epsilon(2)*(1-Pars.dose1_eff_death(2)) + 0.12 * Pars.epsilon(3)*(1-Pars.dose1_eff_death(3))) .* Pars.xi_a';
        Dv2ratio = (0.78 * Pars.epsilon(1)*(1-Pars.dose2_eff_death(1)) + 0.10 * Pars.epsilon(2)*(1-Pars.dose2_eff_death(2)) + 0.12 * Pars.epsilon(3)*(1-Pars.dose2_eff_death(3))) .* Pars.xi_a';
    elseif t >= Pars.t_delta_start && t < Pars.t_apr_start
        Dratio = (0.33 * Pars.epsilon(1) + 0.33 * Pars.epsilon(2) + 0.27 * Pars.epsilon(3) + 0.07 *Pars.epsilon(4)) .* Pars.xi_a';
        Dv1ratio = (0.33 * Pars.epsilon(1)*(1-Pars.dose1_eff_death(1)) + 0.33 * Pars.epsilon(2)*(1-Pars.dose1_eff_death(2)) + 0.27 * Pars.epsilon(3)*(1-Pars.dose1_eff_death(3)) + 0.07 * Pars.epsilon(4)*(1-Pars.dose1_eff_death(4))) .* Pars.xi_a';
        Dv2ratio = (0.33 * Pars.epsilon(1)*(1-Pars.dose2_eff_death(1)) + 0.33 * Pars.epsilon(2)*(1-Pars.dose2_eff_death(2)) + 0.27 * Pars.epsilon(3)*(1-Pars.dose2_eff_death(3)) + 0.07 * Pars.epsilon(4)*(1-Pars.dose2_eff_death(4))) .* Pars.xi_a';
    elseif t >= Pars.t_apr_start && t < Pars.t_may_start
        Dratio = (0.32 * Pars.epsilon(1) + 0.13 * Pars.epsilon(2) + 0.31* Pars.epsilon(3) + 0.23 *Pars.epsilon(4)) .* Pars.xi_a';
        Dv1ratio = (0.32 * Pars.epsilon(1)*(1-Pars.dose1_eff_death(1)) + 0.13 * Pars.epsilon(2)*(1-Pars.dose1_eff_death(2)) + 0.31 * Pars.epsilon(3)*(1-Pars.dose1_eff_death(3)) + 0.23 * Pars.epsilon(4)*(1-Pars.dose1_eff_death(4))) .* Pars.xi_a';
        Dv2ratio = (0.32 * Pars.epsilon(1)*(1-Pars.dose2_eff_death(1)) + 0.13 * Pars.epsilon(2)*(1-Pars.dose2_eff_death(2)) + 0.31 * Pars.epsilon(3)*(1-Pars.dose2_eff_death(3)) + 0.23 * Pars.epsilon(4)*(1-Pars.dose2_eff_death(4))) .* Pars.xi_a';
    elseif t >= Pars.t_may_start && t < Pars.t_jun_start
        Dratio = (0.19 * Pars.epsilon(1) + 0.1 * Pars.epsilon(2) + 0.45 * Pars.epsilon(3) + 0.26 *Pars.epsilon(4)) .* Pars.xi_a';
        Dv1ratio = (0.19 * Pars.epsilon(1)*(1-Pars.dose1_eff_death(1)) + 0.1 * Pars.epsilon(2)*(1-Pars.dose1_eff_death(2)) + 0.45 * Pars.epsilon(3)*(1-Pars.dose1_eff_death(3)) + 0.26 * Pars.epsilon(4)*(1-Pars.dose1_eff_death(4))) .* Pars.xi_a';
        Dv2ratio = (0.19 * Pars.epsilon(1)*(1-Pars.dose2_eff_death(1)) + 0.1 * Pars.epsilon(2)*(1-Pars.dose2_eff_death(2)) + 0.45 * Pars.epsilon(3)*(1-Pars.dose2_eff_death(3)) + 0.26 * Pars.epsilon(4)*(1-Pars.dose2_eff_death(4))) .* Pars.xi_a';
    elseif t >= Pars.t_jun_start && t < Pars.t_jul_start
        Dratio = (0.05 * Pars.epsilon(1) + 0.09 * Pars.epsilon(2) + 0.01 * Pars.epsilon(3) + 0.85 *Pars.epsilon(4)) .* Pars.xi_a';
        Dv1ratio = (0.05 * Pars.epsilon(1)*(1-Pars.dose1_eff_death(1)) + 0.09 * Pars.epsilon(2)*(1-Pars.dose1_eff_death(2)) + 0.01 * Pars.epsilon(3)*(1-Pars.dose1_eff_death(3)) + 0.85 * Pars.epsilon(4)*(1-Pars.dose1_eff_death(4))) .* Pars.xi_a';
        Dv2ratio = (0.05 * Pars.epsilon(1)*(1-Pars.dose2_eff_death(1)) + 0.09 * Pars.epsilon(2)*(1-Pars.dose2_eff_death(2)) + 0.01 * Pars.epsilon(3)*(1-Pars.dose2_eff_death(3)) + 0.85 * Pars.epsilon(4)*(1-Pars.dose2_eff_death(4))) .* Pars.xi_a';
    elseif t >= Pars.t_jul_start && t < Pars.t_aug_start
        Dratio = (0.04 * Pars.epsilon(1) + 0.07 * Pars.epsilon(2) + 0.89 *Pars.epsilon(4)) .* Pars.xi_a';
        Dv1ratio = (0.04 * Pars.epsilon(1)*(1-Pars.dose1_eff_death(1)) + 0.07 * Pars.epsilon(2)*(1-Pars.dose1_eff_death(2)) + 0.89 * Pars.epsilon(4)*(1-Pars.dose1_eff_death(4))) .* Pars.xi_a';
        Dv2ratio = (0.04 * Pars.epsilon(1)*(1-Pars.dose2_eff_death(1)) + 0.07 * Pars.epsilon(2)*(1-Pars.dose2_eff_death(2)) + 0.89 * Pars.epsilon(4)*(1-Pars.dose2_eff_death(4))) .* Pars.xi_a';
    elseif t >= Pars.t_aug_start && t < Pars.t_sep_start
        Dratio = (0.03 * Pars.epsilon(1) + 0.97 *Pars.epsilon(4)) .* Pars.xi_a';
        Dv1ratio = (0.03 * Pars.epsilon(1)*(1-Pars.dose1_eff_death(1)) + 0.97 * Pars.epsilon(4)*(1-Pars.dose1_eff_death(4))) .* Pars.xi_a';
        Dv2ratio = (0.03 * Pars.epsilon(1)*(1-Pars.dose2_eff_death(1)) + 0.97 * Pars.epsilon(4)*(1-Pars.dose2_eff_death(4))) .* Pars.xi_a';
    elseif t >= Pars.t_sep_start && t < Pars.t_nov_start
        Dratio = Pars.epsilon(4).*Pars.xi_a';
        Dv1ratio = Pars.epsilon(4).*Pars.xi_a'*(1-Pars.dose1_eff_death(4));
        Dv2ratio = Pars.epsilon(4).*Pars.xi_a'*(1-Pars.dose2_eff_death(4));
    elseif t >= Pars.t_nov_start && t < Pars.t_omicron_start
        Dratio = (0.06 * Pars.epsilon(1) + 0.94 *Pars.epsilon(4)) .* Pars.xi_a';
        Dv1ratio = (0.06 * Pars.epsilon(1)*(1-Pars.dose1_eff_death(1)) + 0.94 * Pars.epsilon(4)*(1-Pars.dose1_eff_death(4))) .* Pars.xi_a';
        Dv2ratio = (0.06 * Pars.epsilon(1)*(1-Pars.dose2_eff_death(1)) + 0.94 * Pars.epsilon(4)*(1-Pars.dose2_eff_death(4))) .* Pars.xi_a';
    else
        Dratio = (0.01 * Pars.epsilon(1) + 0.79 * Pars.epsilon(4) + 0.2 *Pars.epsilon(5)) .* Pars.xi_a';
        Dv1ratio = (0.01 * Pars.epsilon(1)*(1-Pars.dose1_eff_death(1)) + 0.79 * Pars.epsilon(4)*(1-Pars.dose1_eff_death(4)) + 0.2 * Pars.epsilon(5)*(1-Pars.dose1_eff_death(5))) .* Pars.xi_a';
        Dv2ratio = (0.01 * Pars.epsilon(1)*(1-Pars.dose2_eff_death(1)) + 0.79 * Pars.epsilon(4)*(1-Pars.dose2_eff_death(4)) + 0.2 * Pars.epsilon(5)*(1-Pars.dose2_eff_death(5))) .* Pars.xi_a';
    end
    
    Rratio = 1 - Dratio;
    Rv1ratio = 1 - Dv1ratio;
    Rv2ratio = 1 - Dv2ratio;

    

    dYdt(Pars.R_ids) = (I2RD + CT2RD) *Rratio; 
    dYdt(Pars.D_ids) = (I2RD + CT2RD) *Dratio;  

    dYdt(Pars.Rv1_ids) = (Iv12RDv1 + CTv12RDv1) *Rv1ratio; 
    dYdt(Pars.Dv1_ids) = (Iv12RDv1 + CTv12RDv1) *Dv1ratio; 

    dYdt(Pars.Rv2_ids) = (Iv22RDv2 + CTv22RDv2) *Rv2ratio; 
    dYdt(Pars.Dv2_ids) = (Iv22RDv2 + CTv22RDv2) *Dv2ratio; 



    dYdt(Pars.Y2vac_ids) = Pars.kappa_2vac * (1 - ratio_2vac) .* ratio_2vac.*(temp_I_CM - temp_Iv2_CM + Pars.r_2vac.*(Dratio - Dv2ratio) + Pars.threshold_2vac); %+ Pars.npi_payoff

    end







