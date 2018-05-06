bag1 = rosbag('mtml_2018-04-13-20-06-09.bag');
bag2 = rosbag('mtml_2018-04-13-20-16-26.bag');
bag = {bag1,bag2};
end_index = 512;
legend_string = {'MMPM','SMM'}
for k = 1:2
    jointbag = select(bag{k},'Topic', '/dvrk/MTML/state_joint_current');
    msgs = readMessages(jointbag);
    index_num = size(msgs)
    for i = 1:index_num
        Joint_Position(:,i) = abs(msgs{i}.Position);
    end


    start_index = 1;
    time_delta = 0.01;
    t=[0];
    Joint_Position = Joint_Position*180/pi;
    Relative_Joint_Position = zeros(7:1);
    for i = start_index:index_num
        Relative_Joint_Position(:,i-start_index+2) = Joint_Position(:,i) - Joint_Position(:,start_index);
        t = [t,t(end)+time_delta];
    end
    for i = 3
        fig = figure(i);
        hold on
        plot(t(1:end_index),Relative_Joint_Position(i,1:end_index),'LineWidth',1.8);
        title_name = sprintf('Joint %i Drift ',i);
        %title(title_name,'FontSize',20);
        xlabel('Time  (s)','FontSize',20)
        ylabel('Joint  Error  (deg)','FontSize',20)
        set(gca,'FontSize',15);
        set(gca,'box','off')
        %legend(legend_string{k});
        save_name = sprintf('Joint_%d.fig',i);
        saveas(fig,save_name)
    end
end
legend(legend_string{1},legend_string{2},'Location','east')
xt = get(gca, 'XTick');
set(gca, 'FontSize', 20)

% for i = 3
%     fig = figure(i);
%     plot(t,Relative_Joint_Position(i,:),'LineWidth',1.8);
%     title_name = sprintf('Joint %i',i);
%     title(title_name,'FontSize',20);
%     xlabel('Time  (s)','FontSize',20)
%     ylabel('Joint  Error  (deg)','FontSize',20)
%     set(gca,'FontSize',15);
%     set(gca,'box','off')
%     save_name = sprintf('Joint_%d.fig',i);
%     saveas(fig,save_name)
% end