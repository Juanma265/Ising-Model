# Simulación Monte Carlo del Modelo de Ising 2D (Algoritmo de Metropolis)

Implementación numérica del modelo de Ising bidimensional para el estudio de transiciones de fase ferromagnéticas y propiedades termodinámicas utilizando el algoritmo de Metropolis. El proyecto incluye un núcleo computacional de alto rendimiento en Fortran 90 y scripts de posprocesado en Python para visualización y generación de animaciones de los dominios magnéticos.

---

## Descripción del Proyecto

El sistema modela una red cuadrada bidimensional de tamaño $L \times L$ con espines $s_i \in \{-1, +1\}$ bajo condiciones de contorno periódicas[cite: 1]. La energía del sistema viene descrita por el hamiltoniano con acoplamiento ferromagnético a primeros vecinos:

$$H = -J \sum_{\langle i,j \rangle} s_i s_j \quad (J = 1)$$

El algoritmo de Metropolis evalúa el cambio energético $\Delta E$ asociado a la inversión de un espín elegido al azar[cite: 1]:
1. Si $\Delta E \le 0$, el cambio es aceptado[cite: 1].
2. Si $\Delta E > 0$, el cambio se acepta con una probabilidad dada por el peso de Boltzmann: $P = e^{-\Delta E / T}$[cite: 1].

---

## Estructura del Código

* **`modelo_ising.f90`**: Núcleo numérico en Fortran[cite: 1].
  * Configuración inicial del retículo: estado ordenado (ferromagnético, todos $s=1$) o desordenado (paramagnético, asignación aleatoria)[cite: 1].
  * Integración Monte Carlo con condiciones de contorno periódicas y actualización estocástica[cite: 1].
  * Monitorización continua y exportación de la magnetización promedio por espín ($m = \frac{1}{N} \sum s_i$)[cite: 1].
  * Volcado periódico de configuraciones espaciales completas de la red para análisis dinámico[cite: 1].
* **`modelo_ising.py`**: Script de visualización gráfica en Python[cite: 2].
  * Lee `magnetizacion.txt` y representa la evolución temporal de la magnetización promedio $m(t)$ a lo largo de los pasos de Monte Carlo[cite: 2].
  * Exporta la gráfica resultante en alta resolución (`grafico_ising.png`)[cite: 2].
* **`modelo_ising2.py`**: Módulo de animación de dominios.
  * Parsea los estados de la red almacenados en `matriz_configuracion.txt`[cite: 3].
  * Genera una animación interactiva con `matplotlib.animation.FuncAnimation` que muestra en tiempo real la nucleación y coalescencia de dominios magnéticos de espín[cite: 3].

---

## Compilación y Ejecución

### 1. Requisitos
* Compilador de Fortran (ej. `gfortran`).
* Python 3.x con librerías: `numpy` y `matplotlib`.

```bash
pip install numpy matplotlib
```

### 2. Simulación en Fortran
Compila el programa activando banderas de optimización[cite: 1]:

```bash
gfortran -O3 modelo_ising.f90 -o modelo_ising
./modelo_ising
```

El ejecutable solicitará por consola[cite: 1]:
* **Side (LxL):** Tamaño de la arista del retículo (ej. `50` para una red de $50 \times 50$)[cite: 1, 3].
* **Temperatura:** Temperatura del sistema en unidades reducidas (ej. $T = 2.0$ para fase ferromagnética o $T = 3.0$ para fase paramagnética; $T_c \approx 2.269$)[cite: 1].
* **Configuracion:** `1` para red ordenada inicial, `2` para red desordenada aleatoria[cite: 1].

### 3. Visualización y Animación (Python)
Para generar la curva de evolución de la magnetización[cite: 2]:
```bash
python modelo_ising.py
```

Para visualizar la evolución dinámica y crecimiento de dominios de la red[cite: 3]:
```bash
python modelo_ising2.py
```

---

## Ficheros de Salida

* **`magnetizacion.txt`**: Datos de dos columnas `[Paso_MC, Magnetización_promedio]`[cite: 1, 2].
* **`matriz_configuracion.txt`**: Snapshots periódicos del estado de la red para su reconstrucción espacial[cite: 1, 3].
* **`grafico_ising.png`**: Gráfica de la magnetización promedio generada tras ejecutar el script de análisis[cite: 2].
