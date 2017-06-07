# Install Environment
On linux/cygwin, simply use apt-get/apt-cyg install clisp. In command line, `clisp target.lisp` to run.
# Basic syntax
## Operators 
```lisp
(write-line "Hello there")
(write (+ 7 9 11))
(write (+ (* (/ 9 5) 60) 32))
; use commor to give comment
(setq x 10)
(setq y nil)
(print x)
(defvar x 10)
(print (type-of x))
```
## Define Marcos
```lisp
; definition
(defmacro setTo10 (num)
    (setq num 10))
; invoke
(setq x 25)
(setTo10 x)
(print x)
```
## If Clause
```lisp
(defun demofunc (flag)
    (print 'enter outer block')
... 
```

