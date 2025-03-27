input_defaults % Load pars_default

%% Set to default
pars_phase_3 = pars_default;

%% Read Reported Cases Data

effectiveness_npis      = readtable("GM_all.csv",                   "VariableNamingRule","preserve");
daily_local_report      = readtable("Daily_cases_local_report.csv","VariableNamingRule","preserve");
daily_deceased          = readtable("Deceased_Cases_Count.csv","VariableNamingRule","preserve");

vac_count_P               = readtable("bar_vaccination_P.csv",     "VariableNamingRule","preserve");
vac_count_B               = readtable("bar_vaccination_booster.csv",     "VariableNamingRule","preserve");


dateidx =   771:857;
vacidx  =   366:452;
Bidx = 108:194;

daily_local_target          =   daily_local_report(:,2).Variables;
daily_local_target_mov      =   movmean(daily_local_target,7);
pars_phase_3.local_target   =   daily_local_target(dateidx);
pars_phase_3.local_target_mov   =   daily_local_target_mov(dateidx);

daily_deceased_target       =   daily_deceased(:,2).Variables;
daily_deceased_target_mov   =   movmean(daily_deceased_target,7);
pars_phase_3.deceased_target =  daily_deceased_target(dateidx);
pars_phase_3.deceased_target_mov =  daily_deceased_target_mov(dateidx);

vac_target_P    =   vac_count_P(:,2).Variables;
vac_target_B    =   vac_count_B(:,2).Variables;
vac_target_P_mov      =   movmean(vac_target_P,7);
vac_target_B_mov      =   movmean(vac_target_B,7);

l_temp          =   length(dateidx);


pars_phase_3.vac_count_P    = vac_target_P(vacidx);
pars_phase_3.vac_count_B      = vac_target_B(Bidx);
pars_phase_3.vac_count_P_mov    = vac_target_P_mov(vacidx);
pars_phase_3.vac_count_B_mov      = vac_target_B_mov(Bidx);

% Timeline
pars_phase_3.t0 = datetime(2022,02,25); 
pars_phase_3.tf = datetime(2022,05,23);

pars_phase_3.dec_start      =   datetime(2020,12,01);
pars_phase_3.t_dec_start    =   days(pars_phase_3.dec_start - pars_phase_3.t0);
pars_phase_3.alpha_start    =   datetime(2020,12,06);
pars_phase_3.t_alpha_start  =   days(pars_phase_3.alpha_start - pars_phase_3.t0);
pars_phase_3.beta_start     =   datetime(2020,12,27);
pars_phase_3.t_beta_start   =   days(pars_phase_3.beta_start - pars_phase_3.t0);


pars_phase_3.jan_start      =   datetime(2021,01,01);
pars_phase_3.t_jan_start    =   days(pars_phase_3.jan_start - pars_phase_3.t0);
pars_phase_3.feb_start      =   datetime(2021,02,01);
pars_phase_3.t_feb_start    =   days(pars_phase_3.feb_start - pars_phase_3.t0);
pars_phase_3.mar_start      =   datetime(2021,03,01);
pars_phase_3.t_mar_start    =   days(pars_phase_3.mar_start - pars_phase_3.t0);
pars_phase_3.delta_start    =   datetime(2021,03,25);
pars_phase_3.t_delta_start  =   days(pars_phase_3.delta_start - pars_phase_3.t0);
pars_phase_3.apr_start      =   datetime(2021,04,01);
pars_phase_3.t_apr_start    =   days(pars_phase_3.apr_start - pars_phase_3.t0);
pars_phase_3.may_start      =   datetime(2021,05,01);
pars_phase_3.t_may_start    =   days(pars_phase_3.may_start - pars_phase_3.t0);
pars_phase_3.jun_start      =   datetime(2021,06,01);
pars_phase_3.t_jun_start    =   days(pars_phase_3.jun_start - pars_phase_3.t0);
pars_phase_3.jul_start      =   datetime(2021,07,01);
pars_phase_3.t_jul_start    =   days(pars_phase_3.jul_start - pars_phase_3.t0);
pars_phase_3.aug_start      =   datetime(2021,08,01);
pars_phase_3.t_aug_start    =   days(pars_phase_3.aug_start - pars_phase_3.t0);
pars_phase_3.sep_start      =   datetime(2021,09,01);
pars_phase_3.t_sep_start    =   days(pars_phase_3.sep_start - pars_phase_3.t0);
pars_phase_3.oct_start      =   datetime(2021,10,01);
pars_phase_3.t_oct_start    =   days(pars_phase_3.oct_start - pars_phase_3.t0);
pars_phase_3.nov_start      =   datetime(2021,11,01);
pars_phase_3.t_nov_start    =   days(pars_phase_3.nov_start - pars_phase_3.t0);
pars_phase_3.omicron_start  =   datetime(2021,11,13);
pars_phase_3.t_omicron_start =  days(pars_phase_3.omicron_start - pars_phase_3.t0);

pars_phase_3.dec21_start    =   datetime(2021,12,01);
pars_phase_3.t_dec21_start  =   days(pars_phase_3.dec21_start - pars_phase_3.t0);
pars_phase_3.jan22_start    =   datetime(2022,01,01);
pars_phase_3.t_jan22_start  =   days(pars_phase_3.jan22_start - pars_phase_3.t0);
pars_phase_3.feb22_start    =   datetime(2022,02,01);
pars_phase_3.t_feb22_start  =   days(pars_phase_3.feb22_start - pars_phase_3.t0);
pars_phase_3.mar22_start    =   datetime(2022,03,01);
pars_phase_3.t_mar22_start  =   days(pars_phase_3.mar22_start - pars_phase_3.t0);


pars_phase_3.nDays = days(pars_phase_3.tf - pars_phase_3.t0);
pars_phase_3.times = 1:pars_phase_3.nDays;
pars_phase_3.t_slice = effectiveness_npis.Date';
pars_phase_3.t_slice = datetime(pars_phase_3.t_slice,'InputFormat','yyyy/MM/dd');

pars_phase_3.contact_reduced = effectiveness_npis.Reduced; 

tStart = days(pars_phase_3.t_slice - pars_phase_3.t0);
beforeidx = sum(tStart<1);
pars_phase_3.beforeidx = beforeidx;

% Back-calculate initial conditions from X0_target
pars_phase_3.X0_target = Get_Inits(pars_phase_3);

