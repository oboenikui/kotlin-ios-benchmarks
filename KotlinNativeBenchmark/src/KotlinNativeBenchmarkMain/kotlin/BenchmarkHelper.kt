import kotlin.*
import kotlin.native.concurrent.*
import kotlinx.cinterop.*
import kotlin.system.*
import platform.posix.clock_gettime_nsec_np
import platform.posix.CLOCK_REALTIME
import kotlin.random.Random
import kotlin.math.pow
import kotlin.math.sqrt


internal object BenchmarkHelper {

    enum class Mode {
        Throughput, SingleShortTime
    }

    private const val ITERATE_COUNT = 5_000_000


    inline fun run(label: String, mode: Mode = BenchmarkHelper.Mode.SingleShortTime, closure: () -> Any) {println("Start $label")
        println("# Warmup")
        iterate(mode, closure)
    }

    private inline fun iterate(mode: Mode, closure: () -> Any) {
        var iterateCount = ITERATE_COUNT
        for (i in 0 until 10) {
            val result = when (mode) {
                BenchmarkHelper.Mode.Throughput -> calculateThroughput(closure) / 1000.0
                BenchmarkHelper.Mode.SingleShortTime -> iterateCount.toDouble() * 1_000_000 / calculateShortTime(iterateCount, closure)
            }
            println("# Warmup Iteration $i: $result ops/ms")
            if (mode == BenchmarkHelper.Mode.SingleShortTime && result < 1000) {
                iterateCount = ITERATE_COUNT / 10
            }
        }
        val results: MutableList<Double> = mutableListOf()
        for (i in 0 until 10) {
            val result = when (mode) {
                BenchmarkHelper.Mode.Throughput -> calculateThroughput(closure) / 1000.0
                BenchmarkHelper.Mode.SingleShortTime -> iterateCount.toDouble() * 1_000_000 / calculateShortTime(iterateCount, closure)
            }
            results.add(result)
            println("Iteration $i: $result ops/ms")
        }
        summary(results)
    }

    private inline fun calculateShortTime(iterateCount: Int, closure: () -> Any): Long {
        var count: Long = 0
        val start = clock_gettime_nsec_np(CLOCK_REALTIME)
        while (count < iterateCount) {
            count += 1
            closure()
        }
        return (clock_gettime_nsec_np(CLOCK_REALTIME) - start).toLong()
    }

    private inline fun calculateThroughput(closure: () -> Any): Long {
        var count: Long = 0
        val start = clock_gettime_nsec_np(CLOCK_REALTIME)
        while (true) {
            closure()
            if (clock_gettime_nsec_np(CLOCK_REALTIME) - start > 1_000_000_000L.toUInt()) {
                break
            }
            count += 1
        }
        return count
    }

    private inline fun summary(results: List<Double>) {
        var sum: Double = 0.0
        var max: Double = 0.0
        var min: Double = 0x7fffffff.toDouble()

        for (result in results) {
            if (result > max) {
                max = result
            } else if (result < min) {
                min = result
            }
            sum += result
        }
        val avg = sum / results.size

        var powSum: Double = 0.0
        for (result in results) {
            powSum += (result - avg).pow(2)
        }
        val stdev = sqrt(powSum / (results.size - 1))
        println("Statistics: (min, avg, max) = ($min, $avg, $max), stdev = $stdev")
    }

    fun newTestSuite() = TestSuite(
            10,
            "John",
            intArrayOf(5, 0, 3, -1, -6, 7, -7, 4),
            SparseArray(listOf("A", "B", "Hi", "ZZ", "FFF"))
    )

    fun newBlackHole() = BlackHole()
}

class TestSuite(
        val a: Int,
        val who: String,
        val intArray: IntArray,
        val sparseArray: SparseArray<String>
)