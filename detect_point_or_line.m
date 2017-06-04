function RESULT = detect_point_or_line(Point2D)

if numel(Point2D(:,1)) == 0
    return;
end;


if numel(Point2D(:,1)) <= 5 %% POINT
    RESULT = 1;
else %% LINE
    RESULT = 0;
end;