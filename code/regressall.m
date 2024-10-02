## Copyright (C) 2022 Pablo Alvarado
## EL5857 Aprendizaje automático
## Tarea 2

## Template file for the whole solution

function regressall(evallingreg=true,evalpoly=true,evallowess=true)

  ## Show the sensed data
  close all;
  clc;
  currentDir = pwd;
  suffixLength = length('code');
  if length(currentDir) >= suffixLength && strcmp(currentDir(end-suffixLength+1:end), 'code')
    addpath([currentDir(1:end-suffixLength), "code"]);
    addpath([currentDir(1:end-suffixLength), "tests"]);
  else
    addpath([currentDir, "/code"]);
    addpath([currentDir, "/tests"]);
  endif

  ## Just use 0,1% of the total available data in the experiments
  [X,z] = gendata(0.001);

  ## This is the ground-truth (reference) data to be used for comparison
  [RX,rz] = gendata(1,0,0);

  aspratio=[1,1,2]; # aspect ratio


  font_size_letters = 32;
  font_size_numbers = 24;


  figure(1,"name","Sensed data");
  plot3(X(:,1),X(:,2),z',".");
  xlabel("x",'FontSize', font_size_letters);
  ylabel("y",'FontSize', font_size_letters);
  zlabel("z",'FontSize', font_size_letters);
  daspect(aspratio);
  set(gca, 'FontSize', font_size_numbers);

  ## Extract from the ground-truth RX the coordinate range:
  minx=min(RX(:,1));
  maxx=max(RX(:,1));

  miny=min(RX(:,2));
  maxy=max(RX(:,2));

  ## partition is the size of the desired final grid
  ## the smaller the value, the faster the estimation but
  ## the coarser the result.
  partition=25;
  ##partition=50;
  ##partition=75;
  [xx,yy]=meshgrid(round(linspace(minx,maxx,partition)),
                   round(linspace(miny,maxy,partition)));

  ## Flatten the mesh
  NX = [xx(:) yy(:)];

  ## Show the reference data as a gray-scaled image
  rmat = reshape(rz,[maxy,maxx]);
  deepest = min(rmat(:));
  highest = max(rmat(:));
  rmat = flipud((rmat-deepest)/(highest-deepest));
  figure(2,"name","Reference data as image");
  imshow(rmat);

  ## Reference code uses linear regression with no intercept
  printf("\n\n\n\n-------------------\n\n");
  printf("Linear regression with no intercept started...");
  fflush(stdout);
  tic();
  nz = linreg_nointercept(NX,X,z);
  printf("done.\n");
  toc()
  fflush(stdout);


  figure(3,"name","Linearly regressed data with no intercept");
  hold off;
  surf(xx,yy,reshape(nz,size(xx)));
  xlabel("x",'FontSize', font_size_letters);
  ylabel("y",'FontSize', font_size_letters);
  zlabel("z",'FontSize', font_size_letters);
  daspect(aspratio);
  set(gca, 'FontSize', font_size_numbers);

  ## Insert here the calls to your implementations of:
  ## - the linear regression with intercept
  printf("\n\n\n\n-------------------\n\n");
  printf("Linear regression with Intercept started...");
  fflush(stdout);
  tic();
  nz_lingreg = linreg(NX,X,z);
  printf("done.\n");
  toc()
  fflush(stdout);

  figure(4,"name","Linearly regressed data with Intercept");
  hold off;
  surf(xx,yy,reshape(nz_lingreg,size(xx)));
  xlabel("x",'FontSize', font_size_letters);
  ylabel("y",'FontSize', font_size_letters);
  zlabel("z",'FontSize', font_size_letters);
  daspect(aspratio);
  set(gca, 'FontSize', font_size_numbers);

  ## - the polynomial regression with intercept
  printf("\n\n\n\n-------------------\n\n");
  O = 10;
  printf(["Polynomial ord ", num2str(O)," regression with Intercept started..."]);
  fflush(stdout);
  tic();
  nz_polyreg = polyreg(NX,X,z, 10);
  printf("done.\n");
  toc()
  fflush(stdout);

  figure(5,"name",["Polynomial ord ", num2str(O), 
                  " regressed data with Intercept"]);
  hold off;
  surf(xx,yy,reshape(nz_polyreg,size(xx)));
  xlabel("x",'FontSize', font_size_letters);
  ylabel("y",'FontSize', font_size_letters);
  zlabel("z",'FontSize', font_size_letters);
  daspect(aspratio);
  set(gca, 'FontSize', font_size_numbers);
  
  ## - the locally weighted regression
  printf("\n\n\n\n-------------------\n\n");
  tau = 250;
  printf(["Locally weighted regressed (tau = ", num2str(tau), ") started..."]);
  fflush(stdout);
  tic();
  nz_lowess = lowess(NX,X,z,tau);
  printf("done.\n");
  toc()
  fflush(stdout);

  figure(6,"name",["Locally weighted regressed (tau = ", num2str(tau), " )"]);
  hold off;
  surf(xx,yy,reshape(nz_lowess,size(xx)));
  xlabel("x",'FontSize', font_size_letters);
  ylabel("y",'FontSize', font_size_letters);
  zlabel("z",'FontSize', font_size_letters);
  daspect(aspratio);
  set(gca, 'FontSize', font_size_numbers);

  ## Evaluate the error

  ## Find the grid indices
  gidx = sub2ind([maxy, maxx], yy(:), xx(:));
  
  ## Reference values at the indices
  rvals = rz(gidx);

  ## Normalize the error
  minrvals = min(rvals);
  maxrvals = max(rvals);
  normalize_error = 1/(maxrvals-minrvals);
  
  if evallingreg
    printf("\n\n\n\n-------------------\n\n");
    mse_lingreg = mean((rvals - nz).^2)*normalize_error;
    printf("MSE Normalized linear regression: %f\n", mse_lingreg);
  endif

  if evalpoly
    printf("\n\n\n\n-------------------\n\n");
    printf(["Finding best polynomial started..."]);
    fflush(stdout);
    poly_orders = 1:40;
    poly_errors = zeros(size(poly_orders));

    for i = poly_orders
      nz_polyreg = polyreg(NX, X, z, i);
      mse_poly = mean((rvals - nz_polyreg).^2)*normalize_error;
      poly_errors(i) = mse_poly;
    endfor

    printf("done.\n");
    fflush(stdout);


    % Plot the errors
    figure(7,"name","Polynomial Order vs MSE");
    plot(poly_orders, poly_errors, '-o');
    xlabel('Order of the Polynomial','FontSize', font_size_letters);
    ylabel('MSE Normalized','FontSize', font_size_letters);
    title('Error vs Polynomial Order','FontSize', font_size_letters);
    set(gca, 'FontSize', font_size_numbers); 

    % Find the best order
    [min_error, best_order] = min(poly_errors);
    printf("The best order is: %d with MSE Normalized: %f\n", best_order, min_error);

    % Reconstruct the best polynomial
    nz_best_poly = polyreg(NX, X, z, best_order);
    figure(8,"name",sprintf('Surface of the best polynomial order %d', best_order));
    surf(xx, yy, reshape(nz_best_poly, size(xx)));
    xlabel('x','FontSize', font_size_letters);
    ylabel('y','FontSize', font_size_letters);
    zlabel('z','FontSize', font_size_letters);
    title(  sprintf('Surface of the best polynomial order %d', best_order),
            'FontSize', font_size_letters);
    set(gca, 'FontSize', font_size_numbers); 
    daspect(aspratio);
  endif

  if evallowess
    printf("\n\n\n\n-------------------\n\n");
    tau_values = 0.05:0.05:0.95;
    tau_values = [tau_values, 1:0.5:50];

    lowess_errors = zeros(size(tau_values));

    printf(["Finding best tau started..."]);
    fflush(stdout);
    
    for i = 1:length(tau_values)
      nz_lowess = lowess(NX, X, z, tau_values(i));
      mse_lowess = mean((rvals - nz_lowess).^2)*normalize_error;
      lowess_errors(i) = mse_lowess;
    endfor

    printf("done.\n");
    fflush(stdout);
    
    % Plot error as a function of tau
    figure(9,"name","LOWESS Error as a Function of Tau");
    plot(tau_values, lowess_errors, '-o');
    xlabel('Tau','FontSize', font_size_letters);
    ylabel('MSE Normalized','FontSize', font_size_letters);
    title('LOWESS Error as a Function of Tau','FontSize', font_size_letters);
    set(gca, 'FontSize', font_size_numbers); 
    
    % Find the tau with the least error
    [min_error, best_tau_index] = min(lowess_errors);
    best_tau = tau_values(best_tau_index);
    printf("Best Tau: %d with MSE Normalized: %f\n", best_tau, min_error);
    
    % Display the reconstructed surface for the tau with the least error
    nz_best_lowess = lowess(NX, X, z, best_tau);
    figure(10,"name",sprintf('Reconstructed Surface with LOWESS tau=%d', best_tau));
    surf(xx, yy, reshape(nz_best_lowess, size(xx)));
    xlabel('x','FontSize', font_size_letters);
    ylabel('y','FontSize', font_size_letters);
    zlabel('z','FontSize', font_size_letters);
    title(  sprintf('Reconstructed Surface with LOWESS tau=%d', best_tau),
            'FontSize', font_size_letters);
    set(gca, 'FontSize', font_size_numbers); 
    daspect(aspratio);
  endif
  
endfunction
