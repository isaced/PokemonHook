#!/bin/sh

# clean
rm -rf "Payload"
rm pokemon_hook.ipa

# unzip
unzip -q "pokemon_unsigned.zip"

# remove this
rm -rf "__MACOSX"

# cp dylib
cp LatestBuild/LocationFaker.dylib Payload/pokemongo.app/libLocationFaker.dylib

# embedded.mobileprovision
# cp embedded.mobileprovision Payload/pokemongo.app/embedded.mobileprovision

# resign
# codesign -f -s "iPhone Distribution: Kunhua  Technology Co., Ltd. (H73L5KDA32)" Payload/pokemongo.app

# zip to ipa
zip -qr pokemon_hook.ipa Payload

# --- mark ---
# security find-identity -v -p codesigning