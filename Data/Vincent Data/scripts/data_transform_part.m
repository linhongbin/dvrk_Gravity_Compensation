d_size = size(desired_effort);
Torques_data = zeros(7,2,d_size(2));
for i=1:d_size(2)
    Torques_data(:,1,i) = current_position(:,i,10);
    Torques_data(:,2,i) = desired_effort(:,i,10);
end
