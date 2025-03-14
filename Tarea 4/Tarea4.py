"""
Tarea 4 y final - Algoritmo genético sobre el problema de Dawkins.

Curso de Inteligencia Artificial, semestre 2024-2

Profesores: Manuel Cristóbal López Michelone, Yessica Martínez Reyes y César Hernández Solís

El presente programa se ejecuta mediante el comando "python Tarea4.py" posicionándose desde la terminal
en el directorio donde se encuentre almacenado el script.

El programa toma desde la terminal la cadena a replicar, después, genera aleatoriamente una cadena de la misma
longitud que la cadena de entrada. Aplicará el algoritmo genético tantas veces como haga falta hasta obtener
la misma cadena que la de entrada.

--Sólo se aceptan cadenas formadas por los caracteres del alfabeto inglés en minúsculas.--

La cadena que utilizó como ejemplo el profesor "me thinks it is like a weasel", se obtuvo después de 185, 231 y 327
generaciones, en 3 iteraciones distintas. Se adjuntan capturas de lo antes mencionado.

"""

import random

# Definir los parámetros del algoritmo genético
POBLACION_TAMANO = 100
INDICE_MUTACION = 0.01
ALFABETO = "abcdefghijklmnopqrstuvwxyz "

# Función para crear una cadena aleatoria de una longitud dada
def generador_cadena(length):
    return ''.join(random.choice(ALFABETO) for _ in range(length))

# Función de aptitud: cuenta el número de caracteres correctos en la posición correcta
def fitness(cadena, objetivo):
    return sum(1 for correcto, caracter in zip(objetivo, cadena) if correcto == caracter)

# Función de selección: selecciona al individuo más apto de una población (o uno aleatorio de ellos si hay varios)
def seleccion_natural(poblacion, aptitudes):
    max_aptitudes = max(aptitudes)
    indices_aptos = [i for i, f in enumerate(aptitudes) if f == max_aptitudes]
    indice_elegido = random.choice(indices_aptos)
    return poblacion[indice_elegido]


# Función de cruce: combina dos padres para crear un hijo
def cruza(ancestro1, ancestro2):
    delimitador = random.randint(0, len(ancestro1) - 1)
    hijo= ancestro1[:delimitador] + ancestro2[delimitador:]    
    return hijo

# Función de mutación: muta una cadena con una cierta tasa de mutación
def mutador(individuo):
    individuo_mut = list(individuo)
    for i in range(len(individuo_mut)):
        if random.random() < INDICE_MUTACION:
            individuo_mut[i] = random.choice(ALFABETO)
    return ''.join(individuo_mut)

def main():
    # Obtener la cadena objetivo desde la terminal
    CADENA_OBJETIVO = input("Por favor, ingresa la cadena objetivo: ")

    # Crear la población inicial
    poblacion = [generador_cadena(len(CADENA_OBJETIVO)) for _ in range(POBLACION_TAMANO)]

   # Inicializar variables de control
    generacion = 0
    individuo_alfa = ""

    # Ejecutar el algoritmo genético mientras sea necesario
    while True:
        # Calcular la aptitud de la población
        aptitudes = [fitness(individuo, CADENA_OBJETIVO) for individuo in poblacion]

        # Verificar si hemos encontrado la cadena objetivo
        if CADENA_OBJETIVO in poblacion:
            print(f"Se consiguió el objetivo en la generacion: {generacion}")
            resultado = poblacion[aptitudes.index(max(aptitudes))]
            print(f"Se generó la cadena: {resultado}")
            break

        # Crear una nueva población
        nueva_poblacion = []
        for _ in range(POBLACION_TAMANO // 2):
            # Seleccionar padres
            ancestro1 = seleccion_natural(poblacion, aptitudes)
            ancestro2 = seleccion_natural(poblacion, aptitudes)
            # Generar hijo por cruce
            nuevo_hijo = cruza(ancestro1, ancestro2)
            # Mutar hijo
            nuevo_hijo = mutador(nuevo_hijo)            
            # Añadir hijo a la nueva población
            nueva_poblacion.extend([nuevo_hijo])
        
        # Añadir al nuevo individuo y ordenar la población con base en sus aptitudes
        poblacion = nueva_poblacion
        poblacion_ordenada = [x for _, x in sorted(zip(aptitudes, poblacion), reverse=True)]
        aptitudes_ordenadas = sorted(aptitudes, reverse=True)

        # Seleccionar los 100 mejores individuos
        poblacion = poblacion_ordenada[:POBLACION_TAMANO]
        aptitudes = aptitudes_ordenadas[:POBLACION_TAMANO]

        # Mostrar progreso
        mejor_aptitud = max(aptitudes)
        individuo_alfa = poblacion[aptitudes.index(mejor_aptitud)]
        print(f"Generacion {generacion}: Mejor indice de aptitud = {mejor_aptitud}, Mejor individuo = '{individuo_alfa}'")
        
        generacion += 1

    # Imprimir la cantidad de generaciones necesarias
    print(f"Tomó: {generacion} generaciones.")

if __name__ == "__main__":
    main()