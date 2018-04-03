function [velocity] = Get_Velocity(sub_vel)
%Use to get the torque values
    msg = receive(sub_vel);
    velocity = msg.Velocity;
end