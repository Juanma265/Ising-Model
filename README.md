# 2D Ising Model Monte Carlo Simulation (Metropolis Algorithm)

Numerical implementation of the two-dimensional Ising model for studying ferromagnetic phase transitions and thermodynamic properties using the Metropolis algorithm. The project features a high-performance computational core in Fortran 90 alongside Python post-processing scripts for data visualization and magnetic domain animations.

---

## Project Overview

The system models a two-dimensional square lattice of size $L \times L$ with spins $s_i \in \{-1, +1\}$ under periodic boundary conditions. The total energy of the system is governed by the nearest-neighbor ferromagnetic Hamiltonian:

$$H = -J \sum_{\langle i,j \rangle} s_i s_j \quad (J = 1)$$

At each step, the Metropolis algorithm evaluates the energy change $\Delta E$ associated with flipping a randomly selected spin:
1. If $\Delta E \le 0$, the spin flip is accepted.
2. If $\Delta E > 0$, the spin flip is accepted with a probability given by the Boltzmann weight: $P = e^{-\Delta E / T}$.

---

## Code Structure

- **`modelo_ising.f90`**: Numerical core written in Fortran 90.
  - Lattice initialization: ordered state (ferromagnetic, all $s=1$) or disordered state (paramagnetic, random spin assignment).
  - Monte Carlo integration with periodic boundary conditions and stochastic updates.
  - Continuous monitoring and export of the average magnetization per spin ($m = \frac{1}{N} \sum s_i$).
  - Periodic snapshots of full spatial lattice configurations for dynamical analysis.
- **`modelo_ising.py`**: Python plotting script.
  - Reads `magnetizacion.txt` and plots the time evolution of the average magnetization $m(t)$ across Monte Carlo steps.
  - Exports the resulting high-resolution figure (`grafico_ising.png`).
- **`modelo_ising2.py`**: Magnetic domain animation module.
  - Parses the lattice states stored in `matriz_configuracion.txt`.
  - Generates an interactive animation using `matplotlib.animation.FuncAnimation` showing real-time nucleation and coalescence of magnetic spin domains.

---

## Compilation & Execution

### 1. Prerequisites
- Fortran compiler (e.g., `gfortran`).
- Python 3.x with libraries: `numpy` and `matplotlib`.

```bash
pip install numpy matplotlib
