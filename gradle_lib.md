# Gradle 

### Overview
* In essence, gradle is not a build tool but an automation tool. Itself doesn't really know how to compile say C++ or Java or Android, its been done with the help of plugins.

### Gradle Android Plugin
* Gradle Android Plugin(gap) is the plugin for gradle to feature an android build. That means a gradle base version is not capable of building an android by its own. Now we update the gap version from 2 to 3. It requires a gradle 4.1 + base. 
* The different between gap 2 and 3 are mainly below:
	* *compile* keyword change to *api*
	* Add new *implement* keyword for those project that is not exposing its dependency
	* *apk* to *runtimeonly*
	* *provide* to *compileOnly*
	* A mandatory Product Flavoring is required
* All above difference somehow improve the **speed** and **robusity** of building which, from what the official docs is said, the main focus of gap 3 release.


