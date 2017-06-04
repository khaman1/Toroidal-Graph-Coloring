function DrawWalkOnTorus(f, R, r, Point3D, EndPoint1, EndPoint2, Torus_x, Torus_y, Torus_z, Torus_u, Torus_v, LineOutput, DIRECTION)

if ~any(findall(0,'Type','Figure')==1)
    return;
end;

if numel(EndPoint1) == 1 || numel(EndPoint2) == 1
    return;
end;

figure(f);


DIRECTION = evalin('base','DIRECTION');
if DIRECTION == 0
    
    if EndPoint1(1)~=0
        EndPoint1_CIRCLE = Point3D(EndPoint1(1), 4);
        EndPoint1_COLUMN = Point3D(EndPoint1(1), 5);
    else
        EndPoint1_CIRCLE = EndPoint1(2);
        EndPoint1_COLUMN = EndPoint1(3);
    end;

    if EndPoint2(1)~=0
        EndPoint2_CIRCLE = Point3D(EndPoint2(1), 4);
        EndPoint2_COLUMN = Point3D(EndPoint2(1), 5);
    else
        EndPoint2_CIRCLE = EndPoint2(2);
        EndPoint2_COLUMN = EndPoint2(3);
    end;
    
    [x,y,z] = CalculateLineOnTorus(R, r, Torus_u, Torus_v, EndPoint1_CIRCLE, EndPoint1_COLUMN, EndPoint2_CIRCLE, EndPoint2_COLUMN);
    
    New=0;
    for i=2:numel(x)-1
        New(i-1) = drawLine3dBy2Points([x(i) y(i) z(i)], [x(i+1) y(i+1) z(i+1)], 'Color', 'b', 'LineWidth', 2);
    end;
    
    New(i)=nan;
    UpdateUndoList(New,0);
    
    
elseif DIRECTION >=1 && DIRECTION <=4
    for i=1:numel(LineOutput(:,1))
        [EndPoint_CIRCLE(i) EndPoint1_COLUMN(i)] = FindCircleAndColumnOnTorus(Torus_x, LineOutput(i,:));
    end;

    for i=1:2:numel(LineOutput(:,1))
        [x,y,z] = CalculateLineOnTorus(R, r, Torus_u, Torus_v, EndPoint_CIRCLE(i), EndPoint1_COLUMN(i), EndPoint_CIRCLE(i+1), EndPoint1_COLUMN(i+1));
        
        New=0;
        for j=2:numel(x)-1
            New(j-1) = drawLine3dBy2Points([x(j) y(j) z(j)], [x(j+1) y(j+1) z(j+1)], 'Color', 'b', 'LineWidth', 2);
        end;
        UpdateUndoList(New,0);
    end;

    New(i)=nan;
    UpdateUndoList(New,0);

end;