#!/usr/bin/env bash
marktag="9.9.0"
MARK_BIN="./bin/mark"
MARK_CONF=".markfile"


function summary(){
  echo "Summary: installing mark version; ${1} testing..."
  if [ -f bin/mark ] ; then
    echo $(bin/mark --version)
  else
    echo "ERROR Cant find MARKBIN at: ${MARK_BIN}"
  fi
  # echo $(env)
}


# If the markfile exist use this. And set $MARKFILE to existing file.
# If markfile dont exist, create one and sett variable to this.
function createMarkfileIfNotExist (){
    echo "Create .markfile"
    touch ${MARK_CONF}
    chmod 700 ${MARK_CONF}
    echo ${MARKFILE} > ${MARK_CONF}
}

# Test if mark is installed, if not: install mark
function installMark(){
    echo "Install mark"
    wget https://github.com/kovetskiy/mark/releases/download/9.9.0/mark_Linux_x86_64.tar.gz
    tar -xzvf mark_Linux_x86_64.tar.gz -C bin/
}

function publishMd(){
  echo "Search for files in: $(pwd)"
  find "$(pwd)" -name "*.md" -path "*src/202*" -exec ${MARK_BIN} --config ${MARK_CONF} -f {} \;

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
