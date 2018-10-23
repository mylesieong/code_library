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

fun handleTree(r: String){
	File(r).readLines().forEach { pickHeadersAndPrint(it) }
}

fun pickHeadersAndPrint(line: String) {
	when (getMarkdownSyntaxType(line)){
		MarkdownSyntaxType.HEAD_POUND -> println(line)
		MarkdownSyntaxType.HEAD_POUNDPOUND -> println("\t" + line)
		MarkdownSyntaxType.OTHERS -> {}
	}
}

fun getMarkdownSyntaxType(line: String) : MarkdownSyntaxType {
	if (line.matches(Regex("^#[ A-Za-z0-9].*"))) return MarkdownSyntaxType.HEAD_POUND
	else if (line.matches(Regex("^##[ A-Za-z0-9].*"))) return MarkdownSyntaxType.HEAD_POUNDPOUND
	else return MarkdownSyntaxType.OTHERS
}