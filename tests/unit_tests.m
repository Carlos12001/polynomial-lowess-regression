## Copyright (C) 2022-2024 Pablo Alvarado
## EL5857 Aprendizaje automático
## Tarea 2

1;

clc;
close all;
currentDir = pwd;
suffixLength = length('tests');
if length(currentDir) >= suffixLength && strcmp(currentDir(end-suffixLength+1:end), 'tests')

    addpath([currentDir(1:end-suffixLength), "code"]);
    addpath([currentDir(1:end-suffixLength), "tests"]);

else

    addpath([currentDir, "/code"]);
    addpath([currentDir, "/tests"]);

end


test_linreg
test_polyreg
test_lowess
