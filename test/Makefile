default:
	./maketestrepo.sh
	(cd wd && cvs log tag-testing)
	(cd wd && ../../cvsps -x)
	echo "All tests passed."

clobber:
	rm -rf repo wd
