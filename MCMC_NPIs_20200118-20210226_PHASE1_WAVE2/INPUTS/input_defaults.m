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

model_pars.compartments = ["S",     "E",    "P",    "I",    "CT",   "R",    "D"];
model_pars.nCompartments = length(model_pars.compartments); %ALWAYS: S, E, I, R, D
Nc = model_pars.nCompartments;

% model_pars.ratios = "X";
% model_pars.nratios = length(model_pars.ratios);
% Nr = model_pars.nratios;

% Variable Names
model_pars.varNames = model_pars.compartments;

temp_idxNames = 1:(N*Nc);
model_pars.idxNames = temp_idxNames;



% Variables in Matrix Format
temp_varMat = reshape(model_pars.varNames, N, Nc);
model_pars.varMat = temp_varMat; %columns are compartments, rows are population subclasses
temp_idxMat = reshape(model_pars.idxNames, N, Nc);
model_pars.idxMat = temp_idxMat; %columns are compartments, rows are population subclasses

% Base Compartment Indices
model_pars.S_ids   = 0*N+(1:N);
model_pars.E_ids  = 1*N+(1:N);
model_pars.P_ids  = 2*N+(1:N);
model_pars.I_ids  = 3*N+(1:N);
model_pars.CT_ids  = 4*N+(1:N);
model_pars.R_ids   = 5*N+(1:N);
model_pars.D_ids   = 6*N+(1:N);
% model_pars.X_ids   = 7*N+(1:N);


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
% epi_pars.gamma_a = 1/5.2; 
% the probability of transmission per contact of different strains (original strain,alpha、beta、delta、omicron)
epi_pars.beta = [   epi_pars.r, ...
               1.29*epi_pars.r, ...
               1.25*epi_pars.r, ...
               1.97*epi_pars.r, ...
          1.97*3.31*epi_pars.r];  



epi_pars.dose1_eff_infection = [0.63,   0.67,   0.50,   0.57,   0];      % the 1-dose efficacy of vaccines against infection from strain i
epi_pars.dose2_eff_infection = [0.92,   0.88,   0.86,   0.89,   0.36];      % the 2-dose efficacy of vaccines against infection from strain i
epi_pars.dosebooster_eff_infection = [0.97,    0.6];      % \delta \omicron the booster-dose efficacy of vaccines against infection from strain i

epi_pars.relative_susceptibility = 1;

epi_pars.epsilon = [1,  1.37,   1.5,    2.33,   0.7223];             % The severity of strain i
epi_pars.xi_a = 0.01 * 1.1203;
epi_pars.dose1_eff_death = [0.77,   0.82,   0.64,   0.81,   0];      % the 1-dose efficacy of vaccines against infection from strain i
epi_pars.dose2_eff_death = [0.97,   0.96,   0.92,   0.97,   0.82];      % the 2-dose efficacy of vaccines against infection from strain i
epi_pars.dosebooster_eff_death = [0.99, 0.95];      % \delta \omicron the booster-dose efficacy of vaccines against infection from strain i




% (5) Inits ---------------------------------------------------------------

% Initial conditions
						

initial_states = [7412928.904	7.507018746	6.371335549	5.972400936	33.93238648	87.32309465	0.98936448];
inits.S_as    = initial_states(1);
inits.E_as   = initial_states(2);
inits.P_as   = initial_states(3);
inits.I_as   = initial_states(4);
inits.CT_as   = initial_states(5);
inits.R_as    = initial_states(6);
inits.D_as    = initial_states(7);




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