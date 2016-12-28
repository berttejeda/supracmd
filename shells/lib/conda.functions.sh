# python # conda
conda.env.create(){
  if [ $# -lt 1 ]; then echo "Usage: ${FUNCNAME[0]} <virtualenv_name> [python=<version>](optional)"; return 1; fi
  environment=$1
  ver=${2-2.7}
  binary=conda
  if ! (which $binary || type -all $binary || [ -f $binary ]) >/dev/null 2>&1;then
    echo "This function requires $binary, see installation instructions: https://www.continuum.io/downloads"
    return 1
  else
    conda create -n $environment python=$ver
  fi  
}

conda.env.list(){
  binary=conda
  if ! (which $binary || type -all $binary || [ -f $binary ]) >/dev/null 2>&1;then
    echo "This function requires $binary, see installation instructions: https://www.continuum.io/downloads"
    return 1
  else
    conda info --envs
  fi
}

conda.env.activate(){
  if [ $# -lt 1 ]; then echo "Usage: ${FUNCNAME[0]} <virtualenv_name>"; return 1; fi
  binary=conda
  environment=$1
  if ! (which $binary || type -all $binary || [ -f $binary ]) >/dev/null 2>&1;then
    echo "This function requires $binary, see installation instructions: https://www.continuum.io/downloads"
    return 1
  else
    source activate $environment
  fi
}