# Standard function
* They are run, with, T.run, T.let, T.also and T.apply.
* Read this [article](https://medium.com/@elye.project/mastering-kotlin-standard-functions-run-with-let-also-and-apply-9cd334b0ef84) for more

# DSL in kotlin
* DSL programming became possible when kotlin enable lambda + closure
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
