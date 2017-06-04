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

Edges = SubdivideEdge(Edges, [1 2], [14 17]);
Edges = SubdivideEdge(Edges, [1 3], [50 35 10 23]);
Edges = SubdivideEdge(Edges, [1 4], [16 28]);
Edges = SubdivideEdge(Edges, [1 5], [59]);
Edges = SubdivideEdge(Edges, [1 6], [17]);
Edges = SubdivideEdge(Edges, [1 7], [18 30]);
Edges = SubdivideEdge(Edges, [2 3], [11 24 37]);
Edges = SubdivideEdge(Edges, [2 4], [12 25 43]);
Edges = SubdivideEdge(Edges, [2 5], [36 51]);
Edges = SubdivideEdge(Edges, [2 6], [13 26 44]);
Edges = SubdivideEdge(Edges, [2 7], [38]);
Edges = SubdivideEdge(Edges, [3 4], [39 45]);
Edges = SubdivideEdge(Edges, [3 5], [46 55]);
Edges = SubdivideEdge(Edges, [3 6], [19 31]);
Edges = SubdivideEdge(Edges, [3 7], [20 32]);
Edges = SubdivideEdge(Edges, [4 5], [56 40]);
Edges = SubdivideEdge(Edges, [4 7], [57 52]);
Edges = SubdivideEdge(Edges, [5 6], [21 33]);
Edges = SubdivideEdge(Edges, [5 7], [53 41]);
Edges = SubdivideEdge(Edges, [6 7], [47 27 14]);



Edges = AddNewEdge(Edges, [8 9 15 9 15 22 22 8 7 9 23 14 22 21 28 9 28 21 21 2]);

Edges = SubdivideEdge(Edges, [8 9], [14 13 12 11 10]);
Edges = SubdivideEdge(Edges, [15 9], [20 19 21 17 16 18]);
Edges = SubdivideEdge(Edges, [15 22], [23 24 25 26 27]);
Edges = SubdivideEdge(Edges, [22 8], [31 33 29 28 30 32]);
Edges = SubdivideEdge(Edges, [7 9], [42 36 60 34 35]);
Edges = SubdivideEdge(Edges, [23 14], [37 39 48 58 40 54 41 42 38]);
Edges = SubdivideEdge(Edges, [22 21], [47 44 43 45 48 46]);
Edges = SubdivideEdge(Edges, [28 9], [52 54 53 51 61 49 50]);
Edges = SubdivideEdge(Edges, [28 21], [57 56 58 55]);
Edges = SubdivideEdge(Edges, [21 2], [59 61 60]);

%% Load default Figure
%openfig('E:\kha.man\Dropbox\Lamviec\Toroidal graphs coloring\MATLAB Code\Some toroidal graphs\K7\Subdivision\1.fig');
load('E:\kha.man\Dropbox\Lamviec\Toroidal graphs coloring\MATLAB Code\Some toroidal graphs\K7\Subdivision\3.mat');

ListColors = [1, 2, 2, 2, 2, 3, 3, 1, 3, 2, 3, 3, 3, 1, 3, 3, 3, 2, 3, 1, 1, 2, 3, ...
1, 2, 2, 3, 2, 3, 1, 2, 1, 1, 2, 3, 1, 1, 1, 3, 2, 2, 2, 3, 2, 3, 3, ...
3, 3, 1, 1, 1, 2, 1, 2, 2, 1, 1, 3, 1, 3, 1];

VertexList = [1, 14, 50, 16, 59, 17, 18, 2, 11, 12, 36, 13, 38, 3, 39, 46, 19, 20, ...
4, 56, 6, 57, 5, 21, 53, 47, 35, 10, 23, 28, 30, 7, 24, 37, 25, 43, ...
51, 26, 44, 45, 55, 31, 32, 40, 52, 33, 41, 27, 8, 15, 22, 42, 9, 29, ...
60, 34, 48, 58, 54, 61, 49];

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