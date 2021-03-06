#!/bin/bash

# The author disclaims copyright to this source code.  In place of
# a legal notice, here is a blessing:
#    May you do good and not evil.
#    May you find forgiveness for yourself and forgive others.
#    May you share freely, never taking more than you give.

# USAGE:
# ./drinkOverlay /path/to/lotr/assets /path/to/out/dir

cd $1
cd lotr/textures/items

# Make sure we have the overlays
#if [ -d "$2" ]; then
#  echo "You need the overlays!"
#  exit 1
#fi

# Get all of our output folders in order
mkdir $2/Vessels
mkdir $2/Liquid
mkdir $2/LiquidBackgrounds
mkdir $2/Out
mkdir $2/Gif

# Grab the vessel and liquid images
allVessels=(drink_*.png)
for infile in ${allVessels[@]}; do
  cp $infile $2/Vessels
done

allLiquids=(mug*_liquid.png)
for infile in ${allLiquids[@]}; do
  cp $infile $2/Liquid
done

cd $2

# Remove the vessel pinkness
allVessels=(Vessels/drink_*.png)
for infile in ${allVessels[@]}; do
  convert $infile -transparent 'rgba(255,0,255,100)' $infile
done

# This array matches the vessel files to their appropriate overlays
declare -A vessels
vessels["bottle"]="Flask"
vessels["clay"]="Mug"
vessels["glass"]="Mug"
vessels["gobletCopper"]="Mug"
vessels["gobletGold"]="Mug"
vessels["gobletSilver"]="Mug"
vessels["gobletWood"]="Mug"
vessels["horn"]="Horn"
vessels["hornGold"]="Horn"
vessels["mug"]="Mug"
vessels["skin"]="Skin"
vessels["skull"]="Mug"

# Overlay the overlays onto the liquids, and then remove the pink
for vessel in Vessels/*; do
  vesselType=${vessel#Vessels/drink_}
  vesselType=${vesselType%.png}
  for liquid in Liquid/*; do
    liquidType=${liquid#Liquid/mug}
    liquidType=${liquidType%_liquid.png}
    overlayType="${vessels[$vesselType]}"
    overlay="Overlays/${overlayType}Overlay.png"
    liquidBackground="LiquidBackgrounds/$liquidType$overlayType.png"
    output="Out/${vesselType}${liquidType}.png"
    
    composite -gravity center -compose Over $overlay $liquid $liquidBackground
    convert $liquidBackground -transparent 'rgba(240,0,255,100)' $liquidBackground
    composite -gravity center -compose Over $vessel $liquidBackground $output
  done
done

# Animate each liquid into gifs
for liquid in Liquid/*; do
    liquidType=${liquid#Liquid/mug}
    liquidType=${liquidType%_liquid.png}
    convert -dispose background -delay 100 -loop 0 Out/*${liquidType}.png Gif/${liquidType}.gif
done
