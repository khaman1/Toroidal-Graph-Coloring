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


%% Load default Figure
%openfig('E:\kha.man\Dropbox\Lamviec\Toroidal graphs coloring\MATLAB Code\Some toroidal graphs\K7\Subdivision\1.fig');
load('E:\kha.man\Dropbox\Lamviec\Toroidal graphs coloring\MATLAB Code\Some toroidal graphs\K7\Subdivision\2.mat');

ListColors = [1, 2, 2, 2, 3, 3, 4, 1, 3, 1, 3, 3, 1, 2, 1, 1, 4, 3, 1, 1, 1, 3, 2, 1, 2, 3, 2, 2, 2, 1];
VertexList = [1, 14, 3, 4, 15, 6, 7, 2, 18, 25, 26, 23, 24, 5, 16, 29, 17, 27, 22, 10, 11, 28, 12, 19, 20, 8, 9, 21, 30, 13];
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