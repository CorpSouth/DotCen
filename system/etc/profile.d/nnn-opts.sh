if [ -x "/usr/bin/cmatrix" ] ; then
	export NNN_LOCKER="cmatrix"
fi;

if [ -x "/usr/bin/nnn" ] ; then
	export NNN_OPTS="Cdei"
fi;

if [ -x "/usr/bin/trash" ] ; then
	export NNN_TRASH="1"
fi;
