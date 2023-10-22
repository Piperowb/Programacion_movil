fun main() {
    println("¡Bienvenido al Conversor de Monedas!")
    println("Selecciona una opción:")
    println("1. Dólares a Euros")
    println("2. Euros a Dólares")
    println("3. Libras a Dólares")
    println("4. Dólares a Libras")
    print("Ingresa el número de la opción deseada (1/2/3/4): ")

    val opcion = readLine()

    when (opcion) {
        "1" -> convertirDolaresAEuros()
        "2" -> convertirEurosADolares()
        "3" -> convertirLibrasADolares()
        "4" -> convertirDolaresALibras()
        else -> println("Opción no válida, por favor selecciona una de las opciones disponibles.")
    }
}

fun convertirDolaresAEuros() {
    print("Ingresa la cantidad en Dólares: $")
    val cantidadDolares = readLine()?.toDoubleOrNull()
    if (cantidadDolares == null) {
        println("Cantidad no válida, por favor ingresa un número válido.")
        return
    }

    val tasaCambio = 0.85 // Tasa de cambio actual de Dólares a Euros
    val cantidadEuros = cantidadDolares * tasaCambio
    println("$${cantidadDolares} USD es igual a ${cantidadEuros} EUR")
}

fun convertirEurosADolares() {
    print("Ingresa la cantidad en Euros: €")
    val cantidadEuros = readLine()?.toDoubleOrNull()
    if (cantidadEuros == null) {
        println("Cantidad no válida, por favor ingresa un número válido.")
        return
    }

    val tasaCambio = 1.18 // Tasa de cambio actual de Euros a Dólares
    val cantidadDolares = cantidadEuros * tasaCambio
    println("${cantidadEuros} EUR es igual a $${cantidadDolares} USD")
}

fun convertirLibrasADolares() {
    print("Ingresa la cantidad en Libras: £")
    val cantidadLibras = readLine()?.toDoubleOrNull()
    if (cantidadLibras == null) {
        println("Cantidad no válida, por favor ingresa un número válido.")
        return
    }

    val tasaCambio = 1.38 // Tasa de cambio actual de Libras a Dólares
    val cantidadDolares = cantidadLibras * tasaCambio
    println("£${cantidadLibras} GBP es igual a $${cantidadDolares} USD")
}

fun convertirDolaresALibras() {
    print("Ingresa la cantidad en Dólares: $")
    val cantidadDolares = readLine()?.toDoubleOrNull()
    if (cantidadDolares == null) {
        println("Cantidad no válida, por favor ingresa un número válido.")
        return
    }

    val tasaCambio = 0.72 // Tasa de cambio actual de Dólares a Libras
    val cantidadLibras = cantidadDolares * tasaCambio
    println("$${cantidadDolares} USD es igual a £${cantidadLibras} GBP")
}
