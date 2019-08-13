export GSA_VERSION=1.0
test: test_py
test_py:
	docker run -v `pwd`:/home/jovyan/test jreades/gsa_py:${GSA_VERSION} start.sh jupyter nbconvert --execute /home/jovyan/test/gds_py/check_py_stack.ipynb
write_stacks:
	# Python
	docker run -v ${PWD}:/home/jovyan --rm jreades/gsa:${GSA_VERSION} start.sh conda list > stack_py.txt
	docker run -v ${PWD}:/home/jovyan --rm jreades/gsa:${GSA_VERSION} start.sh sed -i '1iGDS version: ${GSA_VERSION}' stack_py.txt
