%Torques_data = saved_data;
data_set =  size(Torques_data);
for i=1:data_set(3)
q_sub = Torques_data(:,1,i);

qs = [symvar(Regressor_Matrix)];
E = double(subs(Regressor_Matrix,qs,[9.9 q_sub(2:7).']));

F = E*dynamic_parameters;

error_data(:,i) = abs(Torques_data(1:7,2,i) - F);

end


figure(2)
subplot(3,2,1);
plot(error_data(2,:))
title('Abs Error of Joint 2');

subplot(3,2,2);
plot(error_data(3,:))
title('Abs Error of Joint 3');

subplot(3,2,3);
plot(error_data(4,:))
title('Abs Error of Joint 4');

subplot(3,2,4);
plot(error_data(5,:))
title('Abs Error of Joint 5');

subplot(3,2,5);
plot(error_data(6,:))
title('Abs Error of Joint 6');

subplot(3,2,6);
plot(error_data(7,:))
title('Abs Error of Joint 7');


