fun runEmpty() {}

fun runKotlinLambda(db: KotlinDatabase): Int {
    val deletedRows = transaction(db) {
        it.delete("Customers", null, null)
    }

    return deletedRows
}

fun runKotlinInlinedFunction(db: KotlinDatabase): Int {
    val deletedRows = inlineTransaction(db) {
        it.delete("Customers", null, null)
    }

    return deletedRows
}

fun transaction(db: KotlinDatabase, body: ((KotlinDatabase) -> Int)?): Int {
    db.beginTransaction()
    return body ?.let {
        try {
            val result = it(db)
            db.setTransactionSuccessful()
            result
        } finally {
            db.endTransaction()
        }
    } ?: -1
}

inline fun inlineTransaction(db: KotlinDatabase, body: (KotlinDatabase) -> Int): Int {
    db.beginTransaction()
    try {
        val result = body(db)
        db.setTransactionSuccessful()
        return result
    } finally {
        db.endTransaction()
    }
}

fun runCompanionObjectCallToPrivateConstructor(): String {
    val myClass = MyClass.newInstance()
    return myClass.helloWorld()
}

class MyClass private constructor() {

    companion object {
        private const val TAG = "TAG"

        fun newInstance() = MyClass()
    }

    fun helloWorld() = TAG
}