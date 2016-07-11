#!/bin/sh

# clean
rm pokemon_hook.ipa

# unzip
unzip -q "pokemon_unsigned.zip"


# cp dylib
cp LatestBuild/LocationFaker.dylib Payload/pokemongo.app/libLocationFaker.dylib

# embedded.mobileprovision
cp embedded.mobileprovision Payload/pokemongo.app/embedded.mobileprovision

# resign
rm -rf Payload/pokemongo.app/_CodeSignature
security cms -D -i Payload/pokemongo.app/embedded.mobileprovision > provision.plist
/usr/libexec/PlistBuddy -x -c 'Print :Entitlements' provision.plist > entitlements.plist
codesign -f -s "" --entitlements entitlements.plist Payload/pokemongo.app
codesign -f -s "" --entitlements entitlements.plist Payload/pokemongo.app/*.dylib

# zip to ipa
zip -qr pokemon_hook.ipa Payload

#clean
rm -rf "Payload"
rm provision.plist
rm entitlements.plist
rm -rf "__MACOSX"

# --- mark ---
# security find-identity -v -p codesigning