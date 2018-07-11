type="testnet"
cd ~

apt-get update

apt-get -y install unzip \
    curl \
    apt-transport-https \
    wget \
    expect \
    libunwind8 \
    icu-devtools \
    libleveldb-dev \
    sqlite3 \
    libsqlite3-dev \
    libunwind8-dev \
    zip \
    screen


## dotnet
echo "install dotnet"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list'

apt-get update
apt-get -y install dotnet-sdk-2.1.104 --no-install-recommends
rm -rf /var/lib/apt

apt-get -y clean

## neo-cli
echo "download neo-cli."
wget "https://neo-cli.oss-cn-hangzhou.aliyuncs.com/v3.0.0/neo-cli-linux-x64.zip"
unzip neo-cli-linux-x64.zip
rm neo-cli-linux-x64.zip

## chain
##change config
echo "download chain data."
if [ ${type}x == "testnetx" ]; then
    echo "testnet"
    wget "http://static.neo.org/client/chain.acc.test.zip"
    mv chain.acc.test.zip chain.acc.zip
    mv chain.acc.zip ./neo-cli
    cd neo-cli
    mv config.json config.json0
    mv config.testnet.json config.json
    mv protocol.json protocol.json0
    mv protocol.testnet.json protocol.json
else 
    echo "mainnet"
    wget "http://static.neo.org/client/chain.acc.zip"
    mv chain.acc.zip ./neo-cli
fi

echo "starting neo-cli"
cd ~/neo-cli/
screen -dmS neo dotnet neo-cli.dll --rpc
