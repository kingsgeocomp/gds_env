export GEOCOMP_VERSION=3.0
test: test_py
test_py:
	docker run -v `pwd`:/home/jovyan/test darribas/gds_py:${GDS_VERSION} start.sh jupyter nbconvert --execute /home/jovyan/test/gds_py/check_py_stack.ipynb
write_stacks:
	# Python
	docker run -v ${PWD}:/home/jovyan --rm darribas/gds:${GDS_VERSION} start.sh conda list > stack_py.txt
	docker run -v ${PWD}:/home/jovyan --rm darribas/gds:${GDS_VERSION} start.sh sed -i '1iGDS version: ${GDS_VERSION}' stack_py.txt
