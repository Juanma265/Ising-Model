import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

def leer_evolucion(filename, L):
    snapshots = []
    numeros_acumulados = []
    
    with open(filename, 'r') as f:
        for line in f:
            line = line.strip()
            if not line: continue
            
            if line.startswith("SIGUIENTE"):
                # Si ya teníamos números guardados del snapshot anterior, los procesamos
                if len(numeros_acumulados) == L * L:
                    grid = np.array(numeros_acumulados).reshape(L, L)
                    snapshots.append(grid)
                
                numeros_acumulados = [] # Limpiar para el siguiente
                continue
            
            try:
                valores = [int(x) for x in line.split()]
                numeros_acumulados.extend(valores)
            except ValueError:
                continue 
                
        if len(numeros_acumulados) == L * L:
            snapshots.append(np.array(numeros_acumulados).reshape(L, L))
            
    return snapshots

L = 50
archivo = "matriz_configuracion.txt"

snapshots = leer_evolucion(archivo, L)

fig, ax = plt.subplots(figsize=(10,10))
im = ax.imshow(snapshots[0], cmap='binary', interpolation='nearest')
ax.set_axis_off()

def update(frame):
   im.set_data(snapshots[frame])
   return [im]

ani = FuncAnimation(fig,update,frames=len(snapshots), interval=100, blit=True)
plt.show()