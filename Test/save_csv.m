d_size = size(Torques_data);
position = zeros(7,d_size(3));
torques =  zeros(7,d_size(3));
for i = 1:1:d_size(3)
    position(:,i) = Torques_data(:,1,i);
    torques(:,i) = Torques_data(:,2,i);
end