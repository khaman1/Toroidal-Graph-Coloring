function [LinkedList LinesList] = UpdateListsWithNewIntersection(LinkedList, LinesList, Point2D, Line1, Line2)


OFFSET_X = 0.02;
OFFSET_Y = 0.02;

Points(1,1:2) = Line1(1:2);
Points(2,1:2) = Line1(3:4);
Points(3,1:2) = Line2(1:2);
Points(4,1:2) = Line2(3:4);

NewPoint_index = numel(Point2D(:,1))+1;
EndPoint_index = [0 0 0 0];

for i=1:numel(Point2D(:,1))
    for j=1:4
        if (abs(Points(j,1) - Point2D(i,1)) <= OFFSET_X) && (abs(Points(j,2) - Point2D(i,2)) <= OFFSET_Y)
            EndPoint_index(j) = i;
        end;    
    end;
end;

% for i=1:4
%     if EndPoint_index(j) ~=0
%         Points(j,1:2) = [Point2D(EndPoint_index(j),1) Point2D(EndPoint_index(j),2)];
%     end;
% end;


for i=1:numel(LinkedList(:,1))
    if (LinkedList(i,1) == EndPoint_index(1) && LinkedList(i,2) == EndPoint_index(2)) || ...
            (LinkedList(i,1) == EndPoint_index(2) && LinkedList(i,2) == EndPoint_index(1))

        
        LinkedList              = vertcat(LinkedList, [LinkedList(i,2), NewPoint_index]);
        LinkedList(i,:)         = [LinkedList(i,1), NewPoint_index];
    end;
    
    if (LinkedList(i,1) == EndPoint_index(3) && LinkedList(i,2) == EndPoint_index(4)) || ...
            (LinkedList(i,1) == EndPoint_index(4) && LinkedList(i,2) == EndPoint_index(3))
        
        LinkedList              = vertcat(LinkedList, [LinkedList(i,2), NewPoint_index]);
        LinkedList(i,:)         = [LinkedList(i,1), NewPoint_index];
        
    end;
end;
