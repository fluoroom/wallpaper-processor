#!/bin/bash
function bold() {
  echo "$(tput bold)${1}$(tput sgr0)"
}

if [[ ! xrandr ]]; then
echo "Please install $(bold xrandr) first."
exit
fi

if [[ ! magick ]]; then
echo "Please install $(bold imagemagick) first."
exit
fi

echo "Processing $(bold ${1})"

if [[ ! ${1} ]]; then
echo "No file selected, or inexistent file."
exit
fi

FILE=$1

resolution=$(xrandr | grep \* | cut -d' ' -f4  );
resolutionH=$(echo $resolution | cut -d'x' -f1);
echo "Resolution is ${resolution}."
read -p "How much blur? ($(bold L)ow / $(bold H)igh / $(bold U)ltra / default: High):" blur
case "$blur" in
    l|L|low|Low ) blur=10 && echo "Blur set to $(bold low).";;
    u|U|ultra|Ultra ) blur=30 && echo "Blur set to $(bold ultra).";;
    *   ) blur=20 && echo "Blur set to $(bold high).";;
esac

read -p "Do you want to avoid/skip spread? (that grainy effect) ($(bold y)/$(bold n)/ default: no):" spread
case "$spread" in
  y|Y ) spread=false;;
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
    y|Y ) execute $1 && echo "Done!" && exit;;
    *   ) echo "Aborted!" && exit;;
esac

