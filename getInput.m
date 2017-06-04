function [LineOutput] = getInput(f, Point3D, FIXED_AXES_HANDLE, DIRECTION)

LineOutput = 0;

Point = get_pencil_curve(1, FIXED_AXES_HANDLE);  

if ~any(findall(0,'Type','Figure')==f)
    return;
end;

figure(f); hold on;

Point2D    = evalin('base','Point2D');

if detect_point_or_line(Point) == 1 %% POINT
    %% UPDATE POINT SET and COUNTER
    PointCounter    = evalin('base','PointCounter');
    PointCounter    = PointCounter+1;
    
    %%
    Vedit = evalin('base','Vedit');
    set(Vedit,'String',num2str(PointCounter));
    
    Vslider = evalin('base','Vslider');
    set(Vslider,'Value',PointCounter);
    %%
    assignin('base', 'Vedit', Vedit);  
    assignin('base', 'Vslider', Vslider);  
    assignin('base', 'PointCounter', PointCounter);
    
    
    Point2D(PointCounter,1:2) = [Point(1,1) Point(1,2)];
    
    
    %% Erase the new Point '-' and replace it by '.' after
    plot(Point(:,1), Point(:,2), '-', 'Color', 'w');
    
    %% Plot and update the UndoList
    New(1) = 1;
    New(2) = plot(Point(1,1), Point(1,2), '.', 'Color', 'r', 'Markersize', 25);
    New(3) = text(Point(1,1)-0.07, Point(1,2)-0.07, num2str(PointCounter), 'FontSize', 15, 'Color', 'r');
    
    UpdateUndoList(New,1);
    
    %% NO LINE OUTPUT
    LineOutput = 0; 
    
else %% LINE
    
    % Get the DIRECTION from base
    % To prevent a bug that drawnow made due to latency
    DIRECTION = evalin('base','DIRECTION');

    if DIRECTION ~=10 %% NOT FREESTYLE
        PointA  = [Point(1,1)    Point(1,2)];
        PointB  = [Point(end,1)  Point(end,2)];

        OFFSET_X = 0.1;
        OFFSET_Y = 0.1;
        EndPoint1_2D_index=0;
        EndPoint2_2D_index=0;
        
        for i=1:numel(Point2D(:,1))
            if (abs(PointA(1) - Point2D(i,1)) <= OFFSET_X) && (abs(PointA(2) - Point2D(i,2)) <= OFFSET_Y)
                EndPoint1_2D_index = i;
            end;

            if (abs(PointB(1) - Point2D(i,1)) <= OFFSET_X) && (abs(PointB(2) - Point2D(i,2)) <= OFFSET_Y)
                EndPoint2_2D_index = i;
            end;
        end;

        if EndPoint1_2D_index~=0
            PointA  = [Point2D(EndPoint1_2D_index,1)    Point2D(EndPoint1_2D_index,2)];
        end;
        
        if EndPoint2_2D_index~=0
            PointB  = [Point2D(EndPoint2_2D_index,1)    Point2D(EndPoint2_2D_index,2)];
        end;
    end;
    
    
    % Clear the drawing line and replace it by smart routes
    plot(Point(:,1), Point(:,2), '-', 'Color', 'w');
    
    
    
    % Create a new line for UndoList
    New(1) = 2;
    
    if DIRECTION == 0 %% NORMAL
        LineOutput = [Point(1,1) Point(1,2); Point(end,1) Point(end,2)];
        New(2) = line([PointA(1,1) PointB(1,1)], [PointA(1,2) PointB(1,2)]);
        
        NUMBER_OF_EDGES = evalin('base','NUMBER_OF_EDGES');
        NUMBER_OF_EDGES = NUMBER_OF_EDGES+1;
        assignin('base', 'NUMBER_OF_EDGES', NUMBER_OF_EDGES);
        
        New(3) = text((Point(1,1)+Point(end,1))/2, (Point(1,2)+Point(end,2))/2, ['E', num2str(NUMBER_OF_EDGES)]);
        UpdateUndoList(New,1);
        
        
        [EndPoint1_2D_index EndPoint2_2D_index]
        
    elseif DIRECTION == 1 %% UP and DOWN        
   
        Xa      = PointA(1);
        Ya      = PointA(2);
        Xb      = PointB(1);
        Yb      = PointB(2);
        Yc      = FIXED_AXES_HANDLE(4);
        Xc      = (Xa*(Yb+Yc)+Xb*(Yc-Ya))/(-Ya+Yb+2*Yc);
        PointC  = [Xc Yc];
        
        m       = (Yc-Ya)/(Xc-Xa);
        b2      = Yb-m*Xb;
        Yd      = FIXED_AXES_HANDLE(3);
        Xd      = (Yd-b2)/m;
        PointD  = [Xd Yd];
        
        %% Draw lines and update the new line of UndoList
        New(2)  = line([PointA(1) PointC(1)], [PointA(2) PointC(2)]);
        New(3)  = line([PointD(1) PointB(1)], [PointD(2) PointB(2)]);
        
        
        %% ADD TEXT TO LINE
        NUMBER_OF_EDGES = evalin('base','NUMBER_OF_EDGES');
        NUMBER_OF_EDGES = NUMBER_OF_EDGES+1;
        assignin('base', 'NUMBER_OF_EDGES', NUMBER_OF_EDGES);
        
        New(4) = text((PointA(1)+PointC(1))/2, (PointA(2)+PointC(2))/2, ['E', num2str(NUMBER_OF_EDGES)]);
        New(5) = text((PointD(1)+PointB(1))/2, (PointD(2)+PointB(2))/2, ['E', num2str(NUMBER_OF_EDGES)]);
        
        
        
        UpdateUndoList(New,1);
        
        LineOutput = [PointA(1), PointA(2); ...
                      PointC(1), PointC(2); ...
                      PointD(1), PointD(2); ...
                      PointB(1), PointB(2)];
    
    elseif DIRECTION == 2 %% LEFT & RIGHT
        
        Xa      = PointA(1);
        Ya      = PointA(2);
        Xb      = PointB(1);
        Yb      = PointB(2);
        Xc      = FIXED_AXES_HANDLE(1);
        Yc      = (Ya*(Xb+Xc)+Yb*(Xc-Xa))/(-Xa+Xb+2*Xc);
        PointC  = [Xc Yc];
        
        m       = (Yc-Ya)/(Xc-Xa);
        b2      = Yb-m*Xb;
        Xd      = FIXED_AXES_HANDLE(2);
        Yd      = m*Xd + b2;
        PointD  = [Xd Yd];
        
        
        New(2)  = line([PointA(1) PointC(1)], [PointA(2) PointC(2)]);
        New(3)  = line([PointD(1) PointB(1)], [PointD(2) PointB(2)]);
        
        
        %% ADD TEXT TO LINE
        NUMBER_OF_EDGES = evalin('base','NUMBER_OF_EDGES');
        NUMBER_OF_EDGES = NUMBER_OF_EDGES+1;
        assignin('base', 'NUMBER_OF_EDGES', NUMBER_OF_EDGES);
        
        New(4) = text((PointA(1)+PointC(1))/2, (PointA(2)+PointC(2))/2, ['E', num2str(NUMBER_OF_EDGES)]);
        New(5) = text((PointD(1)+PointB(1))/2, (PointD(2)+PointB(2))/2, ['E', num2str(NUMBER_OF_EDGES)]);        
        
        UpdateUndoList(New,1);
        
        
        LineOutput = [PointA(1), PointA(2); ...
                      PointC(1), PointC(2); ...
                      PointD(1), PointD(2); ...
                      PointB(1), PointB(2)];
    
    elseif DIRECTION == 3 %% Down(Left)...
        
        % Measure the slopes to decide the starting line needs to get the
        % left side or not
        
        % Call O is the intersection of left  and down side
        %      P ---------------------- right and top  side

        Xa      = PointA(1);
        Ya      = PointA(2);
        Xb      = PointB(1);
        Yb      = PointB(2);
        
        Xo      = FIXED_AXES_HANDLE(1);
        Yo      = FIXED_AXES_HANDLE(3);
        mAO     = (Ya-Yo)/(Xa-Xo);
        
        Xp      = FIXED_AXES_HANDLE(2);
        Yp      = FIXED_AXES_HANDLE(4);
        mBP     = (Yb-Yp)/(Xb-Xp);
        
        if mAO > mBP %% Need to go to left side first
            % A - (C - D) - (E - F) - B
            % Solve equations to get Xc and Xe
            Xc = FIXED_AXES_HANDLE(1);
            Xd = FIXED_AXES_HANDLE(2);
            Ye = FIXED_AXES_HANDLE(3);
            Yf = FIXED_AXES_HANDLE(4);           
            
            A  = Xc-Xa;
            B  = Yb+Ye;
            
            Xe = (B*(Xc+A)-Xb*(Ye-Ya))/(Ya-Ye-B);
            
            Yc = Ya+A*B/(Xb-Xe);
            
            PointC = [Xc Yc];
            PointD = [-Xc Yc];
            PointE = [Xe Ye];
            PointF = [Xe -Ye];
            
            %assignin('base', 'Yc', Yc);
        else %% Need to go down first
            %% A - (C - D) - (E - F) - B
            Yc = FIXED_AXES_HANDLE(3);
            Yd = FIXED_AXES_HANDLE(4);
            Xe = FIXED_AXES_HANDLE(1);
            Xf = FIXED_AXES_HANDLE(2);           
            
            A  = Yc-Ya;
            B  = Xb+Xe;
            
            Ye = (Yb*(Xe-Xa)-B*(A+Yc))/(B-Xa+Xe);
            
            Xc = Xa+(A*B)/(Yb-Ye);
            
            PointC = [Xc Yc];
            PointD = [Xc -Yc];
            PointE = [Xe Ye];
            PointF = [-Xe Ye];
            
            
                   
        end;
        
        New(2) = line([PointA(1) PointC(1)], [PointA(2) PointC(2)]);
        New(3) = line([PointD(1) PointE(1)], [PointD(2) PointE(2)]);
        New(4) = line([PointF(1) PointB(1)], [PointF(2) PointB(2)]);
        
        %% ADD TEXT TO LINE
        NUMBER_OF_EDGES = evalin('base','NUMBER_OF_EDGES');
        NUMBER_OF_EDGES = NUMBER_OF_EDGES+1;
        assignin('base', 'NUMBER_OF_EDGES', NUMBER_OF_EDGES);
        
        New(5) = text((PointA(1)+PointC(1))/2, (PointA(2)+PointC(2))/2, ['E', num2str(NUMBER_OF_EDGES)]);
        New(6) = text((PointD(1)+PointE(1))/2, (PointD(2)+PointE(2))/2, ['E', num2str(NUMBER_OF_EDGES)]);
        New(7) = text((PointF(1)+PointB(1))/2, (PointF(2)+PointB(2))/2, ['E', num2str(NUMBER_OF_EDGES)]);
        
        
        
        UpdateUndoList(New,1);
            
        LineOutput = [PointA(1), PointA(2); ...
                  PointC(1), PointC(2); ...
                  PointD(1), PointD(2); ...
                  PointE(1), PointE(2); ...
                  PointF(1), PointF(2); ...
                  PointB(1), PointB(2);];
    
    elseif DIRECTION == 4 %% Top(Left)...
    
        Xa      = PointA(1);
        Ya      = PointA(2);
        Xb      = PointB(1);
        Yb      = PointB(2);
        
        Xo      = FIXED_AXES_HANDLE(1);
        Yo      = FIXED_AXES_HANDLE(4);
        mAO     = (Ya-Yo)/(Xa-Xo);
        
        Xp      = FIXED_AXES_HANDLE(2);
        Yp      = FIXED_AXES_HANDLE(3);
        mBP     = (Yb-Yp)/(Xb-Xp);
        
        if mAO < mBP
            Xc = FIXED_AXES_HANDLE(1);
            Xd = FIXED_AXES_HANDLE(2);
            Ye = FIXED_AXES_HANDLE(4);
            Yf = FIXED_AXES_HANDLE(3);           
            
            A  = Xc-Xa;
            B  = Yb+Ye;
            
            Xe = (B*(Xc+A)-Xb*(Ye-Ya))/(Ya-Ye-B);
            
            Yc = Ya+A*B/(Xb-Xe);
            
            PointC = [Xc Yc];
            PointD = [-Xc Yc];
            PointE = [Xe Ye];
            PointF = [Xe -Ye];
        else
            Yc = FIXED_AXES_HANDLE(4);
            Yd = FIXED_AXES_HANDLE(3);
            Xe = FIXED_AXES_HANDLE(1);
            Xf = FIXED_AXES_HANDLE(2);
            
            
            A  = Yc-Ya;
            B  = Xb+Xe;
            
            Ye = (Yb*(Xe-Xa)-B*(A+Yc))/(B-Xa+Xe);
            
            Xc = Xa+(A*B)/(Yb-Ye);
            
            PointC = [Xc Yc];
            PointD = [Xc -Yc];
            PointE = [Xe Ye];
            PointF = [-Xe Ye];
        end;
        
        New(2) = line([PointA(1) PointC(1)], [PointA(2) PointC(2)]);
        New(3) = line([PointD(1) PointE(1)], [PointD(2) PointE(2)]);
        New(4) = line([PointF(1) PointB(1)], [PointF(2) PointB(2)]);
        
        %% ADD TEXT TO LINE
        NUMBER_OF_EDGES = evalin('base','NUMBER_OF_EDGES');
        NUMBER_OF_EDGES = NUMBER_OF_EDGES+1;
        assignin('base', 'NUMBER_OF_EDGES', NUMBER_OF_EDGES);
        
        New(5) = text((PointA(1)+PointC(1))/2, (PointA(2)+PointC(2))/2, ['E', num2str(NUMBER_OF_EDGES)]);
        New(6) = text((PointD(1)+PointE(1))/2, (PointD(2)+PointE(2))/2, ['E', num2str(NUMBER_OF_EDGES)]);
        New(7) = text((PointF(1)+PointB(1))/2, (PointF(2)+PointB(2))/2, ['E', num2str(NUMBER_OF_EDGES)]);
        
        
        UpdateUndoList(New,1);
            
        LineOutput = [PointA(1), PointA(2); ...
                  PointC(1), PointC(2); ...
                  PointD(1), PointD(2); ...
                  PointE(1), PointE(2); ...
                  PointF(1), PointF(2); ...
                  PointB(1), PointB(2);];
    
    end;
    %FixEndPointsToVertices(Point3D, [Point(1,1) Point(1,2)], [Point(end,1) Point(end,2)]);
end;

assignin('base', 'Point2D', Point2D);