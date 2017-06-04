function Edges = SubdivideEdge(Edges, LineEndPoints, ListofMiddlePoints)

FLAG=0;
for i=1:2:numel(Edges)
    if (Edges(i) == LineEndPoints(1) && Edges(i+1) == LineEndPoints(2)) || ...
            (Edges(i) == LineEndPoints(2) && Edges(i+1) == LineEndPoints(1))

        FLAG=1;
        NewEdges=0;
        for j=1:numel(ListofMiddlePoints)-1
            NewEdges(2*(j-1)+1) = ListofMiddlePoints(j);
            NewEdges(2*(j-1)+2) = ListofMiddlePoints(j+1);
        end;
        
        if NewEdges ~=0
            Edges       = cat(2, Edges, NewEdges);
        end;
        
        Edges       = cat(2, Edges, [ListofMiddlePoints(end) Edges(i+1)]);
        Edges(i+1)  = ListofMiddlePoints(1);
        
        break;
    end;
end;

if FLAG == 0
    'HAHA'
    NewEdges=0;
    
    NewEdges(1:2) = [LineEndPoints(1) ListofMiddlePoints(1)];
    for j=1:numel(ListofMiddlePoints)-1
        NewEdges(2*(j)+1) = ListofMiddlePoints(j);
        NewEdges(2*(j)+2) = ListofMiddlePoints(j+1);
    end;
    
    if numel(ListofMiddlePoints) == 1
        NewEdges(numel(NewEdges)+1:numel(NewEdges)+2) = [ListofMiddlePoints(1) LineEndPoints(2)];
    else
        NewEdges(numel(NewEdges)+1:numel(NewEdges)+2) = [ListofMiddlePoints(2) LineEndPoints(2)];
    end;
    Edges = cat(2, Edges, NewEdges);
end;