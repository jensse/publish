#!/usr/bin/env bash
marktag="9.9.0"
MARKBIN=mark


function summary(){
  echo "Summary: installing mark version; ${1} testing..."
  if [ -f bin/mark ] ; then
    echo $(bin/mark --version)
  else
    echo "ERROR Cant find MARKBIN at: ${MARKBIN}"
  fi
  # echo $(env)
}


# If the markfile exist use this. And set $MARKFILE to existing file.
# If markfile dont exist, create one and sett variable to this.
function createMarkfileIfNotExist (){
  echo "If working on *inx and configfile exist set MARKFILE to local file."

  if [ -f ${HOME}/.config/mark ]; then
      MARKFILE="${HOME}/.config/mark"
  else
    #Github actions
    echo "Create .markfile"
    touch .markfile
    chmod 700 .markfile
    echo "${MARKFILE}" > .markfile
   fi
}

# Test if mark is installed, if not: install mark
function installMark(){
  echo "Install mark if dont exist"
  if [ ! type "mark" > /dev/null ]; then
    # install mark
    echo "Mark not installed; installing and setting alais for excecution"
    wget https://github.com/kovetskiy/mark/releases/download/${tag}/mark_Linux_x86_64.tar.gz
    tar -xzvf mark_Linux_x86_64.tar.gz -C bin/
    PATH=bin:${PATH}
  fi

}

function publishMd(){
  # DEBUG Stuff
  # echo "Tree: $(tree ${GITHUB_WORKSPACE} )"
  # echo "PWD: $(pwd)"
  # echo $(env)
  echo "Search for files in: $(pwd)"
  find "$(pwd)" -name "*.md" -path "*src/202*" -exec bin/mark --config ${MARKFILE} -f {} \;

  #echo $(mark --config ${MARKFILE} -f ${GITHUB_WORKSPACE}/src/*.md)
}

## Maks sure mark is enabled.
installMark ${marktag}
## Create a configfile i non exist.
createMarkfileIfNotExist
## Status before running.
summary ${marktag}
## The actuall work goes here
publishMd
