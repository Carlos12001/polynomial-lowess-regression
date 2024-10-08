## Copyright (C) 2022-2024 Pablo Alvarado
## EL5857 Aprendizaje automático
## Tarea 2

## -*- texinfo -*-
## @deftypefn {Function File} {@var{rz} =} linreg_nointercept(@var{p},@var{X},@var{z})
## @deftypefnx {Function File} {[@var{rz},theta] =} linreg_nointercept(@var{p},@var{X},@var{z})
## Linear regression with no intercept
##
## Given a set of m training points in @var{X} with known 'z'-values
## stored in in the vector @var{z}, estimate the 'z'-values on the
## n data points @var{p}, which usually lie somewhere inbetween the
## points in @var{X}.  Optionally return the found parameters
## @var{theta}.
##
## Since there is no intercept the (hyper)plane always pass through
## the origin.
##
## @param @var{p}: matrix of size n x d, with n d-D positions on which
##                 the z value needs to be regressed
##
## @param @var{X}: support data (or training data) with all m known d-D
##                 positions
##
## @param @var{z}: support data with the corresponding m z values for
##                 each position
##
## @return @var{rz}: the n z-values for each data in @var{p}
##
## @return @var{theta}: estimated parameters
##
## The number of rows of @var{X} must be equal to the length of @var{z}.
##
## The function must generate the z position for all data points in @var{p}.
##
## Usage:
##
## rz=linreg_nointercept(p,X,z)
##
## [rz,theta]=linreg_nointercept(p,X,z)
## @end deftypefn
function varargout=linreg_nointercept(p,X,z)
  ## This code is for simple linear regression with no intercept
  theta=pinv(X)*z(:);
  rz=p*theta;

  ## The first returned value must be the estimated rz heights.
  varargout{1}=rz;
  
  if nargout>1
    ## The user also wants the parameters theta    
    varargout{2}=theta;
  endif
endfunction
