
%%
%
q_sub = zeros(7,1);
tor_sub = zeros(7,1);
%%
% create an array of angles
syms q1 q8
data_size = size(actual_position)
Torques_data = zeros(7,2, data_size(2)*data_size(3));
for i = 1:data_size(3)
    for j=1:data_size(2)
        Torques_data(:,1,(i-1)*data_size(2)+j)= actual_position(:,j,i);
        tmp = torque_data(2:6,j,i);
        Torques_data(:,2,(i-1)*data_size(2)+j) = [.0; tmp; .0];
    end
end

qs = [symvar(Regressor_Matrix)];
Torques_data =  cat(3,Torques_data(:,:,1:10),Torques_data(:,:,20:50))
%%
% number of data sets
s= size(Torques_data);
number_of_data_sets = s(3);

R2_augmented = zeros(number_of_data_sets*7,12);
T2_augmented = zeros(number_of_data_sets*7,1);

for i=1:number_of_data_sets
    
    % load angles values
    q_sub = Torques_data(:,1,i);
    
    % load torques
    tor_sub = Torques_data(1:7,2,i);
    
   
    A = double(subs(Regressor_Matrix,qs,[9.9 q_sub(2:6).' 0]));
    
    %B = double(subs(knowns,qs,q_sub));
    
    if (i==1)
       R2_augmented(1:7,:) = A; 
       T2_augmented(1:7,:) = tor_sub;
    
    else
        
        R2_augmented(7*i-6:7*i,:) = A;
        T2_augmented(7*i-6:7*i,:) = tor_sub;
    end
    
    
end 


