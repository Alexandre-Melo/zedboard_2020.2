CWD=$(pwd)
echo "Check if ~/.local/bin/repo is in PATH"

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.local/bin/repo
# Make repo executable
chmod +x ~/.local/bin/repo
 

mkdir Xilinx
cd Xilinx
repo init -u git://github.com/Xilinx/yocto-manifests.git -b rel-v2020.2
repo sync
chmod +x setupsdk
cd ${CWD}