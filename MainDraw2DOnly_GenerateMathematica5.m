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

Edges = SubdivideEdge(Edges, [1 2], [40 41 42]);
Edges = SubdivideEdge(Edges, [1 3], [43 44 47 48 49]);
Edges = SubdivideEdge(Edges, [1 4], [38 39]);
Edges = SubdivideEdge(Edges, [1 5], [23 20]);
Edges = SubdivideEdge(Edges, [1 6], [37 36 35]);
Edges = SubdivideEdge(Edges, [1 7], [45 46]);
Edges = SubdivideEdge(Edges, [2 3], [50 51 52]);
Edges = SubdivideEdge(Edges, [2 4], [30 31]);
Edges = SubdivideEdge(Edges, [2 5], [22 21]);
Edges = SubdivideEdge(Edges, [2 6], [57 58]);
Edges = SubdivideEdge(Edges, [3 4], [34 33 32]);
Edges = SubdivideEdge(Edges, [3 5], [13 14 15]);
Edges = SubdivideEdge(Edges, [3 6], [53 54]);
Edges = SubdivideEdge(Edges, [3 7], [56 55]);
Edges = SubdivideEdge(Edges, [4 5], [11 12]);
Edges = SubdivideEdge(Edges, [4 7], [8 9 10]);
Edges = SubdivideEdge(Edges, [5 6], [16 17 18 19]);
Edges = SubdivideEdge(Edges, [5 7], [24 25]);
Edges = SubdivideEdge(Edges, [6 7], [29 28 27 26]);

%% Load default Figure
%openfig('E:\kha.man\Dropbox\Lamviec\Toroidal graphs coloring\MATLAB Code\Some toroidal graphs\K7\Subdivision\1.fig');
load('E:\kha.man\Dropbox\Lamviec\Toroidal graphs coloring\MATLAB Code\Some toroidal graphs\K7\Subdivision\5.mat');

ListColors = [1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 1, 1, 2, ...
1, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 1, 2, 1, 1, 2, 1, 1, 3, 1, 3, 1, 3, ...
3, 1, 3, 2, 1, 2, 1, 2, 3, 1, 2, 1];

VertexList = [1, 40, 43, 38, 23, 37, 45, 2, 50, 30, 22, 57, 7, 3, 34, 13, 53, 56, ...
4, 11, 6, 8, 5, 16, 24, 29, 41, 42, 44, 47, 48, 49, 39, 20, 36, 35, ...
46, 51, 52, 31, 21, 58, 33, 32, 14, 15, 54, 55, 12, 9, 10, 17, 18, ...
19, 25, 28, 27, 26];

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