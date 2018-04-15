%Torques_data = saved_data;
data_set =  size(Torques_data);
dynamic_data = {dynamic_parameters_normal,dynamic_parameters_iter};
plot_num = 100
for k = 1:2
    for i=1:plot_num
    q_sub = Torques_data(:,1,i);

    qs = [symvar(Regressor_Matrix)];
    E = double(subs(Regressor_Matrix,qs,[9.9 q_sub(2:6).']));

    F = E*dynamic_data{k};

    error(:,i) = Torques_data(1:7,2,i) - F;

    end

     indexs = 1:plot_num
    figure(2)
    hold on
    plot(indexs,error(5,:).^2,'LineWidth',1.8)
    %title('Square Error of Joint 5');
    

end
xlabel('Index of Torque Data','FontSize',20)
ylabel('Square of Torque Error (rad^2)','FontSize',20)
lgd = legend({'Single-step Least Square','Iterative Least Square'},'Location','best','FontSize',14)
set(lgd,'FontSize',20); 
xt = get(gca, 'XTick');
set(gca, 'FontSize', 20)
%lgd.FontSize = 20;