d_size = size(actual_position);
Torques_data =  zeros(7,2,d_size(2)*d_size(3));
for i = 1:1:d_size(3)
    for j = 1:1:d_size(2)
        % load angles values
        Torques_data(:,1,(i-1)*d_size(2)+j) = actual_position(1:7,j,i);
        Torques_data(:,2,(i-1)*d_size(2)+j) = torque_desired(1:7,j,i);
    end  
end


