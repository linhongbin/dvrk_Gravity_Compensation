%% calculated estimates
%
%%
% right pseudo_inverse
%Rpi = (R_augmented.')*inv((R_augmented*(R_augmented.')));
% % Parameter_matrix(1,1)  = L2*m2+L2*m3+L2*m4+L2*m5+L2*m6+cm2_x*m2;
% % Parameter_matrix(2,1)  = cm2_y*m2;
% % Parameter_matrix(3,1)  = L3*m3+L3*m4+L3*m5+L3*m6+cm3_x*m3;
% % Parameter_matrix(4,1)  = cm4_y*m4 +cm3_z*m3 +L4_z0*m4 +L4_z0*m5 +L4_z0*m6 ;
% % Parameter_matrix(5,1)  = cm5_z*m5 +cm6_y*m6;
% % Parameter_matrix(6,1)  = cm6_z*m6 ;
% % Parameter_matrix(7,1)  = cm4_x*m4;
% % Parameter_matrix(8,1)  = - cm4_z*m4 + cm5_y*m5;
% % Parameter_matrix(9,1) = cm5_x*m5;
% % Parameter_matrix(10,1) = cm6_x*m6;
% % Parameter_matrix(11,1) = m3_parallel*L3_parallel;
% % Parameter_matrix(12,1) = drift2;
param_num =10;

known_index = zeros(1,param_num);
known_parameter = zeros(param_num);

%cm2_y*m2=0
known_index(2)=1;
known_parameter(2)=0;
%cm4_x*m4
known_index(7)=1;
known_parameter(7)=0;
%cm5_x*m5
known_index(9)=1;
known_parameter(9)=0;
%cm6_x*m6
known_index(10)=1;
known_parameter(10)=0;



T2 = T2_augmented;
for i=1:param_num
    if (known_index(i) ==1)
        T2 = T2 - R2_augmented(:,i)*known_parameter(i);
    end
end
unknown_index = known_index ~=1;
R2 = R2_augmented(:,unknown_index);
learn_dynamic_parameters = pinv(R2)*T2
dynamic_param_result = []
k=1;
for i = 1:param_num
    if known_index(i)==1
        dynamic_param_result = [dynamic_param_result;known_parameter(i)];
    else
        dynamic_param_result = [dynamic_param_result;learn_dynamic_parameters(k)];
        k = k+1;
    end
end
dynamic_parameters = dynamic_param_result;
dynamic_param_result