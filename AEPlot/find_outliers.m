function [x_new, y_new, outliers] = find_outliers(x, y, N, fold_change)
% FIND_OUTLIERS identifies data points in the 'y' array that are
% greater than 'fold_change' times the local mean or less than
% '1/fold_change' times the local mean. The local mean is calculated using
% a moving window of 'N' points.
%
% Input arguments:
% x - array of x-axis values
% y - array of y-axis values
% N - number of points to include in the moving window for calculating the
%     local mean
% fold_change - (optional) fold change threshold for identifying outlier
%               points (default value: 2)
%
% Output arguments:
% x_new - updated array of x-axis values with the outlier points removed
% y_new - updated array of y-axis values with the outlier points removed
% outliers - array of indices of the outlier data points in the 'y' array

% Check if 'fold_change' was provided as an input argument, and set the
% default value if it wasn't
if nargin < 4
    fold_change = 2;
end

% Check if x is sorted in increasing order, and sort it if it's not
if ~issorted(x)
    [x, sort_idx] = sort(x);
    y = y(sort_idx);
end

% Initialize a list to store the indices of the outlier data points
outliers = [];

% Iterate over each data point
for i = 1:length(y)
    
    % Calculate the mean value of y(i-N:i+N)
    if i-N < 1
        mean_y = mean(y(1:i+N));
    elseif i+N > length(y)
        mean_y = mean(y(i-N:end));
    else
        mean_y = mean(y(i-N:i+N));
    end
    
    % Check if y(i) is greater than 'fold_change'*E(i) or less than
    % E(i)/'fold_change'
    if y(i) > fold_change*mean_y || y(i) < mean_y/fold_change
        
        % If it is, add the index to the list of outlier data points
        outliers = [outliers i];
    end
end

% Remove the outlier data points from the 'x' and 'y' arrays
x_new = x;
x_new(outliers) = [];
y_new = y;
y_new(outliers) = [];
