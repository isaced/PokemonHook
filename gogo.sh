#!/bin/sh

# certifierName=""  

# clean
rm pokemon.ipa

# unzip
unzip -q "pokemon_unsigned.zip" #-d pack


# cp dylib
cp LatestBuild/LocationFaker.dylib Payload/pokemongo.app/libLocationFaker.dylib

# embedded.mobileprovision
# cp embedded.mobileprovision Payload/pokemongo.app/embedded.mobileprovision

# resign
# rm -rf pake/Payload/pokemongo.app/_CodeSignature
# security cms -D -i Payload/pokemongo.app/embedded.mobileprovision > provision.plist
# /usr/libexec/PlistBuddy -x -c 'Print :Entitlements' provision.plist > entitlements.plist
# codesign -f -s $certifierName --entitlements entitlements.plist Payload/pokemongo.app
# codesign -f -s $certifierName --entitlements entitlements.plist Payload/pokemongo.app/*.dylib

# zip to ipa
zip -qr pokemon.ipa Payload

#clean
rm -rf Payload
rm -rf __MACOSX
# rm provision.plist
# rm entitlements.plist

# --- mark ---
# security find-identity -v -p codesigning