package com.example.proyect_pm.ui.theme

fun main() {
    val numeros = mutableListOf<Int>()

    while (true) {
        println("\n--- Taller de Operaciones con Listas ---")
        println("1. Agregar número")
        println("2. Calcular suma")
        println("3. Calcular promedio")
        println("4. Encontrar números pares")
        println("5. Elevar al cuadrado")
        println("6. Salir")
        print("Selecciona una opción: ")

        val opcion = readLine()

        when (opcion) {
            "1" -> {
                print("Ingresa un número: ")
                val numero = readLine()?.toIntOrNull()
                if (numero != null) {
                    numeros.add(numero)
                    println("$numero fue agregado a la lista.")
                } else {
                    println("Número no válido, inténtalo de nuevo.")
                }
            }
            "2" -> {
                val suma = numeros.sum()
                println("La suma de los números en la lista es: $suma")
            }
            "3" -> {
                val promedio = numeros.average()
                println("El promedio de los números en la lista es: $promedio")
            }
            "4" -> {
                val numerosPares = numeros.filter { it % 2 == 0 }
                println("Números pares en la lista: $numerosPares")
            }
            "5" -> {
                val numerosCuadrados = numeros.map { it * it }
                println("Números elevados al cuadrado: $numerosCuadrados")
            }
            "6" -> {
                println("¡Hasta luego!")
                return
            }
            else -> {
                println("Opción no válida, por favor selecciona una opción válida.")
            }
        }
    }
}
