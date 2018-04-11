cm2_x =-0.33;  
cm2_y = 0.00;
cm2_z =0.00;
m2 = 0.65

cm3_x = -0.24; 
cm3_y = 0.00 ;
cm3_z = 0.00;
m3 = 0.04;

cm4_x = 0.0 
cm4_y = -0.084 
cm4_z = 0.17;
m4 = 0.14;

cm5_x = 0.0; 
cm5_y = -0.036; 
cm5_z = -0.060;
m5 = 0.04;

cm6_x = 0.0; 
cm6_y = -0.025; 
cm6_z = 0.08;
m6 = 0.05;

L2 = 0.2794;
L3 = 0.3645;
L4_z0 =  0.1506;

counter_balance = 0.54;
cable_offset = 0.33;
drift2 = -cable_offset;
E5 = 0.007321;
drift5 = - 0.0065;

d =  zeros(14,1);
d(1)  = L2*m2+L2*m3+L2*m4+L2*m5+L2*m6+cm2_x*m2;
d(2)  = cm2_y*m2;
d(3)  = L3*m3+L3*m4+L3*m5+L3*m6+cm3_x*m3;
d(4)  = cm4_y*m4 +cm3_z*m3 +L4_z0*m4 +L4_z0*m5 +L4_z0*m6 ;
d(5)  = cm5_z*m5 +cm6_y*m6;
d(6)  = cm6_z*m6 ;
d(7)  = cm4_x*m4;
d(8)  = - cm4_z*m4 + cm5_y*m5;
d(9) = cm5_x*m5;
d(10) = cm6_x*m6;
d(11) = counter_balance;
d(12) = drift2;
d(13) = E5;
d(14) = drift5;


dynamic_complex_parameters =  d