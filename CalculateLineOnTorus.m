function [x,y,z] = CalculateLineOnTorus(R, r, Torus_u, Torus_v, EndPoint1_CIRCLE, EndPoint1_COLUMN, EndPoint2_CIRCLE, EndPoint2_COLUMN)

u0 = Torus_u(EndPoint1_CIRCLE, EndPoint1_COLUMN);
v0 = Torus_v(EndPoint1_CIRCLE, EndPoint1_COLUMN);
u1 = Torus_u(EndPoint2_CIRCLE, EndPoint2_COLUMN);
v1 = Torus_v(EndPoint2_CIRCLE, EndPoint2_COLUMN);

a = u1-u0;
b = v1-v0;

nbins = 50;

OFFSET=0.02;
t = linspace(0-OFFSET,1,nbins);

u = a.* t + u0;
v = b.* t + v0;

x=(R+r*cosd(v)).*cosd(u);
y=(R+r*cosd(v)).*sind(u);
z=r*sind(v);