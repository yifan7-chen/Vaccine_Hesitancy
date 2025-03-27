function dYdt = SEIRD_model_full(t, X, Pars)
    
    %% (0) Setup ---------------------------------------------------------------
    
    dYdt=zeros(length(X),1);   
    
    %% Update Pars
     

    P = X(Pars.P_ids);
    I = X(Pars.I_ids);
    CT = X(Pars.CT_ids);



    
    % Population sizes at time t    
    
    tot = sum(X(1:6));    %row - sum

    %% (1) Derive Contact Matrices ---------------------------------------------
    if t<=Pars.center
        Pars.AllContacts = Pars.AllContacts * Pars.p_sp;
    else
        Pars.AllContacts = Pars.AllContacts * Pars.p_sp_c;
    end



    CM = Pars.AllContacts .* (1 + Pars.contact_reduced(floor(t)+Pars.beforeidx));


    infec = Pars.alpha * P + Pars.alpha_i * I;
    
    
    %% (3) Calculate v_fois ------------------------------------------------------
    
    % Force of infection by group 
    infec2tot = infec./tot.*Pars.relative_susceptibility';
    beta1CM = Pars.beta(1) * infec2tot;
    beta2CM = Pars.beta(2) * infec2tot;
    beta3CM = Pars.beta(3) * infec2tot;

    if t < Pars.t_alpha_start
        temp_I = beta1CM; 

    elseif t >= Pars.t_alpha_start && t < Pars.t_beta_start
        temp_I = 0.95 * beta1CM + 0.05 * beta2CM;  

    elseif t >= Pars.t_beta_start && t < Pars.t_jan_start
        temp_I = 0.95 * beta1CM + 0.05 * beta3CM; 
    elseif t >= Pars.t_jan_start && t < Pars.t_feb_start
        temp_I = 0.97 * beta1CM + 0.03 * beta2CM;   

    elseif t >= Pars.t_feb_start && t < Pars.t_mar_start
        temp_I = 0.88 * beta1CM + 0.12 * beta3CM; 

    else
        temp_I = 0.78 * beta1CM + 0.10 * beta2CM + 0.12 * beta3CM;

    end


    
    
    %% (5) Model Equations -----------------------------------------------------
    
    v_foisVec = temp_I*CM*(1 - Pars.q_fixbasic);

    
    S2E =min(1,v_foisVec) .* X(Pars.S_ids);
    E2P = Pars.mu_a * X(Pars.E_ids);
    P2I = Pars.D_p * P ; 
    I2CT = Pars.ct * I; 
    I2RD = (1-Pars.ct) * Pars.gamma_a  * I;
    CT2RD = CT /28 ;
    dYdt(Pars.S_ids) = - S2E;    % S-E
    dYdt(Pars.E_ids) = S2E - E2P;   %E-I
    dYdt(Pars.P_ids) = E2P - P2I;
    dYdt(Pars.I_ids) =  P2I- I2RD - I2CT;

    dYdt(Pars.CT_ids) =  I2CT  - CT2RD;
    
    
    if t < Pars.t_alpha_start
        Dratio = Pars.epsilon(1).*Pars.xi_a';
    elseif t > Pars.t_alpha_start && t < Pars.t_beta_start
        Dratio = (0.95 * Pars.epsilon(1) + 0.05 * Pars.epsilon(2)) .* Pars.xi_a';
    elseif t >= Pars.t_beta_start && t < Pars.t_jan_start
        Dratio = (0.95 * Pars.epsilon(1) + 0.05 * Pars.epsilon(3)) .* Pars.xi_a';
    elseif t >= Pars.t_jan_start && t < Pars.t_feb_start
        Dratio = (0.97 * Pars.epsilon(1) + 0.03 * Pars.epsilon(2)) .* Pars.xi_a';
    elseif t >= Pars.t_feb_start && t < Pars.t_mar_start
        Dratio = (0.88 * Pars.epsilon(1) + 0.12 * Pars.epsilon(3)) .* Pars.xi_a';
    else
        Dratio = (0.78 * Pars.epsilon(1) + 0.10 * Pars.epsilon(2) + 0.12 * Pars.epsilon(3)) .* Pars.xi_a';
    end
    
    Rratio = 1 - Dratio;


    dYdt(Pars.R_ids) = (I2RD + CT2RD) *Rratio; 
    dYdt(Pars.D_ids) = (I2RD + CT2RD) *Dratio;    

