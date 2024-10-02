## Copyright (C) 2022-2024 Pablo Alvarado
## EL5857 Aprendizaje automático
## Tarea 2

## -*- texinfo -*-
## @deftypefn {Function File} {@var{rz} =} lowess(@var{p},@var{X},@var{z},@var{tau})
## LOcally WEighted regreSSion (LOWESS)
##
## Given a set of m training points in @var{X} with known 'z'-values
## stored in in the vector @var{z}, estimate the 'z'-values on the n
## data points in @var{p}, which usually lie somewhere inbetween the
## points in @var{X}. Chatgpt was used to know the order of the 
## permutations for 3D matrix.
##
## @param @var{p}: matrix of size n x d, with n d-D positions on which
##                 the z value needs to be regressed
##
## @param @var{X}: support data (or training data) with all m known d-D
##                 positions
##
## @param @var{z}: support data with the corresponding m z values for
##                 each position in @var{X}
##
## @param @var{tau}: bandwidth of the locally weighted regression
##
## @return @var{rz}: the n z-values for each data in @var{p}
##
## The number of rows of @var{X} must be equal to the length of @var{z}.
##
## The function must generate the z position for all data points in
## @var{p}.
## @end deftypefn
function rz=lowess(p,X,z,tau)

  % Dimensions
  pn = size(p, 1);
  xn = size(X, 1);
  
  % Augment X and p with ones for bias
  X = [ones(xn, 1), X]; % Add a column of ones to X
  p= [ones(pn, 1), p]; % Add a column of ones to p
  

  p_exp = permute(p, [1, 3, 2]); % Change a pn x 1 x 3
  X_exp = permute(X, [3, 1, 2]); % Change X to a 1 x xn x 3
  
  % Calculate distances, ignoring the bias term for distance calculation
  distances_squared = sum((p_exp(:, :, 2:end) - X_exp(:, :, 2:end)) .^ 2, 3);
  
  % Calculate weights
  weights = exp(-distances_squared / (2 * tau ^ 2));
  
  % Apply regression to each point
  for i = 1:pn
    W = diag(weights(i, :));
    theta = pinv(X' * W * X) * X' * W * z(:);
    rz(i) = p(i, :) * theta;
  endfor
  rz = rz(:);
endfunction
