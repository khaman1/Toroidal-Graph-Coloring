function [Output LinkedList LinesList] = CheckIntersections(LinkedList, LinesList, Point2D)

Output=0;
Point2D         = evalin('base','Point2D');
%%
if numel(LinesList(:,1)) == 1
    return;
end;

%% Check intersections of the latest line with the previous lines
LineInput = LinesList(numel(LinesList(:,1)),:);

for i=1:numel(LinesList(:,1))-1
    CurrentLineToCheck = LinesList(i,:); % Current line
    
    % We might have multiple of segments for a connection
    % So basically check intersection for every pair of segments
    
    for j=1:4:numel(LineInput)
        for k=1:4:numel(CurrentLineToCheck)
            
            if any(CurrentLineToCheck)~=0

                %CurrentSegmentInput     = [LineInput(j), LineInput(j+1); LineInput(j+2), LineInput(j+3)];
                %CurrentSegmentToCompare = [CurrentLineToCheck(k), CurrentLineToCheck(k+1); CurrentLineToCheck(k+2), CurrentLineToCheck(k+3)];
                %PointOutput = linlinintersect(vertcat(CurrentSegmentInput, CurrentSegmentToCompare));

                CurrentSegmentInput     = [LineInput(j) LineInput(j+1) LineInput(j+2) LineInput(j+3)];
                CurrentSegmentToCompare = [CurrentLineToCheck(k) CurrentLineToCheck(k+1) CurrentLineToCheck(k+2) CurrentLineToCheck(k+3)];

                %PointOutput = findintersection(CurrentSegmentInput, CurrentSegmentToCompare);
                PointOutput1 = lineSegmentIntersect(CurrentSegmentInput, CurrentSegmentToCompare);
                PointOutput  = [PointOutput1.intMatrixX PointOutput1.intMatrixY];

%                 disp(['i j k: ', num2str(i), num2str(j), num2str(k)]);
%                 disp(['Output: ', num2str(Output)]);

                %% If there is an intersection
                %% Check that the intersection should not be the endpoints
                %%   Align the intersection to the closest points
                %% Then append it to the list
                if PointOutput1.intAdjacencyMatrix ~=0
                %if PointOutput(1) ~=0 && PointOutput(2) ~=0
                    OFFSET_X = 0.02;
                    OFFSET_Y = 0.02;
                    EndPoint2D_index=0;


                    for i=1:numel(Point2D(:,1))
                        if (abs(PointOutput(1) - Point2D(i,1)) <= OFFSET_X) && (abs(PointOutput(2) - Point2D(i,2)) <= OFFSET_Y)
                            EndPoint2D_index = i;
                        end;
                    end;
                    
                    if EndPoint2D_index==0
                        %% We have a new point
                        %  Update the points list
                        if Output==0
                            Output = PointOutput;
                        else
                            Output = vertcat(Output, PointOutput);
                        end;
                        
%                         PointCounter    = PointCounter+1;
%                         Point2D(PointCounter,1:2) = PointOutput;
%                         
%                         plot(PointOutput(1), PointOutput(2), '.', 'Color', 'r', 'Markersize', 25);
%                         text(PointOutput(1)-0.07, PointOutput(2)-0.07, num2str(PointCounter), 'FontSize', 15, 'Color', 'r');
            
                        
                        [LinkedList LinesList] = UpdateListsWithNewIntersection(LinkedList, LinesList, Point2D, ...
                            [LineInput(1) LineInput(2) LineInput(end-1) LineInput(end)], ...
                            [CurrentLineToCheck(1) CurrentLineToCheck(2) CurrentLineToCheck(end-1) CurrentLineToCheck(end)]);
                    %CurrentSegmentInput, CurrentSegmentToCompare);
                    end;
                end;
            end;
        end;
    end;
end;