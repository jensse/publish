#!/usr/bin/env bash
marktag="9.9.0"
MARK_BIN="./bin/mark"


function summary(){
  echo "Summary: installing mark version; ${1} testing..."
  if [ -f ${GITHUB_WORKSPACE}/bin/mark ] ; then
    echo $(bin/mark --version)
  else
    echo "ERROR Cant find MARKBIN at: ${GITHUB_WORKSPACE}/bin/mark"
  fi
  # echo $(env)
}


# If the markfile exist use this. And set $MARKFILE to existing file.
# If markfile dont exist, create one and sett variable to this.
function createMarkfileIfNotExist (){
    echo "Create .markfile"
    touch ${GITHUB_WORKSPACE}/.markfile
    chmod 700 ${GITHUB_WORKSPACE}/.markfile
    echo "${MARKFILE}" > ${GITHUB_WORKSPACE}/.markfile
    cat ${GITHUB_WORKSPACE}/.markfile | echo
}

# Test if mark is installed, if not: install mark
function installMark(){
    echo "Install mark"
    wget https://github.com/kovetskiy/mark/releases/download/9.9.0/mark_Linux_x86_64.tar.gz
    tar -xzvf mark_Linux_x86_64.tar.gz -C ${GITHUB_WORKSPACE}/bin/
}

function publishMd(){

  ${GITHUB_WORKSPACE}/bin/mark --dry-run -debug --config ${GITHUB_WORKSPACE}/.markfile -f ${GITHUB_WORKSPACE}/src/2023/*/*/*.md
  #find "$(pwd)" -name "*.md" -path "*src/202*" -exec ${GITHUB_WORKSPACE}/bin/mark --debug --config ${GITHUB_WORKSPACE}/.markfile --f {} \;
}

## Maks sure mark is enabled.
installMark ${marktag}
## Create a configfile i non exist.
createMarkfileIfNotExist
## Status before running.
summary ${marktag}
## The actuall work goes here
publishMd
