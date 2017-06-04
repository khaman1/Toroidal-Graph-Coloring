clear all;
close all;
%% Initialize some variables
FIX_VALUE=1;

Current_FOLDER = strsplit(mfilename('fullpath'),'\');
CheckToroidal_Exe = ['"', strjoin(Current_FOLDER(1:end-2),'\'), '\Visual Studio\CheckToroidal\Release\CheckToroidal.exe' ,'" ']; 
%LOG_File = 'E:\kha.man\Dropbox\Lamviec\Toroidal graphs coloring\GenerateGraphs\Matlab\LOG\Log.xls';
LOG_File = [strjoin(Current_FOLDER(1:end-1), '\'), '\LOG\Log.xls'];
LOG_File_Counter = 0;
delete(LOG_File);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Edges = GetEdgesOfK5(GetSequence(1,7));

Edges = SubdivideEdge(Edges, [1 2], [57 58 59 60]);
Edges = SubdivideEdge(Edges, [1 3], [61 62 63 74 75 76]);
Edges = SubdivideEdge(Edges, [1 4], [91 90]);
Edges = SubdivideEdge(Edges, [1 5], [56 55 54 53 52]);
Edges = SubdivideEdge(Edges, [1 6], [89 88]);
Edges = SubdivideEdge(Edges, [1 7], [92 93]);
Edges = SubdivideEdge(Edges, [2 3], [71 72 73]);
Edges = SubdivideEdge(Edges, [2 4], [64 65 66 67]);
Edges = SubdivideEdge(Edges, [2 5], [51 50 49 48 47]);
Edges = SubdivideEdge(Edges, [3 4], [8 9 10 11 12 13 14 15 16]);
Edges = SubdivideEdge(Edges, [3 5], [40 41 42 43 44 45 46]);
Edges = SubdivideEdge(Edges, [3 6], [83 84 85 86]);
Edges = SubdivideEdge(Edges, [3 7], [79 78 77]);
Edges = SubdivideEdge(Edges, [4 5], [34 35 36 37 38 39]);
Edges = SubdivideEdge(Edges, [4 6], [87]);
Edges = SubdivideEdge(Edges, [4 7], [17 18 19 20 21 22 23 24 25 26 27 28]);
Edges = SubdivideEdge(Edges, [5 6], [80 81 82]);
Edges = SubdivideEdge(Edges, [5 7], [33 32 31 30 29]);
Edges = SubdivideEdge(Edges, [6 7], [70 69 68]);

%% Load default Figure
%openfig('E:\kha.man\Dropbox\Lamviec\Toroidal graphs coloring\MATLAB Code\Some toroidal graphs\K7\Subdivision\1.fig');
load('E:\kha.man\Dropbox\Lamviec\Toroidal graphs coloring\MATLAB Code\Some toroidal graphs\K7\Subdivision\4.mat');

ListColors = [1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 2, 2, 1, ...
2, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 3, 1, 2, 1, 2, 3, 3, 2, 1, 2, 1, 2, ...
2, 1, 2, 3, 2, 1, 2, 1, 2, 1, 2, 3, 2, 1, 2, 1, 2, 3, 2, 1, 2, 2, 3, ...
1, 2, 1, 2, 3, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 3, 1, 2, 1, 2, 1, 2, 1, 2];

VertexList = [1, 57, 61, 91, 56, 89, 92, 2, 71, 64, 51, 6, 7, 3, 8, 40, 83, 79, 4, ...
34, 87, 17, 5, 80, 33, 70, 58, 59, 60, 62, 63, 74, 75, 76, 90, 55, ...
54, 53, 52, 88, 93, 72, 73, 65, 66, 67, 50, 49, 48, 47, 9, 10, 11, ...
12, 13, 14, 15, 16, 41, 42, 43, 44, 45, 46, 84, 85, 86, 78, 77, 35, ...
36, 37, 38, 39, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 81, 82, ...
32, 31, 30, 29, 69, 68];

for i=1:numel(ListColors)
    switch(ListColors(i))
        case 1
            plot(Point2D(VertexList(i),1), Point2D(VertexList(i),2), '.', 'Color', 'y', 'Markersize', 28);
        case 2
            plot(Point2D(VertexList(i),1), Point2D(VertexList(i),2), '.', 'Color', 'm', 'Markersize', 28);
        case 3
            plot(Point2D(VertexList(i),1), Point2D(VertexList(i),2), '.', 'Color', 'c', 'Markersize', 28);
        case 4
            plot(Point2D(VertexList(i),1), Point2D(VertexList(i),2), '.', 'Color', 'r', 'Markersize', 28);
        case 5
            plot(Point2D(VertexList(i),1), Point2D(VertexList(i),2), '.', 'Color', 'g', 'Markersize', 28);
        case 6
            plot(Point2D(VertexList(i),1), Point2D(VertexList(i),2), '.', 'Color', 'b', 'Markersize', 28);
        case 7
            plot(Point2D(VertexList(i),1), Point2D(VertexList(i),2), '.', 'Color', 'k', 'Markersize', 28);
    end;
    
end;

%% Generate Mathematica Code
MATHEMATICA_CODE = 'g=System`Graph[{';
    
for j=1:2:numel(Edges)
    MATHEMATICA_CODE = [MATHEMATICA_CODE, num2str(Edges(j)), '<->', num2str(Edges(j+1)), ','];
end;

MATHEMATICA_CODE_TAIL = ', VertexLabels -> "Name", VertexSize -> 0.4, VertexLabelStyle -> Directive[Black, 20], EdgeStyle -> {{Thickness[0.004], Black}}';
MATHEMATICA_CODE = [MATHEMATICA_CODE(1:end-1), '}', MATHEMATICA_CODE_TAIL ,']', char(10), 'ChromaticNumber[g]']

clipboard('copy', MATHEMATICA_CODE);
%AdjacencyList = AnalyzeMessageFromVS(y, FIX_VALUE);