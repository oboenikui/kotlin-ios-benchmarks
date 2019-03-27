fun runLocalFunctionCapturingLocalVariable(a: Int): Int {
    return someMath(a)
}

fun runLocalFunctionWithoutCapturingLocalVariable(a: Int): Int {
    return someMath2(a)
}

fun someMath(a: Int): Int {
    fun sumSquare(b: Int) = (a + b) * (a + b)

    return sumSquare(1) + sumSquare(2)
}

fun someMath2(a: Int): Int {
    fun sumSquare(a: Int, b: Int) = (a + b) * (a + b)

    return sumSquare(a, 1) + sumSquare(a, 2)
}

fun runNullCheckCost(who: String) = who.length

fun runPrintDouble(blackHole: BlackHole, values: IntArray) {
    printDouble(blackHole, *values)
}

fun runPrintDoubleWithoutVararg(blackHole: BlackHole, values: IntArray) {
    printDouble2(blackHole, values)
}

fun printDouble(blackHole: BlackHole, vararg values: Int) {
    for (value in values) {
        blackHole.consume(value)
    }
}

fun printDouble2(blackHole: BlackHole, values: IntArray) {
    for (value in values) {
        blackHole.consume(value)
    }
}
