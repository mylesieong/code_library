#!/usr/bin/python

import sys
import enum 
from os import listdir
  
class MarkdownSyntaxType(enum.Enum): 
    HEAD_POUND = 0
    HEAD_POUNDPOUND = 1
    OTHERS = 2

FILE_ROOT = '.'
MARKDOWN_EXTENSION = 'md'

def listFilesWithExtension(directory, extension) :
    files = (f for f in listdir(directory) if f.endswith('.' + extension))
    for f in files:
        print(f)

def handleTree(f):
    print("NA")

if sys.argv[1] == 'list' :
    listFilesWithExtension(FILE_ROOT, MARKDOWN_EXTENSION)
elif sys.argv[1] == 'tree' :
    handleTree(sys.argv[2])

