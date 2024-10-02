## Copyright (C) 2022-2024 Pablo Alvarado
## EL5857 Aprendizaje automático
## Tarea 2

## Cómo usar la prueba unitaria:
##
## 1) Inicie GNU/Octave en el directorio que contiene su función linreg.m
## 2) Agregue la ruta de las pruebas unitarias (p.ej. addpath("../tests"))
## 3) Ejecute el script de prueba test_linreg

printf("Prueba regresión lineal 2D: ")

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

z_gt=[ 2.274783
       0.094296
      -0.210244
       0.372377
       1.562830
       1.138752
       1.201758
       1.090667
       0.549728
       1.873941];
  
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

z=[ 0.4153
   -1.1871
    1.3443
   -1.1274
   -0.6922
    1.5580
    1.8275
   -0.5435
   -0.7354
   -0.3864 ];

rz=[];

## Use la función bajo prueba (DUT) para estimar los valores y parámetros
rz=linreg(p,X_gt,z_gt);
  
eps=1e-2;
errz = norm(rz-z);
if (errz > eps)
  printf("falló con error en z de norma %f\n",errz);
else
  printf("ok ");
endif

printf("\n");


printf("Prueba regresión lineal 1D: ")
z_gt= [-0.2759
       -0.5731
       -0.6777
       -0.8033
       -0.4134
       -0.3635
       -0.1667
       -0.8159
       -0.1934
       -0.8001];

z = [-0.1698
     -0.7269
     -0.5580
     -0.8243
     -0.2094
     -0.5554
     -0.8348
     -0.4361
     -0.7293
     -0.3458];

rz=linreg(p(:,1),X_gt(:,1),z_gt);
errz = norm(rz-z);
if (errz > eps)
  printf("falló con error en z de norma %f\n",errz);
else
  printf("ok ");
endif

printf("\n");

font_size_letters = 32;
font_size_numbers = 24;
figure("name","Predicciones de regresión lineal");
hold off;
plot(X_gt(:,1),z_gt,"o;Ground truth;","color",[0.5,0,0]);
hold on;
plot(p(:,1),z,"x;Baseline;","color",[0,0.5,0]);
plot(p(:,1),rz,"s;Prediction;","color",[0,0,0.5]);
set(gca, 'FontSize', font_size_numbers); 
