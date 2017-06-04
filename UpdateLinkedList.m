function LinkedList = UpdateLinkedList(LinkedList, Point1_index, Point2_index)

if LinkedList==0
    LinkedList(1,1:2) = [Point1_index, Point2_index];
else
    LinkedList(end+1,1:2) = [Point1_index, Point2_index];
end;