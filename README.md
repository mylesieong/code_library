# Code Library introduction
Code library is my library of programming knowledge. Concept debriefing and code reference or snippets can be found in different excel workbook or markdown. *I am currently working on converting all excel wb to markdown*

## Library structure 
- index.xlsx: This workbook records concepts, resources or facts regards different topics
- \*\_lib.xlsx: These workbooks record code snippets on different subjects, and format in a subject/topic/content sequence by rows.

## Rules of thumb
- Dont record too much and too detail: it should only comes to frequent-used and hard to remember code.
- Record & Remember: It should not be a record and forget, its only a supporting tool.

## View tool

### liba.exe
Run liba.exe to view the workbook content in command line. Here are common-used commands:
- Browse git_lib.xlsx at a high level:  `./liba -show git_lib.xlsx`
- Browse the 17th entry of git_lib.xlsx at a detail level:  `./liba -show git_lib.xlsx 17`
- Search for a merge related snippets: `./liba -showfull git_lib.xlsx | grep merge --color`

### liba.kts 
Use kotlin to access java libraries content in a script. Here are common-used commands:
- list all markdown files: `kotlinc -script liba.kts list`
- list all markdown files and its top level topics: `kotlinc -script liba.kts tree`
- help: `kotlinc -scripts liba.kts help`

(note this requires kotlinc installed, see [here](https://kotlinlang.org/docs/tutorials/command-line.html) for more info)
