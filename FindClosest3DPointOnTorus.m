function Point3D  = FindClosest3DPointOnTorus(Torus_x, Torus_y, Torus_z, Point2D)

[CIRCLE COLUMN CIRCLE_2D COLUMN_2D] = FindCircleAndColumnOnTorus(Torus_x, Point2D);

%% INDEX_Z : COLUMN
%% INDEX_X : CIRCLE

Point3D = [Torus_x(CIRCLE, COLUMN), Torus_y(CIRCLE, COLUMN), Torus_z(CIRCLE, COLUMN), CIRCLE, COLUMN, COLUMN_2D, CIRCLE_2D];