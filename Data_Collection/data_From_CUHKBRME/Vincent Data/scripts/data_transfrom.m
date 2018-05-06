d_size = size(desired_effort);
Torques_data = zeros(7,2,d_size(2)*d_size(3));
for i=1:d_size(2)
    for j=1:d_size(3)
        Torques_data(:,1,i*20+j) = current_position(:,i,j);
        Torques_data(:,2,i*20+j) = desired_effort(:,i,j);
    end
end
