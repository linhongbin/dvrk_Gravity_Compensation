rosshutdown
rosinit
sub_pos = rossubscriber('/dvrk/MTMR/state_joint_current');
sub_tor = rossubscriber('/dvrk/MTMR/state_joint_current');
sub_vel = rossubscriber('/dvrk/MTMR/state_joint_current');
pub_tor = rospublisher('/dvrk/MTMR/set_effort_joint');
 g = 9.9;
 r = rosrate(150); % increase ros refresh rate to 150 Hz
 position = Get_Position(sub_pos);
%  position_error = zeros(8,100);
 loop = 0;
%   dynamic_param = [
%     0.5500
%    -0.0354
%     0.4596
%    -0.1027
%    -0.0356
%     0.0078
%     0.0726
%    -0.0977
%     0.0618
%    -0.0827
%     0.0000
%     0.0000
% ]
  dynamic_param = [
    0.2262
   -0.0119
    0.1459
   -0.0108
   -0.0144
    0.0510
   -0.0114
   -0.0101
    0.0469
   -0.0146
   -0.0000
    0.0002
]

q_des = [0;0;0;0;0;0;0];
past_q_past = zeros(7,1);
error_sum = zeros(7,1);


P = -1*[0.5,0.4,3.7,0.5,0.2,0.006,0.0001]
I = -1*[0.00001,0.00005,0.0001,0.0004,0.000001,0.0000001,0.00000001]
D = -1*[1.5,0.95,1.75,0.2,0.1,0.8,0.08]

P_mat = diag(P);
I_mat = diag(I);
D_mat = diag(D);

figure(1);
title('Error between computed gravity torque and current acutal torque')
legend('T1_error','T2_error','T3_error','T4_error','T5_error','T6_error','T7_error');
error_plot = zeros(7,1)

i = 0;
count =0

while i ~= 1
  count=count+1
% for i = 1:100
  qs = Get_Position(sub_pos);
  vel = Get_Velocity(sub_vel);
  q1 = qs(1);
  q2 = qs(2);
  q3 = qs(3);
  q4 = qs(4);
  q5 = qs(5);
  q6 = qs(6);
  q7 = qs(7);
  effort = Get_Torque(sub_tor);
  effort = effort(1:7);
  
  
  Regressor_Matrix =             [         0,          0,                                     0,                                     0,                                                                                                                             0,                                                                                                                                                                                                                                     0,                                                     0,                                                     0,                                                                                                                             0,                                                                                                                                                                                                                                     0,                                                                                                                                                                                                                                                                                                                                                                                                                                                     0,                                                                                                                                                                                                                                                                                                                                                                                                                                                     0
                                   g*sin(q2), -g*cos(q2), g*cos(q2)*cos(q3) - g*sin(q2)*sin(q3), g*cos(q2)*sin(q3) + g*cos(q3)*sin(q2), g*cos(q4)*sin(q2)*sin(q3)*sin(q5) - g*cos(q3)*cos(q5)*sin(q2) - g*cos(q2)*cos(q3)*cos(q4)*sin(q5) - g*cos(q2)*cos(q5)*sin(q3), g*sin(q2)*sin(q3)*sin(q4)*sin(q6) - g*cos(q2)*cos(q6)*sin(q3)*sin(q5) - g*cos(q3)*cos(q6)*sin(q2)*sin(q5) - g*cos(q2)*cos(q3)*sin(q4)*sin(q6) - g*cos(q4)*cos(q5)*cos(q6)*sin(q2)*sin(q3) + g*cos(q2)*cos(q3)*cos(q4)*cos(q5)*cos(q6), g*cos(q2)*cos(q3)*cos(q4) - g*cos(q4)*sin(q2)*sin(q3), g*cos(q2)*cos(q3)*sin(q4) - g*sin(q2)*sin(q3)*sin(q4), g*cos(q2)*sin(q3)*sin(q5) + g*cos(q3)*sin(q2)*sin(q5) - g*cos(q2)*cos(q3)*cos(q4)*cos(q5) + g*cos(q4)*cos(q5)*sin(q2)*sin(q3), g*cos(q6)*sin(q2)*sin(q3)*sin(q4) - g*cos(q2)*cos(q3)*cos(q6)*sin(q4) + g*cos(q2)*sin(q3)*sin(q5)*sin(q6) + g*cos(q3)*sin(q2)*sin(q5)*sin(q6) + g*cos(q4)*cos(q5)*sin(q2)*sin(q3)*sin(q6) - g*cos(q2)*cos(q3)*cos(q4)*cos(q5)*sin(q6), g*cos(q2)*cos(q5)*sin(q3)*sin(q7) + g*cos(q3)*cos(q5)*sin(q2)*sin(q7) + g*cos(q2)*cos(q3)*cos(q4)*sin(q5)*sin(q7) + g*cos(q6)*cos(q7)*sin(q2)*sin(q3)*sin(q4) + g*cos(q2)*cos(q7)*sin(q3)*sin(q5)*sin(q6) + g*cos(q3)*cos(q7)*sin(q2)*sin(q5)*sin(q6) - g*cos(q4)*sin(q2)*sin(q3)*sin(q5)*sin(q7) - g*cos(q2)*cos(q3)*cos(q6)*cos(q7)*sin(q4) - g*cos(q2)*cos(q3)*cos(q4)*cos(q5)*cos(q7)*sin(q6) + g*cos(q4)*cos(q5)*cos(q7)*sin(q2)*sin(q3)*sin(q6), g*cos(q4)*cos(q7)*sin(q2)*sin(q3)*sin(q5) - g*cos(q3)*cos(q5)*cos(q7)*sin(q2) - g*cos(q2)*cos(q3)*cos(q6)*sin(q4)*sin(q7) - g*cos(q2)*cos(q5)*cos(q7)*sin(q3) + g*cos(q6)*sin(q2)*sin(q3)*sin(q4)*sin(q7) + g*cos(q2)*sin(q3)*sin(q5)*sin(q6)*sin(q7) + g*cos(q3)*sin(q2)*sin(q5)*sin(q6)*sin(q7) - g*cos(q2)*cos(q3)*cos(q4)*cos(q7)*sin(q5) + g*cos(q4)*cos(q5)*sin(q2)*sin(q3)*sin(q6)*sin(q7) - g*cos(q2)*cos(q3)*cos(q4)*cos(q5)*sin(q6)*sin(q7)
                                           0,          0, g*cos(q2)*cos(q3) - g*sin(q2)*sin(q3), g*cos(q2)*sin(q3) + g*cos(q3)*sin(q2), g*cos(q4)*sin(q2)*sin(q3)*sin(q5) - g*cos(q3)*cos(q5)*sin(q2) - g*cos(q2)*cos(q3)*cos(q4)*sin(q5) - g*cos(q2)*cos(q5)*sin(q3), g*sin(q2)*sin(q3)*sin(q4)*sin(q6) - g*cos(q2)*cos(q6)*sin(q3)*sin(q5) - g*cos(q3)*cos(q6)*sin(q2)*sin(q5) - g*cos(q2)*cos(q3)*sin(q4)*sin(q6) - g*cos(q4)*cos(q5)*cos(q6)*sin(q2)*sin(q3) + g*cos(q2)*cos(q3)*cos(q4)*cos(q5)*cos(q6), g*cos(q2)*cos(q3)*cos(q4) - g*cos(q4)*sin(q2)*sin(q3), g*cos(q2)*cos(q3)*sin(q4) - g*sin(q2)*sin(q3)*sin(q4), g*cos(q2)*sin(q3)*sin(q5) + g*cos(q3)*sin(q2)*sin(q5) - g*cos(q2)*cos(q3)*cos(q4)*cos(q5) + g*cos(q4)*cos(q5)*sin(q2)*sin(q3), g*cos(q6)*sin(q2)*sin(q3)*sin(q4) - g*cos(q2)*cos(q3)*cos(q6)*sin(q4) + g*cos(q2)*sin(q3)*sin(q5)*sin(q6) + g*cos(q3)*sin(q2)*sin(q5)*sin(q6) + g*cos(q4)*cos(q5)*sin(q2)*sin(q3)*sin(q6) - g*cos(q2)*cos(q3)*cos(q4)*cos(q5)*sin(q6), g*cos(q2)*cos(q5)*sin(q3)*sin(q7) + g*cos(q3)*cos(q5)*sin(q2)*sin(q7) + g*cos(q2)*cos(q3)*cos(q4)*sin(q5)*sin(q7) + g*cos(q6)*cos(q7)*sin(q2)*sin(q3)*sin(q4) + g*cos(q2)*cos(q7)*sin(q3)*sin(q5)*sin(q6) + g*cos(q3)*cos(q7)*sin(q2)*sin(q5)*sin(q6) - g*cos(q4)*sin(q2)*sin(q3)*sin(q5)*sin(q7) - g*cos(q2)*cos(q3)*cos(q6)*cos(q7)*sin(q4) - g*cos(q2)*cos(q3)*cos(q4)*cos(q5)*cos(q7)*sin(q6) + g*cos(q4)*cos(q5)*cos(q7)*sin(q2)*sin(q3)*sin(q6), g*cos(q4)*cos(q7)*sin(q2)*sin(q3)*sin(q5) - g*cos(q3)*cos(q5)*cos(q7)*sin(q2) - g*cos(q2)*cos(q3)*cos(q6)*sin(q4)*sin(q7) - g*cos(q2)*cos(q5)*cos(q7)*sin(q3) + g*cos(q6)*sin(q2)*sin(q3)*sin(q4)*sin(q7) + g*cos(q2)*sin(q3)*sin(q5)*sin(q6)*sin(q7) + g*cos(q3)*sin(q2)*sin(q5)*sin(q6)*sin(q7) - g*cos(q2)*cos(q3)*cos(q4)*cos(q7)*sin(q5) + g*cos(q4)*cos(q5)*sin(q2)*sin(q3)*sin(q6)*sin(q7) - g*cos(q2)*cos(q3)*cos(q4)*cos(q5)*sin(q6)*sin(q7)
                                           0,          0,                                     0,                                     0,                                                                                                g*sin(q2 + q3)*sin(q4)*sin(q5),                                                                                                                                                                           -g*sin(q2 + q3)*(cos(q4)*sin(q6) + cos(q5)*cos(q6)*sin(q4)),                               -g*sin(q2 + q3)*sin(q4),                                g*sin(q2 + q3)*cos(q4),                                                                                                g*sin(q2 + q3)*cos(q5)*sin(q4),                                                                                                                                                                           -g*sin(q2 + q3)*(cos(q4)*cos(q6) - cos(q5)*sin(q4)*sin(q6)),                                                                                                                                                                                                                                                                                                                                                 -g*sin(q2 + q3)*(sin(q4)*sin(q5)*sin(q7) + cos(q4)*cos(q6)*cos(q7) - cos(q5)*cos(q7)*sin(q4)*sin(q6)),                                                                                                                                                                                                                                                                                                                                                  g*sin(q2 + q3)*(cos(q7)*sin(q4)*sin(q5) - cos(q4)*cos(q6)*sin(q7) + cos(q5)*sin(q4)*sin(q6)*sin(q7))
                                           0,          0,                                     0,                                     0,    -g*(cos(q2)*cos(q3)*sin(q5) - sin(q2)*sin(q3)*sin(q5) + cos(q2)*cos(q4)*cos(q5)*sin(q3) + cos(q3)*cos(q4)*cos(q5)*sin(q2)),                                                                            -g*(cos(q5)*cos(q6)*sin(q2)*sin(q3) - cos(q2)*cos(q3)*cos(q5)*cos(q6) + cos(q2)*cos(q4)*cos(q6)*sin(q3)*sin(q5) + cos(q3)*cos(q4)*cos(q6)*sin(q2)*sin(q5)),                                                     0,                                                     0,     g*(cos(q5)*sin(q2)*sin(q3) - cos(q2)*cos(q3)*cos(q5) + cos(q2)*cos(q4)*sin(q3)*sin(q5) + cos(q3)*cos(q4)*sin(q2)*sin(q5)),                                                                             g*(cos(q5)*sin(q2)*sin(q3)*sin(q6) - cos(q2)*cos(q3)*cos(q5)*sin(q6) + cos(q2)*cos(q4)*sin(q3)*sin(q5)*sin(q6) + cos(q3)*cos(q4)*sin(q2)*sin(q5)*sin(q6)),                                                                                                     g*(cos(q2)*cos(q3)*sin(q5)*sin(q7) - sin(q2)*sin(q3)*sin(q5)*sin(q7) - cos(q2)*cos(q3)*cos(q5)*cos(q7)*sin(q6) + cos(q2)*cos(q4)*cos(q5)*sin(q3)*sin(q7) + cos(q3)*cos(q4)*cos(q5)*sin(q2)*sin(q7) + cos(q5)*cos(q7)*sin(q2)*sin(q3)*sin(q6) + cos(q2)*cos(q4)*cos(q7)*sin(q3)*sin(q5)*sin(q6) + cos(q3)*cos(q4)*cos(q7)*sin(q2)*sin(q5)*sin(q6)),                                                                                                    -g*(cos(q2)*cos(q3)*cos(q7)*sin(q5) - cos(q7)*sin(q2)*sin(q3)*sin(q5) + cos(q2)*cos(q4)*cos(q5)*cos(q7)*sin(q3) + cos(q3)*cos(q4)*cos(q5)*cos(q7)*sin(q2) + cos(q2)*cos(q3)*cos(q5)*sin(q6)*sin(q7) - cos(q5)*sin(q2)*sin(q3)*sin(q6)*sin(q7) - cos(q2)*cos(q4)*sin(q3)*sin(q5)*sin(q6)*sin(q7) - cos(q3)*cos(q4)*sin(q2)*sin(q5)*sin(q6)*sin(q7))
                                           0,          0,                                     0,                                     0,                                                                                                                             0,        -g*(cos(q2)*cos(q6)*sin(q3)*sin(q4) + cos(q3)*cos(q6)*sin(q2)*sin(q4) + cos(q2)*cos(q3)*sin(q5)*sin(q6) - sin(q2)*sin(q3)*sin(q5)*sin(q6) + cos(q2)*cos(q4)*cos(q5)*sin(q3)*sin(q6) + cos(q3)*cos(q4)*cos(q5)*sin(q2)*sin(q6)),                                                     0,                                                     0,                                                                                                                             0,        -g*(cos(q2)*cos(q3)*cos(q6)*sin(q5) - cos(q2)*sin(q3)*sin(q4)*sin(q6) - cos(q3)*sin(q2)*sin(q4)*sin(q6) - cos(q6)*sin(q2)*sin(q3)*sin(q5) + cos(q2)*cos(q4)*cos(q5)*cos(q6)*sin(q3) + cos(q3)*cos(q4)*cos(q5)*cos(q6)*sin(q2)),                                                                                                                                                                        -g*(cos(q2)*cos(q3)*cos(q6)*cos(q7)*sin(q5) - cos(q2)*cos(q7)*sin(q3)*sin(q4)*sin(q6) - cos(q3)*cos(q7)*sin(q2)*sin(q4)*sin(q6) - cos(q6)*cos(q7)*sin(q2)*sin(q3)*sin(q5) + cos(q2)*cos(q4)*cos(q5)*cos(q6)*cos(q7)*sin(q3) + cos(q3)*cos(q4)*cos(q5)*cos(q6)*cos(q7)*sin(q2)),                                                                                                                                                                        -g*(cos(q2)*cos(q3)*cos(q6)*sin(q5)*sin(q7) - cos(q2)*sin(q3)*sin(q4)*sin(q6)*sin(q7) - cos(q3)*sin(q2)*sin(q4)*sin(q6)*sin(q7) - cos(q6)*sin(q2)*sin(q3)*sin(q5)*sin(q7) + cos(q2)*cos(q4)*cos(q5)*cos(q6)*sin(q3)*sin(q7) + cos(q3)*cos(q4)*cos(q5)*cos(q6)*sin(q2)*sin(q7))
                                           0,          0,                                     0,                                     0,                                                                                                                             0,                                                                                                                                                                                                                                     0,                                                     0,                                                     0,                                                                                                                             0,                                                                                                                                                                                                                                     0,                                                                                                                                                                                                                                                                                                                                                                                                                                                     0,                                                                                                                                                                                                                                                                                                                                                                                                                                                    0]; %g*(cos(q5)*cos(q7)*sin(q2)*sin(q3) - cos(q2)*cos(q3)*cos(q5)*cos(q7) + cos(q2)*cos(q4)*cos(q7)*sin(q3)*sin(q5) + cos(q3)*cos(q4)*cos(q7)*sin(q2)*sin(q5) + cos(q2)*cos(q6)*sin(q3)*sin(q4)*sin(q7) + cos(q3)*cos(q6)*sin(q2)*sin(q4)*sin(q7) + cos(q2)*cos(q3)*sin(q5)*sin(q6)*sin(q7) - sin(q2)*sin(q3)*sin(q5)*sin(q6)*sin(q7) + cos(q2)*cos(q4)*cos(q5)*sin(q3)*sin(q6)*sin(q7) + cos(q3)*cos(q4)*cos(q5)*sin(q2)*sin(q6)*sin(q7)),                -g*(cos(q2)*cos(q3)*cos(q5)*sin(q7) - cos(q5)*sin(q2)*sin(q3)*sin(q7) + cos(q2)*cos(q6)*cos(q7)*sin(q3)*sin(q4) + cos(q3)*cos(q6)*cos(q7)*sin(q2)*sin(q4) + cos(q2)*cos(q3)*cos(q7)*sin(q5)*sin(q6) - cos(q2)*cos(q4)*sin(q3)*sin(q5)*sin(q7) - cos(q3)*cos(q4)*sin(q2)*sin(q5)*sin(q7) - cos(q7)*sin(q2)*sin(q3)*sin(q5)*sin(q6) + cos(q2)*cos(q4)*cos(q5)*cos(q7)*sin(q3)*sin(q6) + cos(q3)*cos(q4)*cos(q5)*cos(q7)*sin(q2)*sin(q6))];


  G_Torques = Regressor_Matrix*dynamic_param;
  

%   Torques = [Torques(1);Torques(2);Torques(3);...
%       Torques(4);Torques(5);Torques(6);Torques(7)];
  G_Torques = [0;G_Torques(2);G_Torques(3);...
      G_Torques(4);G_Torques(5);G_Torques(6);0];
  %Torques(6:7) = zeros(1, 2);
  
    q_error = qs - q_des;
    error_sum = error_sum + q_error;
  P_Torques = P_mat * q_error;
  D_Torques = D_mat * vel;
  I_Torques = I_mat * error_sum;
  
  
  Torques = P_Torques + I_Torques + D_Torques + G_Torques;
  Set_Torque(pub_tor, Torques);
%   pause(0.01);
%   position_error(1:8,i) = Get_Position(sub_pos)-position;
  %display('running')
%   torque_table(:,i)=Torques(:);
%   effort_table(:,i)=effort(:);
%   pos_table(:,i)=[q1;q2;q3;q4;q5;q6;q7];
  compare_torque = [effort G_Torques];
  if(mod(count,5)==0)
    error_plot = [error_plot,effort - G_Torques];
    for k = 1:7
      plot(error_plot(k,:));
      hold on;
    end
  end
  hold off;
  title('Error between computed gravity torque and current acutal torque')
  legend('T0 Error','T2 Error','T3 Error','T4 Error','T5 Error','T6 Error','T7 Error');
  loop = loop+1;
  display(loop)
  time = r.TotalElapsedTime;
  fprintf('Time Elapsed: %d',time)
  waitfor(r);
% end
end

% w = waitforbuttonpress;
% if w == 0
%     disp('Reset torque')
%     i = 1;
% else
%     disp('Press any key to reset torque')
% end

% pause(7)
% %reset torque
Torque_reset = [0;0;0;0;0;0;0;0];
Set_Torque(pub_tor,Torque_reset);
% Plot_Errors(position_error);