# Handy shit 
* List comprehensions like python: `barList = [ e*e  for e in fooList if e % 2 == 0 ]` to `barList = fooList.filter { it % 2 == 0 }.map { it * it }`
* Inline if else: `groupChatManager.createGroupChat(if (shouldGenerateSubject) generateRandomSubject() else "", "", phones)`
* Lift assignment out of if: `if () { a = b }` to `a = if () b`
* Replace signle method interface with lambda {}
* when clause + return
* null check
* std functions
* inline function remove all chars like (),{}
* Properties access syntax: for get methods, you can access it like a member `foo.getBar()` to `foo.bar`
* Class constructor like `class Recipe(var n: String, var s: Array<String> , var d: Int = 0) { ... }` let us:
	* Save our time to declare vars
	* Set default value 
* Extension function to whatever class: `fun String.findRegex(r: Regex, strIdx: Int = 0): MatchResult? = r.find(this, strIdx)`

# Idiomatic Kotlin
* What does it mean?
* [Idiomatic Kotlin Best Practice](https://blog.philipphauer.de/idiomatic-kotlin-best-practices)


# Standard function
* They are run, with, T.run, T.let, T.also and T.apply.
* Read this [article](https://medium.com/@elye.project/mastering-kotlin-standard-functions-run-with-let-also-and-apply-9cd334b0ef84) for more
* These functions are just functions, not part of language feature, and it is the same behavior between `myHigherOrderFunc(myLambda)` <=> `myHigherOrderFunc { myLambda }` make them looks like part of the language
* Behavior:

| Function | Identifier | Return value |
| ------------- |:-------------:| -----:|
| let | it | last line of literal |
| run | this | last line of literal |
| also | it | this |
| apply | this | this |


# Create DSL in kotlin
* DSL programming became possible when kotlin enable lambda + closure 
* Mainly because single method interface usage can be call like `foo.bar(object: xxxx)` or `foo.bar { }`
* Read from [KotlinConf 2018](https://www.youtube.com/watch?v=Rvx_BfG3NDo&index=4&list=PLQ176FUIyIUbVvFMqDc2jhxS-t562uytr)
* DSL somehow has a connection with Builder pattern
```kotlin
alert( title { //DSL starts
	message = "Foo bar"
	positiveButton("Foo"){
		exit()
	}
	negativeButton("Bar"){
		Log.d("message...")
	}
}).show()
```
```java
AlertDialog.Builder(context)
	.setTitle()
	.setMessage()
	.setPositiveBitton(){}
	.setNegativeButton(){}
	.create()
	.show()
```
* Html string assembling example:
```kotlin
fun assembleHtmlString (args: Array<String>) =
	html { //DSL starts
		head {
			title { +"foobar"}
		}
		body {
			h1 { +"foobar"}
			a(href="foobar") {+"foobar"}
			p {
				+"foobar"
				b {+"foobar"}
			}
			p {
				for (a in args)
					+arg
			}
		}
	}
```
```kotlin
//Under the hook
fun html(init:HTML.() -> Unit): HTML {
	val html = HTML()
	html.init()
	return html
}
fun HTML.head(init:Head.() -> Unit): Head {
	val head = Head()
	head.init()
	children.add(head)
	return head
}
fun HTML.body(init:Body.() -> Unit): Body {
	val body = Body()
	body.init()
	children.add(body)
	return body
}
```

# Anko 
* A kotlin mega library that aims to make wrapper things nicer.

# List in kotlin
* By default, it is immutable, so remove/add operation will not compile
* Cast to MutableList/MutableCollection
