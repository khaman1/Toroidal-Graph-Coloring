function [x,y,z,u,v] = GenerateTorus(f, R, r, TRANSPARENCY, ENABLE_AXIS_ON_TORUS)

figure(f); hold on; rotate3d on;
text(0, R+r, -1, 'X', 'color', 'g', 'Fontsize', 18);
text(R+r, 0, -1, 'Y', 'color', 'g', 'Fontsize', 18);
text(R+r, R+r, 0, 'Z', 'color', 'g', 'Fontsize', 18);

[u,v]=meshgrid(0:5:360);
x=(R+r*cosd(v)).*cosd(u);
y=(R+r*cosd(v)).*sind(u);
z=r*sind(v);
surfl(x,y,z);
%colormap winter
colormap white

axis equal;

alpha(1 - TRANSPARENCY);