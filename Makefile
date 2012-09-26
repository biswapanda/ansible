#!/usr/bin/make
SITELIB = $(shell python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()")
FORMATTER=../ansible/hacking/module_formatter.py

all: clean docs

docs: clean modules
	./build-site.py

viewdocs: clean
	./build-site.py view

htmldocs:
	 ./build-site.py rst

clean:
	-rm -f .buildinfo
	-rm -f *.inv
	-rm -rf *.doctrees
	@echo "Cleaning up byte compiled python stuff"
	find . -regex ".*\.py[co]$$" -delete
	@echo "Cleaning up editor backup files"
	find . -type f \( -name "*~" -or -name "#*" \) -delete
	find . -type f \( -name "*.swp" \) -delete

.PHONEY: docs clean

modules: $(FORMATTER) ../ansible/hacking/templates/rst.j2
	$(FORMATTER) -t rst --template-dir=../ansible/hacking/templates --module-dir=../ansible/library -o rst/modules/
	
