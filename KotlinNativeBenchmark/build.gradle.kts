plugins {
    kotlin("multiplatform") version "1.3.30-eap-45"
    kotlin("xcode-compat") version "0.1"
}

repositories {
    mavenCentral()
    maven(url = "https://dl.bintray.com/kotlin/kotlin-eap")
}

kotlin {
    xcode {
        setupFramework("KotlinNativeBenchmark")
    }
}