function v = Get_One_Cof( T,m)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes herez
a = coeffs(T,m);
d_size = size(a);
v = a(d_size(2));
end

