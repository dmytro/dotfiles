
ADD_KEYS="id_rsa id_dsa github github_dsa github_rsa heroku"
LINK=$(readlink /tmp) # /tmp is sylink in MacOSX
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
