## Copyright (C) 2022-2024 Carlos Andres Mata Calderon
## Tarea 2
##
## -*- texinfo -*-
## @deftypefn {Function File} {@var{M} =} matrix_design(@var{X},@var{O})
## Matrix design
##
## Given a set of m training points in @var{X} with known 'z'-values
## stored in in the vector @var{z}, estimate the 'z'-values on the n
## data points @var{p}, which usually lie somewhere inbetween the
## points in @var{X}. Chatgpt helped me with this function, on the part
## how generate the powers of x1 and x2.
##
## @param @var{X}: support data (or training data) with all m known d-D
##                 positions
## @param @var{O}: integer specifying the order of the polynomial
##                 surface (O=1 is linear regression, O=2 parabolic
##                 regression, etc.)
##
## @return @var{M}: the n z-values for each data in @var{p}
##
## Usage:
##
## M = matrix_design(X, O)
## @end deftypefn
function M = matrix_design(X, O=1)
  % Check the number of variables (columns) in X
  [n, variables] = size(X);

  if variables == 1
      % Case for a single variable
      powers = (0:O);
      M = X .^ powers;
      
  elseif variables == 2
      % Case for two variables
      [p1, p2] = ndgrid(0:O, 0:O);
      powers = [p1(:) p2(:)];

      % Only keep powers that sum to less than or equal to O
      powers = powers(sum(powers, 2) <= O, :);

      % Extract powers for x1 and x2
      powers_x1 = powers(:,1)';
      powers_x2 = powers(:,2)';

      % Apply powers to x1 and x2
      X1 = X(:,1) .^ powers_x1;
      X2 = X(:,2) .^ powers_x2;

      % Make the product of the powers of x1 and x2
      M = X1 .* X2;
      
  else
      % Throw an error if X is not n x 1 or n x 2
      error('Input matrix X must have 1 or 2 columns.');
  endif
end
