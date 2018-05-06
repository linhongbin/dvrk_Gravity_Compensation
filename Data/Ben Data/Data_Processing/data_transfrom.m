d_size = size(torque_current);
Torques_data = zeros(7,2,d_size(2)*d_size(3));
for i=1:d_size(2)
    for j=1:d_size(3)
        Torques_data(:,1,i*20+j) = actual_position(:,i,j);
        Torques_data(:,2,i*20+j) = torque_current(:,i,j);
    end
end
