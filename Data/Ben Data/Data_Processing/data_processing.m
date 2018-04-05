d_size = size(torque_desired);
Torques_data = zeros(d_size(1),2,d_size(2));
data_array = zeros(1,7);
%First Filter out Point out of 1 std, then find the index whose value close to mean
for i=1:d_size(2)
    for j=1:d_size(1)
        for k=1:d_size(3)
            data_array(k)=torque_desired(j,i,k);
        end
        data_std = std(data_array);
        data_mean = mean(data_array);
        select_index = (data_array <= data_mean+data_std)&(data_array >= data_mean-data_std);
        data_filtered = data_array(select_index);
        d_size_filtered = size(data_filtered);
        if(d_size_filtered(2)==0)
            final_index = 1;
        else    
            data_mean_filtered = mean(data_filtered);
            for e = 1:size(data_filtered)
                if e==1
                    final_index = 1;
                    min_val =abs(data_filtered(e)-data_mean_filtered);
                else
                   abs_result =abs(data_filtered(e)-data_mean_filtered);
                   if(min_val>abs_result)
                       min_val = abs_result;
                       final_index = e;
                   end
                end
            end
        end
        Torques_data(j,1,i) = actual_position(j,i,final_index);
        Torques_data(j,2,i) = torque_desired(j,i,final_index);
    end
end
