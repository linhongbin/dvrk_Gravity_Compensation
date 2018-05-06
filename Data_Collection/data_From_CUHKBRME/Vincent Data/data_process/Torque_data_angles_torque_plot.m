for i = 1:7
    figure(i)
    angles = Torques_data(i,1,:);
    torque = Torques_data(i,2,:);
    scatter(angles,torque);
    title_name = sprintf('Joint %d torques with angles',i)
    title(title_name);
end