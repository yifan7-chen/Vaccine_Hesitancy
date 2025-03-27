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

model_pars.compartments = ["S","V1","V2",...
    "E","Ev1","Ev2",...
    "P","Pv1","Pv2",...
    "I","Iv1","Iv2",...
    "CT","CTv1","CTv2",...
    "R","Rv1","Rv2" "D","Dv1","Dv2",...
    "Y2vac"];
model_pars.nCompartments = length(model_pars.compartments); %ALWAYS: S, E, I, R, D
Nc = model_pars.nCompartments;

% model_pars.ratios = "X";
% model_pars.nratios = length(model_pars.ratios);
% Nr = model_pars.nratios;

% Variable Names
% model_pars.varNames = Get_Var_Names(model_pars.compartments,model_pars.subgroups);
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
model_pars.E_ids     = 3*N+(1:N);
model_pars.Ev1_ids   = 4*N+(1:N);
model_pars.Ev2_ids   = 5*N+(1:N);
model_pars.P_ids     = 6*N+(1:N);
model_pars.Pv1_ids   = 7*N+(1:N);
model_pars.Pv2_ids   = 8*N+(1:N);
model_pars.I_ids     = 9*N+(1:N);
model_pars.Iv1_ids   = 10*N+(1:N);
model_pars.Iv2_ids   = 11*N+(1:N);
model_pars.CT_ids    = 12*N+(1:N);
model_pars.CTv1_ids  = 13*N+(1:N);
model_pars.CTv2_ids  = 14*N+(1:N);
model_pars.R_ids     = 15*N+(1:N);
model_pars.Rv1_ids   = 16*N+(1:N);
model_pars.Rv2_ids   = 17*N+(1:N);
model_pars.D_ids     = 18*N+(1:N);
model_pars.Dv1_ids   = 19*N+(1:N);
model_pars.Dv2_ids   = 20*N+(1:N);
model_pars.Y2vac_ids   = 21*N+(1:N);





model_pars.nTotSubComp = N*Nc;


% (2) Contact Parameters --------------------------------------------------
contact_pars = [];
% contact_pars.AllContacts = readmatrix('HK_synthetic_contacts_2020_simple.csv');
contact_pars.AllContacts = 14.08121;
% (3) Epi Pars ------------------------------------------------------------

epi_pars = [];
epi_pars.R0 = 2.79;     %2.2            % Note on R0: with base structure
epi_pars.r  =0.07553;
epi_pars.mu_a = 1/2.9;    %E2P   
epi_pars.D_p = 1/2.3;     %P2AI
epi_pars.gamma_a = 1/2.9;     %AI2RD
epi_pars.beta = [epi_pars.r, 1.29*epi_pars.r, 1.25*epi_pars.r, 1.97*epi_pars.r, 1.97*4.31*epi_pars.r];  

epi_pars.dose1_eff_infection = [0.81 0.67, 0.50, 0.57, 0];      % the 1-dose efficacy of vaccines against infection from strain i
epi_pars.dose2_eff_infection = [0.946 0.88, 0.86, 0.92, 0.2];      % the 2-dose efficacy of vaccines against infection from strain i
epi_pars.relative_susceptibility = 1;
epi_pars.epsilon = [1, 1.37, 1.5, 2.33, 0.7223];             % The severity of strain i
epi_pars.xi_a = 0.01*1.1203;
epi_pars.dose1_eff_death = [0.83 0.82, 0.64, 0.81, 0];      % the 1-dose efficacy of vaccines against infection from strain i
epi_pars.dose2_eff_death = [0.93 0.96, 0.93, 0.98, 0.65];      % the 2-dose efficacy of vaccines against infection from strain i


% (5) Inits ---------------------------------------------------------------

% Initial conditions
				
initial_states = [7013801.749	282280.2237	97028.10083	45.47287276	0.365509324	0.034545266	37.42538014	0.248320085	0.02200715	34.01088169	0.1890711	0.015738378	622.397585	0.296155648	0.019119513	19000.68333	0.49489067	0.029910369	219.2201907	0.001234218	2.44E-05	-1.4187];

% -1.4187
inits.S_as      = initial_states(1);
inits.V1_as     = initial_states(2);
inits.V2_as     = initial_states(3);
inits.E_as      = initial_states(4);
inits.Ev1_as    = initial_states(5);
inits.Ev2_as    = initial_states(6);
inits.P_as      = initial_states(7);
inits.Pv1_as    = initial_states(8);
inits.Pv2_as    = initial_states(9);
inits.I_as   = initial_states(10);
inits.Iv1_as   = initial_states(11);
inits.Iv2_as      = initial_states(12);
inits.CT_as      = initial_states(13);
inits.CTv1_as    = initial_states(14);
inits.CTv2_as    = initial_states(15);
inits.R_as    = initial_states(16);
inits.Rv1_as    = initial_states(17);
inits.Rv2_as    = initial_states(18);
inits.D_as    = initial_states(19);
inits.Dv1_as    = initial_states(20);
inits.Dv2_as    = initial_states(21);

inits.Y2vac_as      = initial_states(22);





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