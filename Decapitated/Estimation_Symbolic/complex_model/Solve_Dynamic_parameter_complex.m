Parameter_matrix(1,1)  = L2*m2+L2*m3+L2*m4+L2*m5+L2*m6+L2*m7+cm2_x*m2;
Parameter_matrix(2,1)  = cm2_y*m2;
Parameter_matrix(3,1)  = L3*m3+L3*m4+L3*m5+L3*m6+L3*m7+cm3_x*m3;
Parameter_matrix(4,1)  = cm4_y*m4 -cm3_z*m3 -L4_z0*m4 -L4_z0*m5 -L4_z0*m6 -L4_z0*m7;
Parameter_matrix(5,1)  = cm5_z*m5 +cm6_y*m6;
Parameter_matrix(6,1)  = cm6_z*m6 +cm7_z*m7;
Parameter_matrix(7,1)  = cm4_x*m4;
%Parameter_matrix(8,1)  = cm4_y*m4;
Parameter_matrix(8,1)  = - cm4_z*m4 + cm5_y*m5;
Parameter_matrix(9,1) = cm5_x*m5;
%Parameter_matrix(10,1) = cm5_y*m5;
Parameter_matrix(10,1) = cm6_x*m6;
Parameter_matrix(11,1) = cm7_x*m7;
Parameter_matrix(12,1) = cm7_y*m7;

% [ L2, L3, L4_z0, cm2_x, cm2_y, cm3_x, cm3_z, cm4_x, cm4_y, cm4_z, cm5_x, cm5_y, cm5_z, cm6_x, cm6_y, cm6_z, cm7_x, cm7_y, cm7_z, m2, m3, m4, m5, m6, m7]

d_var = symvar(Parameter_matrix)
d_var_real = zeros(1,25)
Parameter_real = subs(Parameter_matrix, d_var, d_var_real)
solve(dynamic_parameters == Parameter_real, d_var-real(1:12).')


