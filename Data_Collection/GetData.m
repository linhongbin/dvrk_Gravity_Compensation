%Home();
%pause(10);
%rosinit
n = 30;
sub_tor = rossubscriber('/mtm/joint_states');
sub_pos = rossubscriber('/mtm/joint_states');
pub_pos = rospublisher('/dvrk/MTML/desired_state', 'sensor_msgs/JointState');
%Set_Position(pub_pos, qs(:,i));
saved_data = zeros(8,2,n);
data = zeros(7,2,10);
q_min = [-0.6981,-0.2618, -0.8727, -3.4907, -1.5708 ,-0.7854,-8.3776];
q_max = [1.1345, 0.8727 , 0.6109 ,  1.5708 , 3.1416, 0.7854,7.8540];
qs = rand(8,n);
qs(1:8, 1) = [0, 0, 0, 0, 0, 0, 0, 0];

% for i = 1:15
%        qs(1:3,i) = positions(1:3,2);
% end
% 
% for i = 16:30
%        qs(1:3,i) = positions(1:3,3);
% end

for i = 1:30
    qs(1:7,i) = qs(1:7,i).*(q_max(1:7)'-q_min(1:7)')*.8 - (q_max(1:7)'+ q_min(1:7)')/2;
end

for i = 1:n
    Set_Position(pub_pos, qs(:,i));
    pause(5);
    for j = 1:10
        data(:,1,j) = Get_Position(sub_pos);
        data(:,2,j) = Get_Torque(sub_tor);
        pause(1);
    end
    for j = 1:7
        saved_data(j,1,i) = mean(data(j,1,:));
        saved_data(j,2,i) = mean(data(j,2,:));
    end
    disp(['The', i, ' set data is finishied..'])
end
