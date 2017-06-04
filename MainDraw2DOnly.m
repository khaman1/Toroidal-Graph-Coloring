%close all;
clear all;
clc;

%% DEFINE SOME TEMP VARIABLES
PointCounterOld = -1; 
Point2D = 0;   Point3D = 0;
CircleIndex=0;
LinkedList= [0 0];
LinesList=0;


DIRECTION = 0;
UndoList=0; UndoListCnt=0;
NUMBER_OF_EDGES=0;

%% Load a specific figure
USE_EXTERNAL_FIGURE=1;

if USE_EXTERNAL_FIGURE == 1
    PointCounter = 7;
    openfig('E:\kha.man\Dropbox\Lamviec\Toroidal graphs coloring\MATLAB Code\Some toroidal graphs\K7\1.fig');
    load('E:\kha.man\Dropbox\Lamviec\Toroidal graphs coloring\MATLAB Code\Some toroidal graphs\K7\matlab.mat');
else
    PointCounter = 0;
end;

%% DEFINE VARIABLES
TRANSPARENCY = 0.5;  %% Transparency of the torus
R=2; r=1;            %% R and r of the torus
FIXED_AXES_HANDLE= [-(R+r) (R+r) -r r]; % Fixed axis for 2 figures
ENABLE_AXIS_ON_TORUS=0;
%% CREATE FIGURE 1
figure(1); axis(FIXED_AXES_HANDLE);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);

%% GENERATE TORUS ON FIGURE 2
%[Torus_x, Torus_y, Torus_z, Torus_u, Torus_v] = GenerateTorus(2, R, r, TRANSPARENCY);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);


%% CREATE SOME BUTTONS
%RadioBtn_Direction = uicontrol('Style','radiobutton','Callback',@RadioBtn_Direction);
figure(1);
myRadioButtons;
myButtons;
%%%%%%%%%%%%%%%%%%%%%%
RUNNING = 1;
while(RUNNING)
    [LineOutput LinkedList LinesList] = getInput2(1, Point3D, FIXED_AXES_HANDLE, DIRECTION, LinkedList, LinesList);
    
    if PointCounter ~=0 && PointCounterOld ~= PointCounter %% HAVE A NEW POINT
        PointCounterOld = PointCounter;
    end;
     
end;