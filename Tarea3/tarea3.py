"""
Tarea 3: Algoritmos genéticos.
Clase: Inteligencia artificial.
Profesores: Manuel Cristóbal López Michelone, Yessica martínez Reyes y César Hernández Solís
Alumno: Javier Alejandro Rivera Zavala-311288876
"""
import random

# Productos a cargar en la mochila, en este caso son frutas. Sólo tomamos una de cada una.
productos = {
    "Uva": {"peso": 10, "valor": 60},
    "Manzana": {"peso": 20, "valor": 75},
    "Naranja": {"peso": 30, "valor": 90},
    "Toronja": {"peso": 40, "valor": 100},
    "Papaya": {"peso": 50, "valor": 120},
    "Melon": {"peso": 60, "valor": 130},
    "Sandia": {"peso": 70, "valor": 140}
}
peso_maximo = 250  # Capacidad máxima de la mochila

#Parámetros del algoritmo genético
tamano_poblacion = 30 #30 individuos como se nos pidio.
probabilidad_mutacion = 0.01
num_generaciones = 300

# Función para inicializar la población inicial de forma aleatoria.
def inicializar_poblacion(tamano_poblacion):
    poblacion = []
    for _ in range(tamano_poblacion):
        individuo = [random.randint(0, 1) for _ in range(len(productos))]
        poblacion.append(individuo)
    return poblacion

# Función para calcular el fitness de un individuo (suma de valores si no se supera el peso máximo).
def calcular_fitness(individuo):
    peso_total = sum(productos[nombre]["peso"] * gen for nombre, gen in zip(productos.keys(), individuo))
    valor_total = sum(productos[nombre]["valor"] * gen for nombre, gen in zip(productos.keys(), individuo))
    if peso_total > peso_maximo:
        return 0
    else:
        return valor_total

# Función para seleccionar individuos para la reproducción basada en la ruleta.
def selecion_natural(poblacion):
    suma_fitness = sum(calcular_fitness(individuo) for individuo in poblacion)
    ruleta = [calcular_fitness(individuo) / suma_fitness for individuo in poblacion]
    seleccionados = random.choices(poblacion, weights=ruleta, k=2)
    return seleccionados

# Función para realizar la cruza de dos individuos.
def cruzar(padre1, padre2):
    punto_cruza = random.randint(1, len(padre1) - 1)
    hijo1 = padre1[:punto_cruza] + padre2[punto_cruza:]
    hijo2 = padre2[:punto_cruza] + padre1[punto_cruza:]
    return hijo1, hijo2

# Función para introducir un cambio en los genes de un individuo.
def mutar(individuo):
    for i in range(len(individuo)):
        if random.random() < probabilidad_mutacion:
            individuo[i] = 1 - individuo[i]  # Cambiar de 0 a 1 o de 1 a 0 aleatoriamente
    return individuo

# Algoritmo genético en operación, seleccionamos a los más aptos para reproducirse.
def algoritmo_genetico():
    poblacion = inicializar_poblacion(tamano_poblacion)
    for _ in range(num_generaciones):
        nueva_poblacion = []
        for _ in range(tamano_poblacion // 2):
            padre1, padre2 = selecion_natural(poblacion)
            hijo1, hijo2 = cruzar(padre1, padre2)
            hijo1 = mutar(hijo1)
            hijo2 = mutar(hijo2)
            nueva_poblacion.extend([hijo1, hijo2])
        poblacion = nueva_poblacion
    mejor_individuo = max(poblacion, key=calcular_fitness)
    productos_elegidos = [nombre for nombre, gen in zip(productos.keys(), mejor_individuo) if gen == 1]
    peso_acumulado = sum(productos[nombre]["peso"] for nombre in productos_elegidos)
    return mejor_individuo, productos_elegidos, peso_acumulado


mejor_individuo, productos_elegidos, peso_acumulado = algoritmo_genetico()
print("Mejor individuo:", mejor_individuo)
print("Productos seleccionados en la mejor solución:", productos_elegidos)
print("Peso total de los productos seleccionados:", peso_acumulado)