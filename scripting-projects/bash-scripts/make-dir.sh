#!/bin/bash
echo "Enter directory name:"
read newdir
if [ -d "$newdir" ]
then
echo "Directory exists"
else
`mkdir $newdir`
echo "Directory created"
fi