#!/bin/bash 

dk="$HOME/deterministic-kernel" 
cd $HOME
gituser=$1


NC='\e[0m'

get_deb_and_checksums() {
    version=$1
    deb_dir=$2 
    type=$3

    deb_dir="$HOME/DEB-$version" 

    echo "[info] $deb_dir" 

    mkdir -p $deb_dir
    cp $dk/kernel-build/linux-mempo/*.deb  $deb_dir
    cd $deb_dir
    
    #echo "Version: $version" >> checksums.txt 
    sha512sum *.deb >> checksums-$type.txt     
    cd $HOME
}

get_and_build() { 
    cd $HOME 

    type=$1 
    
    # ======= downloading from github ==========
    /usr/bin/yes | ./get-from-github.sh $gituser
    # ========================================== 

    if [ $? == 2 ] ; then  
        echo "Directory $dk arleady exist, using them to build" 
    fi
        
    cd $dk 
    ver=$(git tag --contains HEAD | tail -n 1) 
    #ver="v0.1.82-01-rc"

    echo -e "\e[45m$ver${NC}" 

        
    # ======== main build =============== 
    /usr/bin/yes | ./run-flavour.sh $type 
    # =================================== 

    deb_dir="$HOME/DEB-$version"     
    get_deb_and_checksums $ver $deb_dir $type

    cd $HOME

    source_dir="$HOME/SOURCE-$ver"
    
    echo "[info] $source_dir" 
    
    mkdir -p  $source_dir
    mv $dk   $dk-$type     
    mv $dk-$type    $source_dir

    $HOME/.ii/start.sh $ver $type $deb_dir

}

get_and_build deskmax 
get_and_build desk 

