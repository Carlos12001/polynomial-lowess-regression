[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-718a45dd9cf7e7f842a935f5ebbe5719a5e09af4491e668f4dbf3b35d5cca122.svg)](https://classroom.github.com/online_ide?assignment_repo_id=13949866&assignment_repo_type=AssignmentRepo)

# Tarea 2

EL5857 Aprendizaje automático

Estos son los archivos base para la tarea 2.

- heightmap.png
  Datos de profundidad codificados como imagen de 16-bit por pixel
- gendata.m
  Archivo que toma la imagen heightmap.png y la carga como datos de
  posición y profundidad.
- showdata.m
  Archivo de ejemplo, solo para obtener datos aleatorios y mostrarlos
- regressall.m
  Archivo central, que llama a todas las otras funciones.
- linreg_nointercept.m
  Implementación de regresión lineal sin sesgo, que obliga al hiperplano
  encontrado a pasar por cero. La implementación es completa
- linreg.m
  Plantilla para la regresión lineal completa, que puede tener sesgo
  (no necesariamente pasa por el origen).
  Tiene una implementación de relleno igual a la de linreg_nointercept.m
- polyreg.m
  Plantilla para la regresión polinomial, con sesgo
  (no necesariamente pasa por el origen).
  Tiene una implementación de relleno igual a la de linreg_nointercept.m
- lowess.m
  Plantilla para la regresión ponderada localmente.
  Tiene una implementación de relleno igual a la de linreg_nointercept.m

Este código necesita el paquete '''image''' que puede instalar dentro de
octave con:

```octave
     pkg install -forge image
```

Si funciona utilizar apt para el caso de distrobución Debian o Ubuntu.

```bash
    sudo apt install liboctave-dev -y
```

## Solución

La solución de la tarea 2 en encuentra en el `docs/solution.pdf`. En ese
archivo se detalla la demostraciones y que archivos de GNU/Octave se usaron
para resolver la tarea.

## Archivos de GNU/Octave

Para correr el proyecto ejecutar el comando: `octave` dentro
la carpeta root de la tarea. Y luego ejecutar en el siguiente orden:

### Correr el proyecto

```octave
run "./code/regressall.m"
```

### Pruebas

```octave
run "./tests/unit_test.m"
```

## Integrantes

- Carlos Andres Mata Calderon
