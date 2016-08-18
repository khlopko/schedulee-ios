#!/usr/local/bin/bash

for folder in ic_*; do
	cd $folder/ios
	for file in ic_*; do
		mv "$file" "${file/_36pt/}";
	done
	ls -Al && cd ../..;
done