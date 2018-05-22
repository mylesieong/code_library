import java.io.File

val FILE_ROOT = "."

fun list() {
	val markdowns = File(FILE_ROOT).listFiles { file -> !file.isDirectory() && file.getName().endsWith(".md") }
	markdowns?.forEach { m -> println(m) }
}

fun tree() {
	print("Not impl yet")
}

fun help() {
	print("Not impl yet")
}

when (args[0]) {
	"list" -> list()
	"tree" -> tree()
	else -> help()
}
