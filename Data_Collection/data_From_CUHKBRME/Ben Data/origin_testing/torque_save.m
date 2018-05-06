d_size = size(Torques_data);
actual_pose = zeros(7,d_size(3));
for i=1:d_size(3)
    for j=1:7
        actual_pose(j,i) = Torques_data(j,2,i);
    end
end
figure(2)
subplot(3,2,1);
plot(actual_pose(2,:));
xlabel('Index of Data Sets')
ylabel('Joint Torques (rad)')
title('joint 2')
subplot(3,2,2);
plot(actual_pose(3,:));
xlabel('Index of Data Sets')
ylabel('Joint Torques (rad)')
title('joint 3')
subplot(3,2,3);
plot(actual_pose(4,:));
xlabel('Index of Data Sets')
ylabel('Joint Torques (rad)')
title('joint 4')
subplot(3,2,4);
plot(actual_pose(5,:));
xlabel('Index of Data Sets')
ylabel('Joint Torques (rad)')
title('joint 5')
subplot(3,2,5);
plot(actual_pose(6,:));
xlabel('Index of Data Sets')
ylabel('Joint Torques (rad)')
title('joint 6')