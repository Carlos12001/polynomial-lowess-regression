## Copyright (C) 2022-2024 Pablo Alvarado
## EL5857 Aprendizaje automático
## Tarea 2

## Cómo usar la prueba unitaria:
##
## 1) Inicie GNU/Octave en el directorio que contiene su función polyreg.m
## 2) Agregue la ruta de las pruebas unitarias (p.ej. addpath("../tests"))
## 3) Ejecute el script de prueba test_polyreg

printf("Prueba regresión polinomial in 2D: ")

success=0;
failed=0;

## Ground truth parameters
theta_gt=[0.48;0.2;-1.86];

## Genere N datos para estimar los parámetros
N=10;
X_gt=[ 0.640165, -0.896102
      -0.208884,  0.184907
      -0.507607,  0.316518
      -0.866588, -0.035319
       0.247466, -0.555557
       0.390094, -0.312222
       0.952271, -0.285647
      -0.902457, -0.425354
       0.876131,  0.056719
      -0.857361, -0.84162 ];

z_gt=[ 2.7902
       0.8667
       0.8703
       1.0387
       1.7340
       1.5364
       2.1716
       1.2745
       1.6826
       1.7368 ];
  
## Genere N datos para reconstruir el plano
p=[ 0.9433   0.1362
   -0.6484   0.8266
   -0.1657  -0.4825
   -0.9267   0.7645
    0.8303   0.7195
   -0.1582  -0.5966
   -0.9567  -0.8274
    0.1827   0.5699
   -0.6551   0.5830
    0.4405   0.5132];

z=[ 1.7021
    1.1476
    1.3679
    1.2925
    1.3685
    1.5186
    1.7340
    0.9335
    0.9934
    1.0592 ];

rz=[];

## Use la función bajo prueba (DUT) para estimar los valores y parámetros
rz=polyreg(p,X_gt,z_gt,2);
  
eps=1e-3;
errz = norm(rz-z);
if (errz > eps)
  printf("falló con error en z de norma %f\n",errz);
else
  printf("ok ");
endif

printf("\n");

printf("Prueba regresión polinomial in 1D: ")

z_gt=[
  -0.017222
   0.721974
   1.084906
   1.591880
   0.270906
   0.155558
  -0.180225
   1.646786
  -0.145849
   1.577881
];

z = [
  -0.1764
   1.2745
   0.6739
   1.6843
  -0.1235
   0.6657
   1.7313
   0.3273
   1.2838
   0.1177
];

rz=polyreg(p(:,1),X_gt(:,1),z_gt,2);
errz = norm(rz-z);
if (errz > eps)
  printf("falló con error en z de norma %f\n",errz);
else
  printf("ok ");
endif

printf("\n");

font_size_letters = 32;
font_size_numbers = 24;
figure("name","Predicciones de regresión polinomial");
hold off;
plot(X_gt(:,1),z_gt,"o;Ground truth;","color",[0.5,0,0]);
hold on;
plot(p(:,1),z,"x;Baseline;","color",[0,0.5,0]);
plot(p(:,1),rz,"s;Prediction;","color",[0,0,0.5]);
set(gca, 'FontSize', font_size_numbers); 
