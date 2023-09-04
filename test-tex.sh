#!/bin/zsh

temp_dir=$(mktemp -d)
cp -r . $temp_dir
cd $temp_dir
git commit --no-verify -m "temporary testing commit"
git clean -dqf
pdflatex main.tex | (! grep -e "Warning: Citation .* undefined")
if [ "$?" -eq 1 ]; then
    echo "Update library!"
    exit 1
fi
