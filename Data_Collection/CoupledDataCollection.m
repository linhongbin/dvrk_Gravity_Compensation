%Home();
%pause(10);
%rosinit
clear all;clc
rosshutdown
rosinit
n = 15 ;
waiting_time = 5;
sub_pos = rossubscriber('/dvrk/MTMR/state_joint_current');
sub_tor = rossubscriber('/dvrk/MTMR/state_joint_current');
pub_pos = rospublisher('/dvrk/MTMR/set_position_joint');
%Set_Position(pub_pos, qs(:,i));
saved_data = zeros(7,2,n);
data = zeros(7,2,10);
q_min = [-0.6981,-0.2618, -0.8727, -3.4907, -1.5708 ,-0.7854,-8.3776];
q_max = [1.1345, 0.8727 , 0.6109 ,  1.5708 , 3.1416, 0.7854,7.8540];
qs = rand(7,n);


for i = 1:n
    qs(:,i) = qs(:,i).*(q_max'-q_min')*.6 + q_min';
    qs(1,i) = 0;
    qs(6:7,i) = [0,0].'
end

for i = 1:n
    Set_Position(pub_pos, qs(:,i));
    pause(waiting_time);
    for j = 1:10
        data(:,1,j) = Get_Position(sub_pos);
        data(:,2,j) = Get_Torque(sub_tor);
        pause(0.5);
        sprintf('Torque and Joint Pose of %d is collected ',j)
    end
    for j = 1:7
        saved_data(j,1,i) = mean(data(j,1,:));
        saved_data(j,2,i) = mean(data(j,2,:));
    end
        saved_data(1,2,i) = 0.0;
        saved_data(7,2,i) = 0.0;
    sprintf('The %d set of Data is save',i)
end

if exist('Couple Data')~=7
    mkdir('Couple Data');
end
data_dir = dir('Couple Data');
data_dir_name = data_dir;
file_num = length(data_dir_name)
file_name=sprintf('Couple Data/%d.mat',file_num-1);
save(file_name); 
