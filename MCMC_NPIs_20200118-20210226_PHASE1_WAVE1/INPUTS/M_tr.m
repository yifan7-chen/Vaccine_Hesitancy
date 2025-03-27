% syms r;
r=0.07553;
mu = 1/2.9;
dp = 1/2.3;
gamma = 1/2.9;

transition_matrix  = [-mu 0 0;
    mu -dp 0;
    0 dp -0.2273-0.7727*gamma ];
tranmission_matrix = [0 0.26*r*14.08121 r*14.08121 
    0 0 0;
    0 0 0];
% [0.3507, 0.7526, 0.8431,0.77]

K = -tranmission_matrix * inv(transition_matrix);
R_null = trace(K)


% % syms r;
% r=0.03533;
% mu = 1/2.9;
% gamma = 1/5.2;
% 
% transition_matrix  = [-mu 0 0 0 0 0 0 0;
%     0 -mu 0 0 0 0 0 0;
%     0 0 -mu 0 0 0 0 0;
%     0 0 0 -mu 0 0 0 0;
%     mu 0 0 0 -gamma 0 0 0;
%     0 mu 0 0 0 -gamma 0 0;
%     0 0 mu 0 0 0 -gamma 0;
%     0 0 0 mu 0 0 0 -gamma];
% tranmission_matrix = [0 0 0 0 0.3507*r*10.5219 0.3507*r*0.84291 0.3507*r*0.25383 0.3507*r*0.10884;
%     0 0 0 0 0.7526*r*8.282628 0.7526*r*9.98662 0.7526*r*2.83261 0.7526*r*0.56089;
%     0 0 0 0 0.8431*r*7.798548 0.8431*r*5.69621 0.8431*r*4.00583 0.8431*r*1.01177;
%     0 0 0 0 0.77*r*2.139954 0.77*r*0.79629 0.77*r*0.70367 0.77*r*0.78426;
%     0 0 0 0 0 0 0 0;
%     0 0 0 0 0 0 0 0;
%     0 0 0 0 0 0 0 0;
%     0 0 0 0 0 0 0 0];
% % [0.3507, 0.7526, 0.8431,0.77]
% 
% K = -tranmission_matrix * inv(transition_matrix);
% R_null = trace(K);


