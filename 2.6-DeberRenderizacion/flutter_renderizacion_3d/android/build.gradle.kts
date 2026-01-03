allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {

    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    afterEvaluate {

        // 🔧 Fix específico para ar_flutter_plugin
        if (project.name == "ar_flutter_plugin") {

            // Namespace requerido por AGP moderno
            extensions.findByName("android")?.let { androidExt ->
                try {
                    val method = androidExt.javaClass.getMethod(
                        "setNamespace",
                        String::class.java
                    )
                    method.invoke(androidExt, "io.carius.lars.ar_flutter_plugin")
                    println("✔ Namespace set for ar_flutter_plugin")
                } catch (e: Exception) {
                    println("⚠ Namespace already set or not required")
                }
            }

            // Kotlin legacy compatible
            tasks.withType(
                org.jetbrains.kotlin.gradle.tasks.KotlinCompile::class.java
            ).configureEach {
                kotlinOptions {
                    jvmTarget = "1.8"
                }
            }
        }
    }
}

subprojects {
    evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
