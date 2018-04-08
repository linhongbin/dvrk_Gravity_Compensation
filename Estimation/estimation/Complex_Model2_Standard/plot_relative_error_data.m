%Torques_data = saved_data;
data_set =  size(Torques_data);
for i=1:data_set(3)
q_sub = Torques_data(:,1,i);

qs = [symvar(Regressor_Matrix)];
E = double(subs(Regressor_Matrix,qs,[9.9 q_sub(2:6).']));

F = E*dynamic_parameters;


error_data(:,i) = Torques_data(1:7,2,i) - F;

end

for i = 2:7
    subplot(3,2,i-1)
    title_name = sprintf('Error of Joint %d',i)
    plot(error_data(i,:));
    title(title_name)
end
