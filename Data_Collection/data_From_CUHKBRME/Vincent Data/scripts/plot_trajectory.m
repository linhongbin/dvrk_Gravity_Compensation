%Torques_data = saved_data;
data_set =  size(Torques_data);
trajectory = zeros(7,data_set(3))
for i=1:data_set(3)
    trajectory(:,i) = Torques_data(:,1,i);
end


figure(2)
subplot(3,2,1);
plot(trajectory(2,:))
title('Joint Trajectory 2');

subplot(3,2,2);
plot(trajectory(3,:))
title('Joint Trajectory 3');

subplot(3,2,3);
plot(trajectory(4,:))
title('Joint Trajectory 4');

subplot(3,2,4);
plot(trajectory(5,:))
title('Joint Trajectory 5');

subplot(3,2,5);
plot(trajectory(6,:))
title('Joint Trajectory 6');

subplot(3,2,6);
plot(trajectory(7,:))
title('Joint Trajectory 7');


