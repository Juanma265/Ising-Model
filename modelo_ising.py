import numpy as np
import matplotlib.pyplot as plt


data = np.loadtxt('magnetizacion.txt')

tiempo = data[:, 0]
magnetizacion = data[:, 1]
        

plt.figure(figsize=(10, 6))
plt.plot(tiempo, magnetizacion, color='blue', linestyle='-', linewidth=1, label='Magnetización $m$')

plt.title('Evolución de la Magnetización en el Modelo de Ising', fontsize=14)
plt.xlabel('Tiempo / Pasos de Monte Carlo', fontsize=12)
plt.ylabel('Magnetización promedio $m$', fontsize=12)
plt.grid(True, linestyle='--', alpha=0.6) # Cuadrícula
plt.axhline(0, color='black', linewidth=0.8, alpha=0.5) # Línea en el cero
plt.legend()
plt.tight_layout()
plt.savefig('grafico_ising.png', dpi=300)
plt.show()
