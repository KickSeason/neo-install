#!/bin/bash
NETWORK=$1

if [ x$NETWORK == x ]; then
    echo "please clarify network"
    exit 1
fi

sudo apt update
sudo apt-get -y install libleveldb-dev sqlite3 libsqlite3-dev unzip zip

#install dotnet
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo apt update
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get -y install apt-transport-https
sudo apt-get update
sudo apt-get -y install aspnetcore-runtime-3.0

#install neo-cli
wget https://github.com/neo-project/neo-cli/releases/download/v2.10.3/neo-cli-linux-x64.zip
unzip neo-cli-linux-x64.zip

#install plugins
cd neo-cli
wget https://github.com/neo-project/neo-plugins/releases/download/v2.10.3/ApplicationLogs.zip
unzip ApplicationLogs.zip
wget https://github.com/neo-project/neo-plugins/releases/download/v2.10.3/ImportBlocks.zip
unzip ImportBlocks.zip
wget https://github.com/neo-project/neo-plugins/releases/download/v2.10.3/RpcSystemAssetTracker.zip
unzip RpcSystemAssetTracker.zip
wget https://github.com/neo-project/neo-plugins/releases/download/v2.10.3/SimplePolicy.zip
unzip SimplePolicy.zip
rm *.zip
cd Plugins/
wget https://tmpngd.oss-cn-shanghai.aliyuncs.com/RpcNep5Tracker.zip
unzip RpcNep5Tracker.zip
wget https://tmpngd.oss-cn-shanghai.aliyuncs.com/ExplorerRPC.zip
unzip ExplorerRPC.zip
rm *.zip

cd ..
if [ x$NETWORK == xtestnet ]; then
    mv config.testnet.json config.json
    mv protocol.testnet.json protocol.json
fi

#download chaindata
if [ x$NETWORK == xtestnet ]; then
    screen -dmS download wget https://packet.azureedge.net/neochain/testnet/full/0-3380423/20F85E5FF93AD0EED9BC2621B6364B3A/chain.acc.zip
else
    screen -dmS download wget https://packet.azureedge.net/neochain/mainnet/full/0-4443645/205d4caf8c94653b792b2b04a03ff2f6/chain.acc.zip
fi

