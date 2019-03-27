fun someOperation(): String {
    return "hello"
}

class Example {
    val p: String by lazy { someOperation() }
}

fun runStringDelegateExample(blackHole: BlackHole) {
    val example = Example()
    blackHole.consume(example.p)
    blackHole.consume(example.p)
}

fun runIsInOneToTenWithLocalRange(a: Int): Boolean {
    return isInOneToTenWithLocalRange(a)
}

fun isInOneToTenWithLocalRange(i: Int) = i in 1..10

fun isInOneToTenWithLocalRangeAndStep1(i: Int) = i in 1..10 step 1

fun runIsInOneToTenWithIndirectRange(a: Int): Boolean {
    return isInOneToTenWithIndirectRange(a)
}

private val myRange get() = 1..10

fun isInOneToTenWithIndirectRange(i: Int) = i in myRange

fun isBetweenNamesWithLocalRange(name: String): Boolean {
    return name in "Alfred".."Alicia"
}

private val NAMES = "Alfred".."Alicia"

fun isBetweenNamesWithConstantRange(name: String): Boolean {
    return name in NAMES
}

fun rangeForEachMethod(blackHole: BlackHole) {
    (1..10).forEach {
        blackHole.consume(it)
    }
}

fun rangeForEachLoop(blackHole: BlackHole) {
    for (it in 1..10) {
        blackHole.consume(it)
    }
}

fun rangeForEachLoopWithStep1(blackHole: BlackHole) {
    for (it in 1..10 step 1) {
        blackHole.consume(it)
    }
}

/**
 * SparseArray fake implementation.
 */
class SparseArray<out T>(val collection: List<T>) {
    fun size() = collection.size
    fun valueAt(index: Int) = collection[index]
}

inline val SparseArray<*>.indices: IntRange
    get() = 0..size() - 1

fun printValuesUsingIndices(map: SparseArray<String>, blackHole: BlackHole) {
    for (i in map.indices) {
        blackHole.consume(map.valueAt(i))
    }
}

inline val SparseArray<*>.lastIndex: Int
    get() = size() - 1

fun printValuesUsingLastIndexRange(map: SparseArray<String>, blackHole: BlackHole) {
    for (i in 0..map.lastIndex) {
        blackHole.consume(map.valueAt(i))
    }
}