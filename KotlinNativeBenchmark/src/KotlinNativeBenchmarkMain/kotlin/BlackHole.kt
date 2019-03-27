class BlackHole {

    private var obj: String? = null
    private var iter: Int = 0

    fun consume(any: String) {
        iter += if (this.obj == any) 1 else 0
        obj = any
    }

    fun consume(value: Int) {
        iter += if (value % 2 == 0) 1 else 0
    }
}