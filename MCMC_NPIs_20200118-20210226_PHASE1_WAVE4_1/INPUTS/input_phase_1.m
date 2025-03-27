input_defaults % Load pars_default

%% Set to default
pars_phase_1 = pars_default;

%% Read Reported Cases Data

effectiveness_npis = readtable("GM_all.csv","VariableNamingRule","preserve");
daily_local_report = readtable("Daily_cases_local_report.csv","VariableNamingRule","preserve");
daily_deceased = readtable("Deceased_Cases_Count.csv","VariableNamingRule","preserve");

dateidx = 285:353; 

daily_local_target = daily_local_report(:,2).Variables;
daily_local_target_mov = movmean(daily_local_target,7);
pars_phase_1.local_target = daily_local_target(dateidx);
pars_phase_1.local_target_mov = daily_local_target_mov(dateidx);
daily_deceased_target = daily_deceased(:,2).Variables;
daily_deceased_target_mov = movmean(daily_deceased_target,7);
pars_phase_1.deceased_target = daily_deceased_target(dateidx);
pars_phase_1.deceased_target_mov = daily_deceased_target_mov(dateidx);
l_temp = length(dateidx);



pars_phase_1.report_local = daily_local_report(:,2).Variables;
pars_phase_1.report_local = movmean(pars_phase_1.report_local,[6 0]);
pars_phase_1.report_local = pars_phase_1.report_local(dateidx);

pars_phase_1.report_death = daily_deceased(:,2).Variables;
pars_phase_1.report_death = movmean(pars_phase_1.report_death,[6 0]);
pars_phase_1.report_death = pars_phase_1.report_death(dateidx);



% Timeline
pars_phase_1.t0 = datetime(2020,10,27); 
pars_phase_1.tf = datetime(2021,01,04);

pars_phase_1.dec_start = datetime(2020,12,01);
pars_phase_1.t_dec_start = days(pars_phase_1.dec_start - pars_phase_1.t0);
pars_phase_1.alpha_start = datetime(2020,12,06);
pars_phase_1.t_alpha_start = days(pars_phase_1.alpha_start - pars_phase_1.t0);
pars_phase_1.beta_start = datetime(2020,12,27);
pars_phase_1.t_beta_start = days(pars_phase_1.beta_start - pars_phase_1.t0);


pars_phase_1.jan_start = datetime(2021,01,01);
pars_phase_1.t_jan_start = days(pars_phase_1.jan_start - pars_phase_1.t0);
pars_phase_1.feb_start = datetime(2021,02,01);
pars_phase_1.t_feb_start = days(pars_phase_1.feb_start - pars_phase_1.t0);
pars_phase_1.mar_start = datetime(2021,03,01);
pars_phase_1.t_mar_start = days(pars_phase_1.mar_start - pars_phase_1.t0);
pars_phase_1.delta_start = datetime(2021,03,25);
pars_phase_1.t_delta_start = days(pars_phase_1.delta_start - pars_phase_1.t0);
pars_phase_1.apr_start = datetime(2021,04,01);
pars_phase_1.t_apr_start = days(pars_phase_1.apr_start - pars_phase_1.t0);
pars_phase_1.may_start = datetime(2021,05,01);
pars_phase_1.t_may_start = days(pars_phase_1.may_start - pars_phase_1.t0);
pars_phase_1.jun_start = datetime(2021,06,01);
pars_phase_1.t_jun_start = days(pars_phase_1.jun_start - pars_phase_1.t0);
pars_phase_1.jul_start = datetime(2021,07,01);
pars_phase_1.t_jul_start = days(pars_phase_1.jul_start - pars_phase_1.t0);
pars_phase_1.aug_start = datetime(2021,08,01);
pars_phase_1.t_aug_start = days(pars_phase_1.aug_start - pars_phase_1.t0);
pars_phase_1.sep_start = datetime(2021,09,01);
pars_phase_1.t_sep_start = days(pars_phase_1.sep_start - pars_phase_1.t0);
pars_phase_1.oct_start = datetime(2021,10,01);
pars_phase_1.t_oct_start = days(pars_phase_1.oct_start - pars_phase_1.t0);
pars_phase_1.nov_start = datetime(2021,11,01);
pars_phase_1.t_nov_start = days(pars_phase_1.nov_start - pars_phase_1.t0);
pars_phase_1.omicron_start = datetime(2021,11,13);
pars_phase_1.t_omicron_start = days(pars_phase_1.omicron_start - pars_phase_1.t0);





pars_phase_1.nDays = days(pars_phase_1.tf - pars_phase_1.t0);
pars_phase_1.times = 1:pars_phase_1.nDays;
pars_phase_1.t_slice = effectiveness_npis.Date';
pars_phase_1.t_slice = datetime(pars_phase_1.t_slice,'InputFormat','yyyy/MM/dd');

pars_phase_1.contact_reduced = effectiveness_npis.Reduced; 

tStart = days(pars_phase_1.t_slice - pars_phase_1.t0);
beforeidx = sum(tStart<1);
pars_phase_1.beforeidx = beforeidx;

% Back-calculate initial conditions from X0_target
pars_phase_1.X0_target = Get_Inits(pars_phase_1);


