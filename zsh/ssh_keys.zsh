
# Auto add some of ssh keys 
ADD_KEYS="id_rsa id_dsa github heroku"
LINK=$(readlink /tmp) # /tmp is symlink in MacOSX
TMP=/${LINK:-tmp}
DIR=$(find ${TMP} -user $(whoami) -name ssh-\* 2> /dev/null | head -1)
if [ ! -z "${DIR}" ] ; then
	FL=$(ls $DIR)
	export SSH_AUTH_SOCK=${DIR}/${FL}
else
	eval $(ssh-agent)
	for key in ${ADD_KEYS} ; do	
		[ -f ~/.ssh/${key} ] && { ssh-add ~/.ssh/${key} ; }
	done
fi
