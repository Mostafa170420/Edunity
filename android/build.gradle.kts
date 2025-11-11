allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// File: <project-root>/build.gradle (or settings.gradle if using the pluginManagement approach)

// For recent versions of Gradle (typically for the Project-Level file)
buildscript {
    repositories {
        // Make sure you have Google's Maven repository here
        google() 
        mavenCentral()
    }
    dependencies {
        // This is the CRITICAL line
        classpath("com.google.gms:google-services:4.4.1")
    }
}
