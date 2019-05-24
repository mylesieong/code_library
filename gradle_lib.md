# Gradle 

## Overview
* In essence, gradle is not a build tool but an automation tool. Itself doesn't really know how to compile say C++ or Java or Android, its been done with the help of plugins.
* Plugins in gradle can add custom tasks, new configurations, dependencies, and other capabilities to gradle project.
* For example, in android plugin, applying the android plugin adds a wide variety of tasks, which are configurable on the "android" block in build.gradle script.
* Build cycle:
	- Initialization - scripts in setting.gradle script?
	- Configuration - scripts in build.gradle scripts but not those in tasks execution area?
	- Execution 
* Gradle source code: github.com/gradle

## Gradle Android Plugin (GAP)
* Gradle Android Plugin(gap) is the plugin for gradle to feature an android build. That means a gradle base version is not capable of building an android by its own. Now we update the gap version from 2 to 3. It requires a gradle 4.1 + base. 
* The different between gap 2 and 3 are mainly below:
	* *compile* keyword change to *api*
	* Add new *implement* keyword for those project that is not exposing its dependency
	* *apk* to *runtimeonly*
	* *provide* to *compileOnly*
	* A mandatory Product Flavoring is required
	* Auto-fallback feature is added to Flavoring system
* All above difference somehow improve the **speed** and **robusity** of building which, from what the official docs is said, the main focus of gap 3 release.
* Source code: https://android.googlesource.com/platform/tools/base/+/studio-master-dev/source.md

## Gradle wrapper
* Gradle wrapper is just wrapper that call the real gradle commnad
* In gradle source code: subproject/wrapper

## Variant dependency management
* The feature, to auto match variants when consuming a library, is included by GAP 3.0.0+.
* From consumer module to pass flavor to library, 2 strategies for missing dimension and missing variant:
    - if consumer only has MyDim1, and library has MyDim1 and MyDim2{V1, V2}, consumer uses: `missingDimensionStrategy 'MyDim2', 'V1'`
    - if consumer has MyDim{V1, V2}, and library has MyDim{V3, V4}, consumer uses: `matchingFallbacks [V3]`

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
* Variant = Dmn1(Flvr(i)) * Dmn2(Flvr(j)) * ... 
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

## Life cycle
* Gradle processes a build script in three phases: initialization, configuration, and execution.
* The initialization and configuration phases create and configure project objects and construct a DAG of tasks, which are then executed in the execution phase.

## Gradle DSL Primer
* Gradle DSL is empowered by [groovy closure](http://groovy-lang.org/closures.html). To summary these features:
    - Closure delegate allows closure to use properties defined in delegate object
    - Closure can replace a SAM (single abstrace method)
    - When call a method and the last parm is a closure, syntax allow emit the closure. 
    - When call a method without an empty parenthesis, parenthesis can be omit
    - Groovy allows [optional parenthesis](http://mrhaki.blogspot.com/2009/10/groovy-goodness-optional-parenthesis.html)
    - e.g. to call `Project.dependencies(Closure configureClosure)`, we can use `dependencies { ... }` and in this closure
    - e.g. Above closure can use Project's properties + DependencyHandler's properties. (latter was assign as a delegate by the framework)

## EnvironmentVariable x SystemProperties x ProjectProperties
* There are 3 kinds of properties in gradle's perspective: EnvironmentVariable, SystemProperties and ProjectProperties
|                     | Where to define                               | Can gradle script view              | Can java code view                |
| ------------------- |:---------------------------------------------:| -----------------------------------:| ---------------------------------:|
| EnvironmentVariable | windows                                       | No                                  | Yes w/ `System.getEnv()`          | 
| SystemProperties    | gradle.properties `systemProp.foo.bar=foobar` | Yes w/ `System.properties[foo.bar]` | Yes w/ `System.getProperties()`   |
|                     | command line `-Dfoo.bar=foobar`               |                                     |                                   |
| ProjectProperties   | gradle.properties `foo.bar=foobar`            | Yes w/ `foo.bar`                    | No                                |
|                     | command line `-Pfoo.bar=foobar`               |                                     |                                   |
* Note only root project gradle.properties file can define SystemProperties


