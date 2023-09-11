#!/usr/bin/env bash
marktag="9.9.0"

touch .markfile
chmod 700 .markfile
echo "${MARKFILE}" > .markfile

function summary(){
  echo "Summary: installing mark version; ${1} testing..."
  echo $(mark --version)
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
    echo "Create makefile"
    touch .markfile
    chmod 700 .markfile
    echo "${MARKFILE}" > .markfile
   fi
}

function installMark(){
  echo "Install mark if dont exist"
  tag=${1}
  if [ -f "bin/mark"]l; then
    echo "bin/mark, exist"
    alias mark="bin/mark"
    exit 0;

  elif [[ $(mark --version) == "mark version 9*" ]]; then
    echo "Mark is installed locally"
    GITHUB_WORKSPACE=$(pwd)
  else
    #Install mark
    wget https://github.com/kovetskiy/mark/releases/download/${tag}/mark_Linux_x86_64.tar.gz
    tar -xzvf mark_Linux_x86_64.tar.gz -C bin/
    chmod 755 bin/mark
    alias mark="bin/mark"
  fi
}

function publishMd(){
  # DEBUG Stuff
  # echo "Tree: $(tree ${GITHUB_WORKSPACE} )"
  # echo "PWD: $(pwd)"
  # echo $(env)
  echo "Search for files in: $(pwd)"
  find "$(pwd)" -name "*.md" -path "*src/202*" -exec mark --config ${MARKFILE} -f {} \;

  #echo $(mark --config ${MARKFILE} -f ${GITHUB_WORKSPACE}/src/*.md)
}

installMark ${marktag}
createMarkfileIfNotExist
summary ${marktag}
publishMd
