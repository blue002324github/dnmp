#!/bin/bash

#1.confirm version
Codename=$(cat /etc/os-release | grep VERSION_CODENAME |awk -F'=' '{print $2}')
echo "Your Ubuntu:$Codename"

#2.Select source
echo "**********************************"
echo "Please select:"
echo "
    1.aliyun     
    2.tsinghua     
    3.163
    4.ustc
    "
echo "**********************************"
read -s -n1 sourceChoice

if [ $sourceChoice -ne 1 ] && [ $sourceChoice -ne 2 ] && [ $sourceChoice -ne 3 ] && [ $sourceChoice -ne 4 ];then
    echo
    echo 'input_error,Good Bye.'
    exit
fi

case $sourceChoice in
	1)
		choose='aliyun'
	;;
	2)
		choose='tsinghua'
	;;
	3)
		choose='163'
	;;
	4)
		choose='ustc'
	;;
esac

case $choose in
	aliyun)
		sourceweb='http://mirrors.aliyun.com'
	;;
	tsinghua)
		sourceweb='https://mirrors.tuna.tsinghua.edu.cn'
	;;
	163)
		sourceweb='http://mirrors.163.com'
	;;
	ustc)
		sourceweb='http://mirrors.ustc.edu.cn'
	;;
esac

# 3.backup and replace
echo "backup sources.list..."
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo "set new source..."
echo "\
deb $sourceweb/ubuntu/ $Codename main restricted universe multiverse
deb $sourceweb/ubuntu/ $Codename-security main restricted universe multiverse
deb $sourceweb/ubuntu/ $Codename-updates main restricted universe multiverse
deb $sourceweb/ubuntu/ $Codename-proposed main restricted universe multiverse
deb $sourceweb/ubuntu/ $Codename-backports main restricted universe multiverse
deb-src $sourceweb/ubuntu/ $Codename main restricted universe multiverse
deb-src $sourceweb/ubuntu/ $Codename-security main restricted universe multiverse
deb-src $sourceweb/ubuntu/ $Codename-updates main restricted universe multiverse
deb-src $sourceweb/ubuntu/ $Codename-proposed main restricted universe multiverse
deb-src $sourceweb/ubuntu/ $Codename-backports main restricted universe multiverse">/etc/apt/sources.list
echo "update source..."
sudo apt-get update

