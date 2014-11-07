#!/bin/bash 

repo='deterministic-kernel' 
default_user='mempo'
cd $HOME
if [ -d $repo ] ; then 
	echo "Directory arleady exist, please rename or remove [$repo]" 
	exit 2  
fi 

if [ $# == 0 ] ; then 
	user=$default_user
else 
	user=$1
fi

url=https://github.com/$user/$repo.git
 
echo "Clone  $url? (y/n)" 
read yn 

if [[ $yn != "y" ]] ; then 
    echo "Aborting" 
    exit  
else 
    git clone $url
fi
cd $repo 

#https://github.com/monero-project/bitmonero
