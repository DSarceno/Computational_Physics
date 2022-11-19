#    2020-01-30
#    dice.py
#    Giovanni Ramirez (ramirez@ecfm.usac.edu.gt)

#    Calcula el valor promedio de N lanzamientos de un dado de 6 caras

#    Codificacion del texto: ASCII
#    Interpretes probados: Python 3.6.10
#    Requiere modulo random

#    Copyright (C) 2020
#    A. G. Ramirez Garcia
#    ramirez@ecfm.usac.edu.gt
#
#    This program is free software: you can redistribute it and/or
#    modify it under the terms of the GNU General Public License as
#    published by the Free Software Foundation, either version 3 of
#    the License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#    General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see
#    <http://www.gnu.org/licenses/>.
#


# ######################
# PRIMERA PARTE
# ######################


# 1. Inicio

# 2. Leer el numero de lanzamientos, $N$

# 3. Valores iniciales para la suma y para el contador, $S=0$, $k=1$

# 4. Generar un numero aleatorio, $r \in [1,6]$ 

# 5. Actualizar los valores, $S=S+r$, $k=k+1$

# 6. Evaluar condicion de parada, si $k=N$ entonces pasar a 7, si no pasar a 4

# 7. Imprimir el promedio, $S/N$

# 8. Fin




















# ######################
# SEGUNDA PARTE
# ######################


# 1. Inicio
import random

# 2. Leer el numero de lanzamientos, $N$
N=1

# 3. Valores iniciales para la suma y para el contador, $S=0$, $k=1$
S=0

for k in range(N):
# 4. Generar un numero aleatorio, $r \in [1,6]$ 
    r=random.randint(1,6)

# 5. Actualizar los valores, $S=S+r$, $k=k+1$
    S+=r

# 6. Evaluar condicion de parada, si $k=N$ entonces pasar a 7, si no pasar a 4

# 7. Imprimir el promedio, $S/N$
#print (N, S/N)

# 8. Fin




















# ######################
# TERCERA PARTE
# ######################


def roll(N):
# 1. Validar entradas
    if "random" not in dir():
        import random
    if N<1 :
        return None
    
# 3. Valores iniciales
    S=0

    for k in range(N):
# 4. Generar un numero aleatorio, $r \in [1,6]$ 
        r=random.randint(1,6)

# 5. Actualizar los valores, $S=S+r$, $k=k+1$
        S+=r

# 7. Devolver el promedio, $S/N$
    return S/N
# 8. Fin

M=100
a=roll(M)
print (M, a)
