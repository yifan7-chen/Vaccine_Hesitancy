function X0 = Get_Inits(Pars)
%GET_INITS Gets Initial Conditions
X0 = zeros(1,Pars.nTotSubComp);

X0(Pars.varNames=="S")   = Pars.S_as;
X0(Pars.varNames=="V1")  = Pars.V1_as;
X0(Pars.varNames=="V2")  = Pars.V2_as;
X0(Pars.varNames=="E")   = Pars.E_as;
X0(Pars.varNames=="Ev1") = Pars.Ev1_as;
X0(Pars.varNames=="Ev2") = Pars.Ev2_as;
X0(Pars.varNames=="P")   = Pars.P_as;
X0(Pars.varNames=="Pv1") = Pars.Pv1_as;
X0(Pars.varNames=="Pv2") = Pars.Pv2_as;
X0(Pars.varNames=="I")   = Pars.I_as;
X0(Pars.varNames=="Iv1") = Pars.Iv1_as;
X0(Pars.varNames=="Iv2") = Pars.Iv2_as;
X0(Pars.varNames=="CT")  = Pars.CT_as;
X0(Pars.varNames=="CTv1") = Pars.CTv1_as;
X0(Pars.varNames=="CTv2") = Pars.CTv2_as;
X0(Pars.varNames=="R")    = Pars.R_as;
X0(Pars.varNames=="D")    = Pars.D_as;

X0(Pars.varNames=="Rv1")  = Pars.Rv1_as;
X0(Pars.varNames=="Dv1")  = Pars.Dv1_as;

X0(Pars.varNames=="Rv2")  = Pars.Rv2_as;
X0(Pars.varNames=="Dv2")  = Pars.Dv2_as;

X0(Pars.varNames=="Y2vac") = Pars.Y2vac_as;



end

