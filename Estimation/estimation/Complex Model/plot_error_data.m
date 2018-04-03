% %Torques_data = saved_data;
% data_set =  size(Torques_data);
% for i=1:data_set(3)
% q_sub = Torques_data(:,1,i);
% 
% qs = [symvar(Regressor_Matrix)];
% E = double(subs(Regressor_Matrix,qs,[9.9 q_sub.']));
% 
% F = E*dynamic_parameters;
% 
% error_data(:,i) = Torques_data(1:7,2,i) - F;
% 
% end


figure(2)
for i =1:7
    subplot(4,2,i);
    plot(error_data(i,:).^2)
    title_name = sprintf('Square Error of Joint %d',i);
    title(title_name);
end


