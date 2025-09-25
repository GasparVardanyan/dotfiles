#!/usr/bin/env bash

rm -rf FSRCNN
mkdir -p FSRCNN

urls=$( \
	curl -s https://api.github.com/repos/igv/FSRCNN-TensorFlow/releases/latest \
	| jq -r '.assets[] | select(.name | test("glsl")) | .browser_download_url' \
)

for url in $urls; do
	fname=$(basename "$url")
	echo "Downloading $fname"
	wget -O "FSRCNN/$fname" "$url"
done

rm -rf nvidia-shaders SSimSuperRes SSimDownscaler CAS-scaled FSR SGSR   \
	KrigBilateral adaptive-sharpen glsl-chroma-from-luma-prediction     \
	mpv-gallery-view mpv-playlistmanager

git clone https://gist.github.com/agyild/7e8951915b2bf24526a9343d951db214.git ./nvidia-shaders
git clone https://gist.github.com/igv/2364ffa6e81540f29cb7ab4c9bc05b6b.git ./SSimSuperRes
git clone https://gist.github.com/igv/36508af3ffc84410fe39761d6969be10.git ./SSimDownscaler
git clone https://gist.github.com/agyild/bbb4e58298b2f86aa24da3032a0d2ee6.git ./CAS-scaled
git clone https://gist.github.com/agyild/82219c545228d70c5604f865ce0b0ce5.git ./FSR
git clone https://gist.github.com/agyild/7715b6b1f38427839d58f80884902cab.git ./SGSR
git clone https://gist.github.com/igv/a015fc885d5c22e6891820ad89555637.git ./KrigBilateral
git clone https://gist.github.com/igv/8a77e4eb8276753b54bb94c1c50c317e.git ./adaptive-sharpen
git clone https://github.com/Artoriuz/glsl-chroma-from-luma-prediction.git

git clone https://github.com/GasparVardanyan/mpv-gallery-view.git
git clone https://github.com/jonniek/mpv-playlistmanager.git

find . -maxdepth 2 -name '.git' -type d  | xargs rm -rf
