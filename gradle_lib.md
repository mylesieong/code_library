# Gradle 

## Overview
* In essence, gradle is not a build tool but an automation tool. Itself doesn't really know how to compile say C++ or Java or Android, its been done with the help of plugins.
* Plugins in gradle can add custom tasks, new configurations, dependencies, and other capabilities to gradle project.
* For example, in android plugin, applying the android plugin adds a wide variety of tasks, which are configurable on the "android" block in build.gradle script.
* Build cycle:
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

## Set and check gradle properties
* To check properties, use: `./gradlew properties`
* To set properties, open gradle.properties at the root where you run gradle command and add properties, for example:
```
org.gradle.daemon=true
org.gradle.jvmargs=-Xmx3096m -XX:MaxPermSize=512m -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8
org.gradle.parallel=true
org.gradle.configureondemand=true
```

## Common build errors and solutions
* Identifying and merging files
	- Symptoms: MergeDex Exception / cannot merge jar / duplicated classes/ duplicated classes `*.BuildConfig`
	- Trouble-shoot: (dependencies : gradle clean && gradle build again)
 			-> (cannot delete old jar : kill gradle daemon and build again) 
 			-> (try add multiDexEnable) 

* `!directory.isDirectory()`
	- Symptoms: `!directory.isDirectory()` 
	- trouble-shoot: becaues flavor name is too long so in build/intermediate folder name too long and gradle can't recognize

* Android studio freeze after gradle buiild and before 3 tasks. -> rm .idea -rf && rm \*.iml
        - solution2 : upgrade android studio to 3.5 Canary kind of solve it 
 
* Upgrade support lib to androidX
	* Merge manifest related problem (Manifest merger failed : Attribute application@appComponentFactory from [com.android.support:support-compat:?] AndroidManifest.xml is also present at [androidx.core:core:?] AndroidManifest.xml ... Suggestion: add 'tools:replace="android:appComponentFactory"' to element at AndroidManifest.xml to override.)/ solution: add "android.useAndroidX=true; android.enableJetifier=true" to gradle.properties
	* Above one, can use workaround (its suggestion and assign a random string) 
	* DexArchiveBuilderException: fail to process jetifier-butterknife-runtime.aar / solution: update sourceCompatibility to JDK1_8
	* Butterknife generate class `R2` is using legacy support lib as import (only happend when using butterknife 9 or 10) / solution: add "android.userAndroidX=true; android.enableJetifier=true" to gradle.properties (check butterknife changelog.md)
	* After upgrade to androidX deps we compile with error - attr:ttcIndex (and others) not found, because these new attrs are added after AndroidP / solution:  update to compileSDKVersion28

## RuntimeClasspath vs CompileTimeClasspath
* Sometimes RuntimeClasspath is different from CompileTimeClasspath because gradle needs extra tools at compile time.
* Run `gradle :foobar:dependencies` and you will see the difference
* If there is a version conflict, try to force a version in *build.gradle* with:
```
android {
 ...
 configurations.all {
     resolutionStrategy {
         force 'androidx.legacy:legacy-support-core-utils:1.0.0', 'androidx.loader:loader:1.0.0', 'androidx.core:core:1.0.1',
                 'androidx.versionedparcelable:versionedparcelable:1.0.0', 'androidx.collection:collection:1.0.0',
                 'androidx.lifecycle:lifecycle-runtime:2.0.0', 'androidx.documentfile:documentfile:1.0.0',
                 'androidx.localbroadcastmanager:localbroadcastmanager:1.0.0', 'androidx.print:print:1.0.0',
                 'androidx.lifecycle:lifecycle-common:2.0.0'
     }
 }
}
```

## Variant handling in lifecycle - Configuration
* Variant = Flavors(i)-Dimensions1 x Flavors(j)-Dimensions2 x ... x Flavors(k)-Dimensions(N)
* E.g. V(fullLatestApiSummitDefaultUserId) = D1(full) x D2(LatestApi) x D3(Summit) x D4(DefaultUserId)
* We can handle variant to decide how many different variant to output after configuration stage:
```
ext.disableFlavorsNotUsedForDev = { variant, flavorNames, buildType ->
    if (buildType.equals("release") || flavorNames.contains("androidUidPhone") || !flavorNames.contains("summit")) {
        logger.warn("Removing " + flavorNames + " from project")
        variant.setIgnore(true)
    }
}
```
