# Python

## How python import packages
* Ref this [article](https://leemendelowitz.github.io/blog/how-does-python-find-packages.html)
* This is not whereis python
* Python search modules in (populated current path + $PYTHONPATH + sys.path)
* Use sys module to check sys.path
* Use imp module to manipulate import logic
