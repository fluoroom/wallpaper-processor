#!/bin/bash
function bold() {
  echo "$(tput bold)${1}$(tput sgr0)"
}

echo " 
   $(tput smso)                                    $(tput rmso)
   $(tput smso) $(tput rmso) Welcome to $(tput smso)                       $(tput rmso)
   $(tput smso)                                    $(tput rmso)
   $(tput smso)  $(tput bold)Wallpaper Processor$(tput sgr0)$(tput smso) by $(tput bold)fluoroom$(tput sgr0)$(tput smso)   $(tput rmso)
   $(tput smso)                                    $(tput rmso)
   $(tput smso) $(tput rmso) https://github.com/fluoroom $(tput smso)      $(tput rmso)
   $(tput smso)                                    $(tput rmso)
"

if [[ ! magick ]]; then
echo "Please install $(bold imagemagick) first."
exit
fi

echo "Loaded $(bold ${1})"

if [[ ! ${1} ]]; then
echo "No file selected, or inexistent file."
exit
fi

FILE=$1

function getRes () {
  if [[ ! xrandr ]]; then
  echo "Please install $(bold xrandr) first."
  exit
  fi
  resolution=$(xrandr | grep \* | cut -d' ' -f4  );
  resolutionH=$(echo $resolution | cut -d'x' -f1);
}

function promptRes () {
  read -p "Set your $(bold width):" width
  read -p "Set your $(bold height):" height
  resolution="${width}x${height}"
  resolutionH=$(echo $resolution | cut -d'x' -f1);
}

read -p "Automatically get your resolution? ($(bold Y)es / $(bold N)o / default: $(bold Yes)):" getRes
case "$getRes" in
    n|N|no|No ) promptRes;;
    * ) echo "Getting resolution from xrandr... " && getRes;;
esac

echo "Resolution set to $(bold ${resolution})."

read -p "How much blur? ($(bold L)ow / $(bold H)igh / $(bold U)ltra / default: $(bold High)):" blur
case "$blur" in
    l|L|low|Low ) blur=10 && echo "Blur set to $(bold low).";;
    u|U|ultra|Ultra ) blur=30 && echo "Blur set to $(bold ultra).";;
    *   ) blur=20 && echo "Blur set to $(bold high).";;
esac

read -p "Do you want to avoid/skip spread? (that grainy effect) ($(bold Y)es /$(bold N)o / default: $(bold No)):" spread
case "$spread" in
  y|Y|yes|Yes ) spread=false;;
  *   ) spread=true;;
esac
if [[ $spread ]]; then
echo "Processing $(bold with) spread."
else
echo "Processing $(bold without) spread."
fi


function execute () {
    resolution="${resolution}+0+0"
    resolutionH="${resolutionH}x"
    if [[ $spread ]]; then spread="-spread $(($blur/10))"; else spread=""; fi
    blur="${blur}x${blur}"
    filename=$(echo $FILE | cut -d'.' -f1);
    echo "Processing..." && 
    magick $FILE -gravity center -resize $resolutionH -crop $resolution  ${filename}-bg.png &&
    magick ${filename}-bg.png -gaussian-blur $blur $spread ${filename}-bg-blurred.png
}


read -p "Execute? (y/n):" choice
case "$choice" in
    n|N   ) echo "Aborted!" && exit;;
    * ) execute $1 && echo "Done!" && exit;;
esac

