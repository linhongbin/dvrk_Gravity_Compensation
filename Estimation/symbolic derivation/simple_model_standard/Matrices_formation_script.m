Regressor_Matrix = sym(zeros(7,10));
Parameter_matrix = sym(zeros(10,1));

%%
% First of all Populate the parametetric matrix
Parameter_matrix(1,1)  = L2*m2+L2*m3+L2*m4+L2*m5+L2*m6+cm2_x*m2;
Parameter_matrix(2,1)  = cm2_y*m2;
Parameter_matrix(3,1)  = L3*m3+L3*m4+L3*m5+L3*m6+cm3_x*m3;
Parameter_matrix(4,1)  = cm4_y*m4 +cm3_z*m3 +L4_z0*m4 +L4_z0*m5 +L4_z0*m6 ;
Parameter_matrix(5,1)  = cm5_z*m5 +cm6_y*m6;
Parameter_matrix(6,1)  = cm6_z*m6 ;
Parameter_matrix(7,1)  = cm4_x*m4;
Parameter_matrix(8,1)  = - cm4_z*m4 + cm5_y*m5;
Parameter_matrix(9,1) = cm5_x*m5;
Parameter_matrix(10,1) = cm6_x*m6;


choosing_index = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                  1, 1, 1, 1, 1, 1, 1, 1, 1, 1
                  0, 0, 1, 1, 1, 1, 1, 1, 1, 1
                  0, 0, 0, 0, 1, 1, 1, 1, 1, 1
                  0, 0, 0, 0, 1, 1, 0, 0, 1, 1
                  0, 0, 0, 0, 0, 1, 0, 0, 0, 1 
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

%%
% Now populate the regressor Matrix
%%
m_coeffs=[L2,m2
        cm2_y,m2
        L3,m3
        cm4_y,m4
        cm5_z,m5
        cm6_z,m6
        cm4_x,m4
        cm5_y,m5
        cm5_x,m5
        cm6_x,m6];
for i=1:7
    for j=1:10
        if(choosing_index(i,j) == 1)
            Regressor_Matrix (i,j)  = Get_Cof(Torque(i),m_coeffs(j,2),m_coeffs(j,1));
        else
            Regressor_Matrix (i,j)  = 0;
        end
    end
end


%%
% Row 3




Regressor_Matrix

T = Regressor_Matrix*Parameter_matrix

Diff  = simplify(T - Torque)

















