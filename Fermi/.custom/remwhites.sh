#!/bin/bash
IFS="\n"
for file in *;
do
    mv "$file" "${file//[[:space:]]}"
done
