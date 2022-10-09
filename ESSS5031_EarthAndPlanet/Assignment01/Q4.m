clear all
phi_c  = [43  32 16];
phi  =deg2rad( dms2degrees(phi_c) );
g = vpa(9.780327*( 1+0.0053024*(sin(phi))^2-0.0000059*(sin(2*phi))^2),8);
double(g)