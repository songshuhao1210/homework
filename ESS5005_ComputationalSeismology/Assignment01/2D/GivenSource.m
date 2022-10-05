function [f]=GivenSource(t,loc_t,extra_inf)
   f0 = extra_inf;

   syms x
   R(x)=(1-2*(pi*f0*x)^2)*exp(-(pi*f0*x)^2);

   f1 = [];
   f3 = [];
   if loc_t(1) ~= 1
        f1 = zeros(1,loc_t(1)-1);
   end
   if loc_t(2) ~= length(t)
       f3 = zeros(1,length(t)-loc_t(2));
   end

   f2=R(t);
   f = [f1,double(f2),f3];
end