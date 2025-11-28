allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    
    // Apenas o módulo app depende do Flutter, não o módulo wear
    if (project.name != "wear") {
        afterEvaluate {
            try {
                project.evaluationDependsOn(":app")
            } catch (e: Exception) {
                // Ignora se o módulo app não estiver disponível
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
