function DrawPointOnTorus(figureofTorus, Point)

if ~any(findall(0,'Type','Figure')==figureofTorus)
    return;
end;


figure(figureofTorus); hold on;



New(1) = plot3(Point(1,1), Point(1,2), Point(1,3), '.', 'Color', 'r', 'Markersize', 28);
PointCounter = evalin('base','PointCounter');
New(2) = text(Point(1,1)+0.05, Point(1,2), Point(1,3)-0.05, num2str(PointCounter), 'FontSize', 19, 'Color', [0 0.5 0]);
disp(['Added Point ', num2str(PointCounter), '!']);
UpdateUndoList(New,0);