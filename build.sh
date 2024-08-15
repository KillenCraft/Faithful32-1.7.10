#!/bin/bash

clean_up() {
  test -d "$build_dir" && rm -fr "$build_dir"
}

pushd() {
  command pushd "$@" > /dev/null
}

popd() {
  command popd "$@" > /dev/null
}

zip_name="Faithful32-Modded-1.7.x.zip"
build_dir=$( mktemp -d -t build-resource-pack.XXX )
trap "clean_up $build_dir" EXIT

cp -r assets Reika $build_dir
cp pack.* $build_dir
find $build_dir -iname '*.md' -type f -delete
find $build_dir -iname '*.psd' -type f -delete

pushd $build_dir
zip -rq $zip_name *
popd

cp $build_dir/$zip_name .

#Exit the script with code 0 to indicate success. (Not currently used).
exit 0
