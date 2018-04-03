dir_name = dir('.');
dir_name = dir_name(3:end,:);
data_sets = length(dir_name)

Torques_data = zeros(7,2,data_sets);

for i = 1:1:data_sets
    file_object = dir_name(i);
    load(file_object.name);
    
    % load angles values
    Torques_data(:,1,i) = position_current(1:7);
    Torques_data(:,2,i) = effort_desired(1:7);
    
end


