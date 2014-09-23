#!/bin/bash 

dk="$HOME/deterministic-kernel" 
cd $HOME

get_deb_and_checksums() {
    version=$1

    deb_dir="$HOME/DEB-$version" 

    echo "[info] $deb_dir" 

    mkdir -p $deb_dir
    cp $dk/kernel-build/linux-mempo/*.deb  $deb_dir
    cd $deb_dir
    
    echo "Version: $version" >> checksums.txt 
    sha512sum *.deb >> checksums.txt 
    
}

get_and_build() { 
    cd $HOME 

    type=$1 
    
    /usr/bin/yes | ./get-from-github.sh 
    
    cd $dk 
    ver=$(git tag --contains HEAD | tail -n 1) 
    
    /usr/bin/yes | ./run-flavour.sh $type 
    
    get_deb_and_checksums $ver 

    cd $HOME

    source_dir="$HOME/SOURCE-$ver"
    
    echo "[info] $source_dir" 
    
    mkdir -p  $source_dir
    mv $dk   $dk-$type     
    mv $dk-$type    $source_dir
}

get_and_build deskmax 
get_and_build desk 

