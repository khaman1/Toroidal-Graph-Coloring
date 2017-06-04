close all;
clear all;
clc;

%% DEFINE VARIABLES
TRANSPARENCY = 0.5;  %% Transparency of the torus
R=2; r=1;            %% R and r of the torus
FIXED_AXES_HANDLE= [-(R+r) (R+r) -r r]; % Fixed axis for 2 figures
ENABLE_AXIS_ON_TORUS=0;
%% CREATE FIGURE 1
figure(1); axis(FIXED_AXES_HANDLE); grid on
set(gcf,'units','normalized','outerposition',[0 0 1 1]);

%% GENERATE TORUS ON FIGURE 2
[Torus_x, Torus_y, Torus_z, Torus_u, Torus_v] = GenerateTorus(2, R, r, TRANSPARENCY);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
%% DEFINE SOME TEMP VARIABLES
PointCounterOld = -1; PointCounter = 0;
Point2D = 0;   Point3D = 0;
CircleIndex=0;
LinkedList=0;
DIRECTION = 0;
UndoList=0; UndoListCnt=0;
NUMBER_OF_EDGES=0;
%% CREATE SOME BUTTONS
%RadioBtn_Direction = uicontrol('Style','radiobutton','Callback',@RadioBtn_Direction);
figure(1);
myRadioButtons;
myButtons;
%%%%%%%%%%%%%%%%%%%%%%
RUNNING = 1;
while(RUNNING)
    [LineOutput] = getInput(1, Point3D, FIXED_AXES_HANDLE, DIRECTION);
    %['PointCounter sau khi get input: ', num2str(PointCounter)]
    if PointCounter ~=0 && PointCounterOld ~= PointCounter %% HAVE A NEW POINT
        PointCounterOld = PointCounter;
        Point3D(PointCounter,1:7) = FindClosest3DPointOnTorus(Torus_x, Torus_y, Torus_z, Point2D(PointCounter,1:2));
        DrawPointOnTorus(2, Point3D(end,1:3));
        
    else %% HAVE A NEW LINE
        [EndPoint1 EndPoint2] = FixEndPointsToVertices(Point3D, Torus_x, Torus_y, Torus_z, LineOutput);
        
        if EndPoint1(1)~=0 && EndPoint2(1)~=0
            LinkedList = UpdateLinkedList(LinkedList, EndPoint1(1), EndPoint2(1));
        end;
        
        DrawWalkOnTorus(2, R, r, Point3D, EndPoint1, EndPoint2, Torus_x, Torus_y, Torus_z, Torus_u, Torus_v, LineOutput, DIRECTION);
        
    end;
end;