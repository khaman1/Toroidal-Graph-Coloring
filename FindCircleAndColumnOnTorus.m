function [CIRCLE COLUMN CIRCLE_2D COLUMN_2D] = FindCircleAndColumnOnTorus(Torus_x, Point2D)

%% Find a closest X base on x to get what circle 
nbins     = numel(Torus_x(1,:)); % Find numbers in that row
BinValues = linspace(-3,3, nbins);
BinValues = flipud(rot90(BinValues));


f1 = BinValues(:,1);
tmp = abs(f1 - Point2D(1,1)); 
[COLUMN COLUMN] = min(tmp); %index of closest value
%closest = f(idx); %closest value


%% Then base on y to find the location on the rotation
nbins     = numel(Torus_x(:, COLUMN)); % Find numbers in that column
BinValues = linspace(-1,1, nbins);
BinValues = flipud(rot90(BinValues));


f2 = BinValues(:,1);
tmp = abs(f2 - Point2D(1,2)); 
[CIRCLE CIRCLE] = min(tmp); %index of closest value

COLUMN_2D = f1(COLUMN,1);
CIRCLE_2D = f2(CIRCLE,1);