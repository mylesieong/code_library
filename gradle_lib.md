# Gradle 

## Overview
* In essence, gradle is not a build tool but an automation tool. Itself doesn't really know how to compile say C++ or Java or Android, its been done with the help of plugins.
* Plugins in gradle can add custom tasks, new configurations, dependencies, and other capabilities to gradle project.
* For example, in android plugin, applying the android plugin adds a wide variety of tasks, which are configurable on the "android" block in build.gradle script.
* Build ccycle:
	- Initialization - scripts in setting.gradle script?
	- Configuration - scripts in build.gradle scripts but not those in tasks execution area?
	- Execution 

## Gradle Android Plugin
* Gradle Android Plugin(gap) is the plugin for gradle to feature an android build. That means a gradle base version is not capable of building an android by its own. Now we update the gap version from 2 to 3. It requires a gradle 4.1 + base. 
* The different between gap 2 and 3 are mainly below:
	* *compile* keyword change to *api*
	* Add new *implement* keyword for those project that is not exposing its dependency
	* *apk* to *runtimeonly*
	* *provide* to *compileOnly*
	* A mandatory Product Flavoring is required
	* Auto-fallback feature is added to Flavoring system
* All above difference somehow improve the **speed** and **robusity** of building which, from what the official docs is said, the main focus of gap 3 release.
* Gradle wrapper is just wrapper that call the real gradle commnad

## Common-used command
* Build a project: `./gradlew :my-project-name:assemble`    //ps. this will build all flavor
* List tasks under a certain project: `./gradlew : my-project-name:tasks`
