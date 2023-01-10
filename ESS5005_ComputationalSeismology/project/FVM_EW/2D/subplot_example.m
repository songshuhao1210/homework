clear all
close all

x = 1;
d = 6;

lx = 3*d+4*x;
ly = d+2*x;

set(gcf,'Units','centimeter','Position',[5 20 3*d+4*x d+2*x]);
pos1 = [ x/lx x/ly d/lx d/ly];
subplot('Position',pos1)
y = magic(4);
plot(y)
title('First Subplot')

pos2 = [ (2*x+d)/lx x/ly d/lx d/ly];
subplot('Position',pos2)
bar(y)
title('Second Subplot')

pos3 = [ (3*x+2*d)/lx x/ly d/lx d/ly];
subplot('Position',pos3)
bar(y)
title('Second Subplot')