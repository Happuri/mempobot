#!/bin/bash
set -x
ver=$1 # v0.1.81-01-rc 

cd $HOME

deb=DEB-$ver
src=SOURCE-$ver 

short=$(echo $ver | tr "." " " | awk '{print $3}' )

mkdir -p ver-$short 

mv $deb $src ver-$short  
