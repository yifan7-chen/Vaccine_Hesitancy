% (1) Model Parameters ----------------------------------------------------
model_pars = [];

% Population
model_pars.N = 7413070;
% model_pars.ageN = [1072738,3068992,2312061,959279];

% Indices
% model_pars.subgroups = ["c", "y", "e", "me"];
% model_pars.nSubgroups = length(model_pars.subgroups); %ALWAYS: 4
% N = model_pars.nSubgroups;
N = 1;

model_pars.compartments = [ "S",    "V1",   "V2",   "VB",...
                            "E",    "Ev1",  "Ev2",  "EB",...
                            "P",    "Pv1",  "Pv2",  "PB",...
                            "I",    "Iv1",  "Iv2",  "IB",...
                            "CT",   "CTv1", "CTv2", "CTB",...
                            "R",    "Rv1",  "Rv2",  "RB",...
                            "D",    "Dv1",  "Dv2",  "DB",...
                            "Y2vac", "Y2B"];
model_pars.nCompartments = length(model_pars.compartments); %ALWAYS: S, E, I, R, D
Nc = model_pars.nCompartments;


model_pars.varNames = model_pars.compartments;

temp_idxNames = 1:(N*Nc);
model_pars.idxNames = temp_idxNames;



% Variables in Matrix Format
temp_varMat = reshape(model_pars.varNames, N, Nc);
model_pars.varMat = temp_varMat; %columns are compartments, rows are population subclasses
temp_idxMat = reshape(model_pars.idxNames, N, Nc);
model_pars.idxMat = temp_idxMat; %columns are compartments, rows are population subclasses

% Base Compartment Indices
model_pars.S_ids     = 0*N+(1:N);
model_pars.V1_ids    = 1*N+(1:N);
model_pars.V2_ids    = 2*N+(1:N);
model_pars.VB_ids    = 3*N+(1:N);

model_pars.E_ids     = 4*N+(1:N);
model_pars.Ev1_ids   = 5*N+(1:N);
model_pars.Ev2_ids   = 6*N+(1:N);
model_pars.EB_ids    = 7*N+(1:N);

model_pars.P_ids     = 8*N+(1:N);
model_pars.Pv1_ids   = 9*N+(1:N);
model_pars.Pv2_ids   = 10*N+(1:N);
model_pars.PB_ids    = 11*N+(1:N);

model_pars.I_ids     = 12*N+(1:N);
model_pars.Iv1_ids   = 13*N+(1:N);
model_pars.Iv2_ids   = 14*N+(1:N);
model_pars.IB_ids    = 15*N+(1:N);

model_pars.CT_ids    = 16*N+(1:N);
model_pars.CTv1_ids  = 17*N+(1:N);
model_pars.CTv2_ids  = 18*N+(1:N);
model_pars.CTB_ids   = 19*N+(1:N);

model_pars.R_ids     = 20*N+(1:N);
model_pars.Rv1_ids   = 21*N+(1:N);
model_pars.Rv2_ids   = 22*N+(1:N);
model_pars.RB_ids    = 23*N+(1:N);

model_pars.D_ids     = 24*N+(1:N);
model_pars.Dv1_ids   = 25*N+(1:N);
model_pars.Dv2_ids   = 26*N+(1:N);
model_pars.DB_ids    = 27*N+(1:N);

model_pars.Y2vac_ids   = 28*N+(1:N);
model_pars.Y2B_ids     = 29*N+(1:N);





model_pars.nTotSubComp = N*Nc;


% (2) Contact Parameters --------------------------------------------------
contact_pars = [];
% contact_pars.AllContacts = readmatrix('HK_synthetic_contacts_2020_simple.csv');
contact_pars.AllContacts = 14.08121;
% (3) Epi Pars ------------------------------------------------------------

epi_pars = [];
epi_pars.R0         = 2.79;     %2.2            % Note on R0: with base structure
epi_pars.r          = 0.07553;   %epi_pars.r = 0.016723; 
epi_pars.mu_a       = 1/2.9;    %E2P   
epi_pars.D_p        = 1/2.3;     %P2AI
epi_pars.gamma_a    = 1/2.9;     %AI2RD
epi_pars.beta = [   epi_pars.r, ...
               1.29*epi_pars.r, ...
               1.25*epi_pars.r, ...
               1.97*epi_pars.r, ...
          1.97*3.31*epi_pars.r];  


epi_pars.dose1_eff_infection = [0.63,   0.67,   0.50,   0.57,   0];      % the 1-dose efficacy of vaccines against infection from strain i
epi_pars.dose2_eff_infection = [0.92,   0.88,   0.86,   0.89,   0.36];      % the 2-dose efficacy of vaccines against infection from strain i
epi_pars.dosebooster_eff_infection = [0.97,    0.6];      % \delta \omicron the booster-dose efficacy of vaccines against infection from strain i
epi_pars.relative_susceptibility = 0.7249;
epi_pars.epsilon = [1,  1.37,   1.5,    2.33,   0.7223];             % The severity of strain i
epi_pars.xi_a = 0.01 * 1.1203;
epi_pars.dose1_eff_death = [0.77,   0.82,   0.64,   0.81,   0];      % the 1-dose efficacy of vaccines against infection from strain i
epi_pars.dose2_eff_death = [0.97,   0.96,   0.92,   0.97,   0.82];      % the 2-dose efficacy of vaccines against infection from strain i
epi_pars.dosebooster_eff_death = [0.99, 0.95];      % \delta \omicron the booster-dose efficacy of vaccines against infection from strain i



% (5) Inits ---------------------------------------------------------------

% Initial conditions
initial_states = [1071595.46272321	634997.986237916	3333467.87521495	1828738.14185306	49134.4389958635	25925.1738261556	90799.2147719582	29613.5262901615	28197.5132629587	13607.8104938419	49580.9868863995	15531.7620165350	18418.1423363279	8222.94908455906	31103.4989176054	9403.07442993290	18388.2918808139	6792.64459726772	28493.6259101429	7895.12209124339	47918.3064673809	9938.69006802239	42982.6519003472	11698.1680134653	479.325472335866	80.1084844878024	61.8235428860406	4.68445077680960	1.29950206634734	0.898035039855567];
inits.S_as      = initial_states(1);
inits.V1_as     = initial_states(2);
inits.V2_as     = initial_states(3);
inits.VB_as     = initial_states(4);
inits.E_as      = initial_states(5);
inits.Ev1_as    = initial_states(6);
inits.Ev2_as    = initial_states(7);
inits.EB_as     = initial_states(8);
inits.P_as      = initial_states(9);
inits.Pv1_as    = initial_states(10);
inits.Pv2_as    = initial_states(11);
inits.PB_as     = initial_states(12);
inits.I_as      = initial_states(13);
inits.Iv1_as    = initial_states(14);
inits.Iv2_as    = initial_states(15);
inits.IB_as     = initial_states(16);
inits.CT_as     = initial_states(17);
inits.CTv1_as   = initial_states(18);
inits.CTv2_as   = initial_states(19);
inits.CTB_as    = initial_states(20);
inits.R_as      = initial_states(21);
inits.Rv1_as    = initial_states(22);
inits.Rv2_as    = initial_states(23);
inits.RB_as     = initial_states(24);
inits.D_as      = initial_states(25);
inits.Dv1_as    = initial_states(26);
inits.Dv2_as    = initial_states(27);
inits.DB_as     = initial_states(28);




inits.Y2vac_as      = initial_states(29);

inits.Y2B_as        = initial_states(30);





% (6) Remainder -----------------------------------------------------------

% Combine
pars_default = [];

f = fieldnames(model_pars);
for i = 1:length(f)
    pars_default.(f{i}) = model_pars.(f{i});
end

f = fieldnames(contact_pars);
for i = 1:length(f)
    pars_default.(f{i}) = contact_pars.(f{i});
end

f = fieldnames(epi_pars);
for i = 1:length(f)
    pars_default.(f{i}) = epi_pars.(f{i});
end

f = fieldnames(inits);
for i = 1:length(f)
    pars_default.(f{i}) = inits.(f{i});
end


% (7) Test Cases ----------------------------------------------------------
X0 = Get_Inits(pars_default);


clear("t", "Y", "Y_tmax", "contact_pars", "epi_pars", "f", "i", "inits", "intervention_pars", "model_pars", "N", "Nc", "temp_idxMat", "temp_idxNames", "temp_varMat", "temp_reduction");