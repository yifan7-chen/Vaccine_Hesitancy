function X0 = Get_Inits(Pars)
%GET_INITS Gets Initial Conditions
X0 = zeros(1,Pars.nTotSubComp);

X0(Pars.varNames=="S") = Pars.S_as;
X0(Pars.varNames=="E") = Pars.E_as;

X0(Pars.varNames=="P") = Pars.P_as;

X0(Pars.varNames=="I") = Pars.I_as;

X0(Pars.varNames=="CT") = Pars.CT_as;
X0(Pars.varNames=="R") = Pars.R_as;
X0(Pars.varNames=="D") = Pars.D_as;



end

