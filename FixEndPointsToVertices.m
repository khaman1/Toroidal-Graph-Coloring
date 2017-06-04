function [EndPoint1 EndPoint2] = FixEndPointsToVertices(Point3D, Torus_x, Torus_y, Torus_z, LineOutput)

EndPoint1=0;
EndPoint2=0;
EndPoint1_index=0;
EndPoint2_index=0;

if LineOutput==0
    return;
end;

OFFSET = 1;


[CIRCLE_1 COLUMN_1 CIRCLE_2D_1 COLUMN_2D_1] = FindCircleAndColumnOnTorus(Torus_x, LineOutput(1,:));

ColumnA=COLUMN_1;
CircleA=CIRCLE_1;

if numel(LineOutput(:,1)) == 4
    [CIRCLE_4 COLUMN_4 CIRCLE_2D_4 COLUMN_2D_4] = FindCircleAndColumnOnTorus(Torus_x, LineOutput(4,:));
    ColumnB=COLUMN_4;
    CircleB=CIRCLE_4;
elseif numel(LineOutput(:,1)) == 6
    [CIRCLE_6 COLUMN_6 CIRCLE_2D_6 COLUMN_2D_6] = FindCircleAndColumnOnTorus(Torus_x, LineOutput(6,:));
    ColumnB=COLUMN_6;
    CircleB=CIRCLE_6;
else
    [CIRCLE_2 COLUMN_2 CIRCLE_2D_2 COLUMN_2D_2] = FindCircleAndColumnOnTorus(Torus_x, LineOutput(2,:));
    ColumnB=COLUMN_2;
    CircleB=CIRCLE_2;
end;

if Point3D~=0
    for i=1:numel(Point3D(:,1)) %% Number of rows
        if (abs(CircleA - Point3D(i,4)) <= OFFSET) && (abs(ColumnA - Point3D(i,5)) <= OFFSET)
            EndPoint1_index = i;
        end;

        if (abs(CircleB - Point3D(i,4)) <= OFFSET) && (abs(ColumnB - Point3D(i,5)) <= OFFSET)
            EndPoint2_index = i;
        end; 
    end;
end;

EndPoint1 = [EndPoint1_index CIRCLE_1 COLUMN_1 CIRCLE_2D_1 COLUMN_2D_1];

if numel(LineOutput(:,1)) == 4
    EndPoint2 = [EndPoint2_index CIRCLE_4 COLUMN_4 CIRCLE_2D_4 COLUMN_2D_4];
elseif numel(LineOutput(:,1)) == 6
    EndPoint2 = [EndPoint2_index CIRCLE_6 COLUMN_6 CIRCLE_2D_6 COLUMN_2D_6];
else
    EndPoint2 = [EndPoint2_index CIRCLE_2 COLUMN_2 CIRCLE_2D_2 COLUMN_2D_2];
end;


DIRECTION = evalin('base','DIRECTION');
if DIRECTION == 0
    DIRECTION_TEXT = 'STRAIGHT';
elseif DIRECTION == 1
    DIRECTION_TEXT = 'UP&DOWN';
elseif DIRECTION == 2
    DIRECTION_TEXT = 'LEFT&RIGHT';
elseif DIRECTION == 3
    DIRECTION_TEXT = 'DOWN(LEFT)...';
elseif DIRECTION == 4
    DIRECTION_TEXT = 'TOP(LEFT)...';
else
    
end;
    
disp(['Connecting Point ', num2str(EndPoint1_index), ' and Point ', num2str(EndPoint2_index), ' (', DIRECTION_TEXT, ')']);  
