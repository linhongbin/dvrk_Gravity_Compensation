dir_name = dir('Luke Data');
dir_name = dir_name(3:end,:);
data_set = length(dir_name)

q_sub = zeros(7,1);
tor_sub = zeros(7,1);
R2_augmented = zeros(7*data_set,12);
T2_augmented = zeros(7*data_set,1);

save_data = zeros(7,2, data_set);
%%
% create an array of angles
syms q1 q8
qs = [symvar(Regressor_Matrix)];

%%
% number of data sets
s= size(Torques_data);
number_of_data_sets = s(3);

for i = 1:1:data_set
    file_object = dir_name(i);
    load(file_object.name);
    
    % load angles values
    q_sub = position_current;
    
    % load torques
    tor_sub = effort_current;
    
    save_data(:,1,i) = q_sub;
    save_data(:,2,i) = tor_sub;
    
    A = double(subs(Regressor_Matrix,qs, [9.9 q_sub(2:7).']));
     
    if (i==1)
       R2_augmented(1:7,:) = A; 
       T2_augmented(1:7,:) = tor_sub;
    
    else
        
        R2_augmented(7*i-6:7*i,:) = A;
        T2_augmented(7*i-6:7*i,:) = tor_sub;
    end

    
end 

Torques_data = save_data;
save_file = 'luke_data.mat';
save(save_file, 'Torques_data');


