    q1= 0.5;
    q2= 1;
    q3= 2;
    q4= 3;
    q5= 1.2;
    q6= 2;
    q7= 0;
    g=9.9
                               
A = double(subs(Regressor_Matrix,symvar(Regressor_Matrix),[g q1 q2 q3 q4 q5 q6 q7]));


tau = A * dynamic_parameters