package com.example.proyect_pm

fun main() {
    println("Calculadora")
    println("1. Sumar")
    println("2. Restar")
    println("3. Multiplicar")
    println("4. Dividir")
    print("Elige una operación (1/2/3/4): ")

    val operacion = readLine()
    if (operacion != null) {
        when (operacion) {
            "1" -> hacerSuma()
            "2" -> hacerResta()
            "3" -> hacerMultiplicacion()
            "4" -> hacerDivision()
            else -> println("Operación no válida")
        }
    } else {
        println("Introduce algo valido")
    }
}

fun hacerSuma() {
    print("Dame el primer número: ")
    val num1 = readLine()?.toDoubleOrNull()
    if (num1 == null) {
        println("Número incorrecto,")
        return
    }

    print("Dame el segundo número: ")
    val num2 = readLine()?.toDoubleOrNull()
    if (num2 == null) {
        println("Número incorrecto")
        return
    }

    val resultado = num1 + num2
    println("El resultado es: $resultado")
}

fun hacerResta() {
    print("Dame el primer número: ")
    val num1 = readLine()?.toDoubleOrNull()
    if (num1 == null) {
        println("Numero no permitido")
        return
    }

    print("Dame el segundo número: ")
    val num2 = readLine()?.toDoubleOrNull()
    if (num2 == null) {
        println("Numero no permitido")
        return
    }

    val resultado = num1 - num2
    println("El resultado es: $resultado, fácil, ¿no?")
}

fun hacerMultiplicacion() {
    print("Dame el primer número: ")
    val num1 = readLine()?.toDoubleOrNull()
    if (num1 == null) {
        println("¿Numero no permitido")
        return
    }

    print("Dame el segundo número: ")
    val num2 = readLine()?.toDoubleOrNull()
    if (num2 == null) {
        println("Numero no permitido")
        return
    }

    val resultado = num1 * num2
    println("El resultado es: $resultado")
}

fun hacerDivision() {
    print("Dame el dividendo: ")
    val num1 = readLine()?.toDoubleOrNull()
    if (num1 == null) {
        println("Numero no permitido")
        return
    }

    print("Dame el divisor: ")
    val num2 = readLine()?.toDoubleOrNull()
    if (num2 == null || num2 == 0.0) {
        println("División entre cero o número incorrecto")
        return
    }

    val resultado = num1 / num2
    println("El resultado es: $resultado")
}
