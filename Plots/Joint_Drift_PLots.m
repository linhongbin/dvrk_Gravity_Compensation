bag = rosbag('Drift_mtm_2018-03-29-17-04-06.bag');
jointbag = select(bag,'Topic', '/dvrk/MTML/state_joint_current');
msgs = readMessages(jointbag);
index_num = size(msgs)
for i = 1:index_num
    Joint_Position(:,i) = msgs{i}.Position;
end


start_index = 770;
time_delta = 0.01;
t=[0];
Joint_Position = Joint_Position*180/pi;
Relative_Joint_Position = zeros(7:1);
for i = start_index:index_num
    Relative_Joint_Position(:,i-start_index+2) = Joint_Position(:,i) - Joint_Position(:,start_index);
    t = [t,t(end)+time_delta];
end
for i = 2:7
    figure(i);
    plot(t,Relative_Joint_Position(i,:),'LineWidth',1.8);
    title_name = sprintf('Joint %i',i);
    title(title_name,'FontSize',20);
    xlabel('Time  (s)','FontSize',20)
    ylabel('Joint  Error  (deg)','FontSize',20)
    set(gca,'FontSize',15);
    set(gca,'box','off')
end