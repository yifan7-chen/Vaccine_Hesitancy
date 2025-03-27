input_defaults % Load pars_default

%% Set to default
pars_phase_2 = pars_default;

%% Read Reported Cases Data

effectiveness_npis      = readtable("GM_all.csv",                   "VariableNamingRule","preserve");
daily_local_report      = readtable("Daily_cases_local_report.csv","VariableNamingRule","preserve");
daily_deceased          = readtable("Deceased_Cases_Count.csv","VariableNamingRule","preserve");

vac_count               = readtable("bar_vaccination_date.csv",     "VariableNamingRule","preserve");

dateidx = 432:443; 
vacidx  =  31:42;

daily_local_target = daily_local_report(:,2).Variables;
daily_local_target_mov = movmean(daily_local_target,7);
pars_phase_2.local_target = daily_local_target(dateidx);
pars_phase_2.local_target_mov = daily_local_target_mov(dateidx);
daily_deceased_target = daily_deceased(:,2).Variables;
daily_deceased_target_mov = movmean(daily_deceased_target,7);
pars_phase_2.deceased_target = daily_deceased_target(dateidx);
pars_phase_2.deceased_target_mov = daily_deceased_target_mov(dateidx);

vac_target           = vac_count(vacidx,2).Variables;
vac_target_mov = movmean(vac_target,7);

l_temp = length(dateidx);

% Set the target as the rate of new deaths.

pars_phase_2.report_local = daily_local_report(:,2).Variables;
pars_phase_2.report_local = movmean(pars_phase_2.report_local,[6 0]);
pars_phase_2.report_local = pars_phase_2.report_local(dateidx);

pars_phase_2.report_death = daily_deceased(:,2).Variables;
pars_phase_2.report_death = movmean(pars_phase_2.report_death,[6 0]);
pars_phase_2.report_death = pars_phase_2.report_death(dateidx);
pars_phase_2.vac_count    = vac_target;
pars_phase_2.vac_count_mov    = vac_target_mov;



% Timeline
pars_phase_2.t0 = datetime(2021,03,23); 
pars_phase_2.tf = datetime(2021,04,04);

pars_phase_2.dec_start = datetime(2020,12,01);
pars_phase_2.t_dec_start = days(pars_phase_2.dec_start - pars_phase_2.t0);
pars_phase_2.alpha_start = datetime(2020,12,06);
pars_phase_2.t_alpha_start = days(pars_phase_2.alpha_start - pars_phase_2.t0);
pars_phase_2.beta_start = datetime(2020,12,27);
pars_phase_2.t_beta_start = days(pars_phase_2.beta_start - pars_phase_2.t0);


pars_phase_2.jan_start = datetime(2021,01,01);
pars_phase_2.t_jan_start = days(pars_phase_2.jan_start - pars_phase_2.t0);
pars_phase_2.feb_start = datetime(2021,02,01);
pars_phase_2.t_feb_start = days(pars_phase_2.feb_start - pars_phase_2.t0);
pars_phase_2.mar_start = datetime(2021,03,01);
pars_phase_2.t_mar_start = days(pars_phase_2.mar_start - pars_phase_2.t0);
pars_phase_2.delta_start = datetime(2021,03,25);
pars_phase_2.t_delta_start = days(pars_phase_2.delta_start - pars_phase_2.t0);
pars_phase_2.apr_start = datetime(2021,04,01);
pars_phase_2.t_apr_start = days(pars_phase_2.apr_start - pars_phase_2.t0);
pars_phase_2.may_start = datetime(2021,05,01);
pars_phase_2.t_may_start = days(pars_phase_2.may_start - pars_phase_2.t0);
pars_phase_2.jun_start = datetime(2021,06,01);
pars_phase_2.t_jun_start = days(pars_phase_2.jun_start - pars_phase_2.t0);
pars_phase_2.jul_start = datetime(2021,07,01);
pars_phase_2.t_jul_start = days(pars_phase_2.jul_start - pars_phase_2.t0);
pars_phase_2.aug_start = datetime(2021,08,01);
pars_phase_2.t_aug_start = days(pars_phase_2.aug_start - pars_phase_2.t0);
pars_phase_2.sep_start = datetime(2021,09,01);
pars_phase_2.t_sep_start = days(pars_phase_2.sep_start - pars_phase_2.t0);
pars_phase_2.oct_start = datetime(2021,10,01);
pars_phase_2.t_oct_start = days(pars_phase_2.oct_start - pars_phase_2.t0);
pars_phase_2.nov_start = datetime(2021,11,01);
pars_phase_2.t_nov_start = days(pars_phase_2.nov_start - pars_phase_2.t0);
pars_phase_2.omicron_start = datetime(2021,11,13);
pars_phase_2.t_omicron_start = days(pars_phase_2.omicron_start - pars_phase_2.t0);





pars_phase_2.nDays = days(pars_phase_2.tf - pars_phase_2.t0);
pars_phase_2.times = 1:pars_phase_2.nDays;
pars_phase_2.t_slice = effectiveness_npis.Date';
pars_phase_2.t_slice = datetime(pars_phase_2.t_slice,'InputFormat','yyyy/MM/dd');

pars_phase_2.contact_reduced = effectiveness_npis.Reduced; 

tStart = days(pars_phase_2.t_slice - pars_phase_2.t0);
beforeidx = sum(tStart<1);
pars_phase_2.beforeidx = beforeidx;

% Back-calculate initial conditions from X0_target
pars_phase_2.X0_target = Get_Inits(pars_phase_2);
