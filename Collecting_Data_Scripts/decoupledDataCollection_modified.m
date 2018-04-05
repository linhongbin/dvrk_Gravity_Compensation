% Set up ROS configuration
rosshutdown
rosinit
pub_pos = rospublisher('/dvrk/MTML/set_position_joint');
%sub_pos = rossubscriber('/dvrk/MTML/state_joint_current');
sub_tor_current = rossubscriber('/dvrk/MTML/state_joint_current');
sub_tor_desired = rossubscriber('/dvrk/MTML/state_joint_desired');

% Reference from the controller
% q_lim_min = [-0.6981,-0.2618, -0.8727, -3.4907, -1.5708 ,-0.7854,-8.3776];
% q_lim_max = [1.1345, 0.8727 , 0.6109 ,  1.5708 , 3.1416, 0.7854,7.8540];

range =[0.5498    0.2    0.1    1.2    0.7    0.4712    1]
q_min = -range;
q_max = range;


sample_num = 30;
step_num = 10;
step_waiting_time = 3;


trajectory = zeros(7,step_num*2*6);
step_distance = range/5

% Design Trajectory
for i = 2:7
    current = zeros(7,1);
    trajectory(:,1+step_num*2*(i-2)) = current;
    for j=1:step_num/2
       current(i) = current(i) - step_distance(i);
       trajectory(:,j+1+step_num*2*(i-2)) = current;
    end
    for j=1:step_num
       current(i) = current(i) + step_distance(i);
       trajectory(:,j+step_num/2+1+step_num*2*(i-2)) = current;
    end
    for j=1:step_num/2-1
       current(i) = current(i) - step_distance(i);
       trajectory(:,j+step_num*3/2+1+step_num*2*(i-2)) = current;
    end
end

% %Visualizing Trajectory
% figure(1)
% for i=1:6
%     subplot(3,2,i);
%     plot(trajectory(i+1,:));
% end


% reset the pose to home configuration
q = [0,0,0,0,0,0,0];
Set_Position(pub_pos,q);
pause(2)

torque_desired = zeros(7,step_num*2*6,sample_num);
torque_current = zeros(7,step_num*2*6,sample_num);
actual_position = zeros(7,step_num*2*6,sample_num);


% Collecting Data
for i=1:step_num*2*6
    q = trajectory(:,i)
    Set_Position(pub_pos,q);
    % Waiting until the pose is stable
    pause(step_waiting_time);
    for j=1:sample_num
       actual_position(:,i,j) = Get_Position(sub_tor_current);
       torque_desired(:,i,j) = Get_Torque(sub_tor_desired);
       torque_current(:,i,j) = Get_Torque(sub_tor_current);
       pause(0.1);
    end
end 

rosshutdown
