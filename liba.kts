import java.io.File

enum class MarkdownSyntaxType {
	HEAD_POUND,
	HEAD_POUNDPOUND,
	OTHERS
}

val FILE_ROOT = "."

when (args[0]) {
	"list" -> list()
	"tree" -> handleTree(args[1])
	else -> {}
}

fun list() {
	val markdowns = File(FILE_ROOT).listFiles { file -> !file.isDirectory() && file.getName().endsWith(".md") }
	markdowns?.forEach { m -> println(m) }
}

fun handleTree(r: String) {
	File(r).readLines().forEach {
		when (getMarkdownSyntaxType(it)) {
			MarkdownSyntaxType.HEAD_POUND -> println(it)
			MarkdownSyntaxType.HEAD_POUNDPOUND -> println("\t" + it)
			MarkdownSyntaxType.OTHERS -> {}
		}
	}
}

fun getMarkdownSyntaxType(line: String) : MarkdownSyntaxType {
	if (line.matches(Regex("^#[ A-Za-z0-9].*"))) return MarkdownSyntaxType.HEAD_POUND
	else if (line.matches(Regex("^##[ A-Za-z0-9].*"))) return MarkdownSyntaxType.HEAD_POUNDPOUND
	else return MarkdownSyntaxType.OTHERS
}