import sys
import enum 
import os
import re
  
class MarkdownSyntaxType(enum.Enum): 
    HEAD_POUND = 0
    HEAD_POUNDPOUND = 1
    HEAD_POUNDPOUNDPOUND = 3
    HEAD_OTHERS = 4
    OTHERS = 5

FILE_ROOT = '.'
MARKDOWN_EXTENSION = 'md'

def listFilesWithExtension(directory, extension) :
    files = (f for f in os.listdir(directory) if f.endswith('.' + extension))
    for f in files:
        print(f)

def handleTree(f):
    with open(f) as fo:
        linesWithType = [ (l, getMarkdownSyntaxType(l)) for l in fo.read().splitlines()]
        for (l, t) in linesWithType:
            if t == MarkdownSyntaxType.HEAD_POUND:
                print(l)
            elif t == MarkdownSyntaxType.HEAD_POUNDPOUND:
                print('\t' + l)
            elif t == MarkdownSyntaxType.HEAD_POUNDPOUNDPOUND:
                print('\t\t' + l)
            elif t == MarkdownSyntaxType.HEAD_OTHERS:
                print('\t\t\t' + l)

def getMarkdownSyntaxType(line) :
    if re.compile("^#[ A-Za-z0-9].*").match(line):
        return MarkdownSyntaxType.HEAD_POUND
    elif re.compile("^##[ A-Za-z0-9].*").match(line):
        return MarkdownSyntaxType.HEAD_POUNDPOUND
    elif re.compile("^###[ A-Za-z0-9].*").match(line):
        return MarkdownSyntaxType.HEAD_POUNDPOUNDPOUND
    elif re.compile("^###[#]*[ A-Za-z0-9].*").match(line):
        return MarkdownSyntaxType.HEAD_OTHERS
    else:
        return MarkdownSyntaxType.OTHERS

if sys.argv[1] == 'list' :
    listFilesWithExtension(FILE_ROOT, MARKDOWN_EXTENSION)
elif sys.argv[1] == 'tree' :
    handleTree(sys.argv[2])

