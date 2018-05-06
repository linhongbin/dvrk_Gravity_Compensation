function v = Get_Cof( T,m,L )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
a = coeffs(T,m);
d_size = size(a);
b = coeffs(a(d_size(2)),L);
d_size = size(b);
v = b(d_size(2));
end

