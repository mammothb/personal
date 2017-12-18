function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
vals  = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
[p, q] = meshgrid(vals, vals);
C_sigma = [p(:), q(:)];
error_val = zeros(length(C_sigma), 1);

for i = 1 : length(C_sigma)
  model = svmTrain(X, y, C_sigma(i, 1), @(x1, x2) gaussianKernel(x1, x2, ...
      C_sigma(i, 2)));
  predictions = svmPredict(model, Xval);
  error_val(i) = mean(double(predictions ~= yval));
end
[min_error, idx] = min(error_val);
C = C_sigma(idx, 1);
sigma = C_sigma(idx, 2);

fprintf(['\nFinish searching. Best value [C, sigma] = [%f %f] with ' ...
    'prediction error = %f\n\n'], C, sigma, min_error);
fprintf('Program paused. Press enter to continue.\n');
pause;
% =========================================================================

end