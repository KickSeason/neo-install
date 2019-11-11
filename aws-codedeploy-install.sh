#!/bin/bash
sudo apt update
sudo apt-get -y install ruby
wget https://aws-codedeploy-ap-northeast-1.s3.ap-northeast-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent status
sudo service codedeploy-agent start
sudo service codedeploy-agent status