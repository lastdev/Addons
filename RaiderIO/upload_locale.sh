#!/bin/bash
#
# Upload addon locale data generated on CurseForge to S3 so we can pull it during build process.
#

FILE=$1

if [ ! -f "$FILE" ]; then
  echo "Usage: $0 <ZIP_FILE>"
  exit 1
fi

rm -rfv build_locale
mkdir build_locale
unzip -d build_locale $FILE RaiderIO/locale/*

aws --profile raiderio-assets s3 cp s3://raiderio-assets/addon-build/locale_ref.zip locale_ref_backup.zip

pushd build_locale
zip -r9 locale_ref.zip RaiderIO
unzip -l locale_ref.zip
aws --profile raiderio-assets s3 cp locale_ref.zip s3://raiderio-assets/addon-build/locale_ref.zip
popd

rm -rf build_locale
