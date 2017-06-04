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

Edges = SubdivideEdge(Edges, [1 4], [13]);
Edges = SubdivideEdge(Edges, [1 5], [18]);
Edges = SubdivideEdge(Edges, [2 4], [22 25]);
Edges = SubdivideEdge(Edges, [2 5], [15 32 28]);
Edges = SubdivideEdge(Edges, [3 4], [19 23 26]);
Edges = SubdivideEdge(Edges, [3 5], [20]);
Edges = SubdivideEdge(Edges, [4 5], [24]);
Edges = SubdivideEdge(Edges, [4 6], [14]);
Edges = SubdivideEdge(Edges, [4 7], [29 16]);
Edges = SubdivideEdge(Edges, [5 7], [30 17]);

Edges = AddNewEdge(Edges, [8 9 9 10 10 11 11 12]);

Edges = SubdivideEdge(Edges, [8 9], [14 13]);
Edges = SubdivideEdge(Edges, [9 10], [16 17 15]);
Edges = SubdivideEdge(Edges, [10 11], [18]);
Edges = SubdivideEdge(Edges, [11 12], [21 20 19]);
Edges = SubdivideEdge(Edges, [12 8], [22]);
Edges = SubdivideEdge(Edges, [12 17], [23 27 24 31]);
Edges = SubdivideEdge(Edges, [14 20], [25 26 27]);
Edges = SubdivideEdge(Edges, [9 18], [29 31 30 28]);
Edges = SubdivideEdge(Edges, [17 18], [32]);


%% Load default Figure
%openfig('E:\kha.man\Dropbox\Lamviec\Toroidal graphs coloring\MATLAB Code\Some toroidal graphs\K7\Subdivision\1.fig');
load('E:\kha.man\Dropbox\Lamviec\Toroidal graphs coloring\MATLAB Code\Some toroidal graphs\K7\Subdivision\1.mat');

ListColors = [1, 2, 3, 2, 2, 4, 5, 1, 3, 1, 2, 3, 2, 1, 2, 1, 2, 2, 4, 3, 2, 1, 3, 1, 2, 1, 1, 1, 3, 3, 3, 1];
VertexList = [1, 2, 3, 13, 18, 6, 7, 22, 15, 19, 20, 4, 24, 14, 29, 5, 30, 25, 32, 28, 23, 26, 16, 17, 8, 9, 10, 11, 21, 12, 27, 31];
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