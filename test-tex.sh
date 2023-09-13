#!/bin/zsh

temp_dir=$(mktemp -d)
cp -r . $temp_dir
cd $temp_dir
git commit --no-verify -m "temporary testing commit"
git clean -dqf
for tex_file in *.tex
do
    grep "^\\\\documentclass{" $tex_file &> /dev/null
    [ ! "$?" -eq 0 ] && continue
    echo "Test building file $tex_file..."
    pdflatex $tex_file | (! grep -e "Warning: Citation .* undefined")
    if [ "$?" -eq 1 ]; then
        echo "Update library!"
        exit 1
    fi
    echo "...$tex_file build succeeded."
done
