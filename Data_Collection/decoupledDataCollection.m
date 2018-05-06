function [torque_data,actual_position] = decoupledDataCollection()
    clear all;clc
    rosshutdown
    rosinit
    
    q_min = [-0.6981,-0.2618, -0.8727, -3.4907, -1.5708 ,-0.7854,-8.3776];
    q_max = [1.1345, 0.8727 , 0.6109 ,  1.5708 , 3.1416, 0.7854,7.8540];
    
    q_min_start = (q_max-q_min)*0.2+q_min;
    %The distance for one step, 10 steps in total. 
    q_delta     = (q_max-q_min)*0.6/10;
    
    decouple_num = 5
    states_joint_num = 7;
    switch_time = 5
    step_time = 3

    % This function is for data collection for each joint torque of the MTM
    % (the joints are decoupled)
    sub_pos = rossubscriber('/dvrk/MTMR/state_joint_current');
    sub_tor = rossubscriber('/dvrk/MTMR/state_joint_desired');
    pub_pos = rospublisher('/dvrk/MTMR/set_position_joint');
    
    % torque_data = (recorded_torque,jth_pose,ith_joint)
    torque_data = zeros(states_joint_num,10,decouple_num);
    actual_position = zeros(states_joint_num,10,decouple_num);
    % reset the pose to home configuration
    q = [0,0,0,0,0,0,0];
    Set_Position(pub_pos,q);
    pause(switch_time)

    
    % set and record the torque data at different configurations
    % Each time the data collection of one joint is done, the robot is 
    % reset to the home pose and then move on to the next joint
    for i = 2
        sum_mean_torque = zeros(states_joint_num,50);
        q = [0,q_min_start(i),0,0,0,0,0];
        Set_Position(pub_pos,q); 
        pause(switch_time);
        for j = 1:10
            q(i) = q(i)+q_delta(i);
            Set_Position(pub_pos,q);
            pause(step_time)
            for k = 1:50
                msg = receive(sub_tor);
                sum_mean_torque(:,k) = msg.Effort;                
            end
            torque_data(:,j,i-1) = mean(sum_mean_torque,2);
            actual_position(:,j,i-1) = Get_Position(sub_pos);
        end                 
    end
    
    for i = 3
        sum_mean_torque = zeros(states_joint_num,50);
        q = [0,0,q_min_start(i),0,0,0,0];
        Set_Position(pub_pos,q); 
        pause(switch_time)
        for j = 1:10
            q(i) = q(i)+q_delta(i);
            Set_Position(pub_pos,q);
            pause(step_time)
            for k = 1:50
                msg = receive(sub_tor);
                sum_mean_torque(:,k) = msg.Effort;                
            end
            torque_data(:,j,i-1) = mean(sum_mean_torque,2);
            actual_position(:,j,i-1) = Get_Position(sub_pos);
        end                 
    end
    
    for i = 4
        sum_mean_torque = zeros(states_joint_num,50);
        q = [0,0,0,q_min_start(i),0,0,0];
        Set_Position(pub_pos,q); 
        pause(switch_time)
        for j = 1:10
            q(i) = q(i)+q_delta(i);
            Set_Position(pub_pos,q);
            pause(step_time)
            for k = 1:50
                msg = receive(sub_tor);
                sum_mean_torque(:,k) = msg.Effort;                
            end
            torque_data(:,j,i-1) = mean(sum_mean_torque,2);
            actual_position(:,j,i-1) = Get_Position(sub_pos);
        end            
     
    end
    
    for i = 5
        sum_mean_torque = zeros(states_joint_num,50);
        q = [0,0,0,0,q_min_start(i),0,0];
        Set_Position(pub_pos,q); 
        pause(switch_time)
        for j = 1:10
            q(i) = q(i)+q_delta(i);
            Set_Position(pub_pos,q);
            pause(step_time)
            for k = 1:50
                msg = receive(sub_tor);
                sum_mean_torque(:,k) = msg.Effort;                
            end
            torque_data(:,j,i-1) = mean(sum_mean_torque,2);
            actual_position(:,j,i-1) = Get_Position(sub_pos);
        end            
     
    end
    
    for i = 6
        sum_mean_torque = zeros(states_joint_num,50);
        q = [0,0,0,0,0,q_min_start(i),0];
        Set_Position(pub_pos,q); 
        pause(switch_time)
        for j = 1:10
            q(i) = q(i)+q_delta(i);
            Set_Position(pub_pos,q);
            pause(step_time)
            for k = 1:50
                msg = receive(sub_tor);
                sum_mean_torque(:,k) = msg.Effort;                
            end
            torque_data(:,j,i-1) = mean(sum_mean_torque,2);
            actual_position(:,j,i-1) = Get_Position(sub_pos);
        end            
     
    end
    
    q = [0,0,0,0,0,0,0];
    Set_Position(pub_pos,q);
    
    % Saving data to mat format
    if exist('Decouple Data')~=7
        mkdir('Decouple Data');
    end
    data_dir = dir('Decouple Data');
    data_dir_name = data_dir;
    file_num = length(data_dir_name)
    file_name=sprintf('Decouple Data/%d.mat',file_num-1);
    save(file_name);   
    
    rosshutdown
end