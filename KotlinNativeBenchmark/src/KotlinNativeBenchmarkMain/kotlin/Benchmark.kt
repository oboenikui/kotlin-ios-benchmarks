fun run() {

    // Part 1

    BenchmarkHelper.run("Kotlin Part1 empty") {
        runEmpty()
    }

//    val db = KotlinDatabase()
//    BenchmarkHelper.run("Kotlin Part1 lambda") {
//        runKotlinLambda(db)
//    }
//
//    BenchmarkHelper.run("Kotlin Part1 inline function") {
//        runKotlinInlinedFunction(db)
//    }
//
//    BenchmarkHelper.run("Kotlin Part1 Companion object call to private constructor") {
//        runCompanionObjectCallToPrivateConstructor()
//    }
//
//    // Part 2
//
//    val testSuite = BenchmarkHelper.newTestSuite()
//    val blackHole = BenchmarkHelper.newBlackHole()
//
//    BenchmarkHelper.run("Kotlin Part2 Local function capturing local variable") {
//        runLocalFunctionCapturingLocalVariable(testSuite.a)
//    }
//
//    BenchmarkHelper.run("Kotlin Part2 Local function without capturing local variable") {
//        runLocalFunctionWithoutCapturingLocalVariable(testSuite.a)
//    }
//
//    BenchmarkHelper.run("Kotlin Part2 Null check cost") {
//        runNullCheckCost(testSuite.who)
//    }
//
//    BenchmarkHelper.run("Kotlin Part2 Vararg spread cost") {
//        runPrintDouble(blackHole, testSuite.intArray)
//    }
//
//    BenchmarkHelper.run("Kotlin Part2 Usual IntArray") {
//        runPrintDoubleWithoutVararg(blackHole, testSuite.intArray)
//    }
//
//    // Part 3
//
//    BenchmarkHelper.run("Kotlin Part3 String delegate") {
//        runStringDelegateExample(blackHole)
//    }
//
//    BenchmarkHelper.run("Kotlin Part3 Is in 1..10 (local)") {
//        runIsInOneToTenWithLocalRange(testSuite.a)
//    }
//
//    BenchmarkHelper.run("Kotlin Part3 Is in 1..10 (indirect)") {
//        runIsInOneToTenWithIndirectRange(testSuite.a)
//    }
//
//    BenchmarkHelper.run("Kotlin Part3 Is in Alfred..Alicia (local)") {
//        isBetweenNamesWithLocalRange(testSuite.who)
//    }
//
//    BenchmarkHelper.run("Kotlin Part3 Is in Alfred..Alicia (constant)") {
//        isBetweenNamesWithConstantRange(testSuite.who)
//    }
//
//    BenchmarkHelper.run("Kotlin Part3 Range forEach method") {
//        rangeForEachMethod(blackHole)
//    }
//
//    BenchmarkHelper.run("Kotlin Part3 Range for in loop") {
//        rangeForEachLoop(blackHole)
//    }
//
//    BenchmarkHelper.run("Kotlin Part3 Range for in loop with step 1") {
//        rangeForEachLoopWithStep1(blackHole)
//    }
//
//    BenchmarkHelper.run("Kotlin Part3 Print value using indices") {
//        printValuesUsingIndices(testSuite.sparseArray, blackHole)
//    }
//
//    BenchmarkHelper.run("Kotlin Part3 Print value using last index range") {
//        printValuesUsingLastIndexRange(testSuite.sparseArray, blackHole)
//    }
}