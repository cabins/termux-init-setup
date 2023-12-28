# setup for storage
termux-setup-storage

# setup for packages
termux-change-repo

# install packages for programming
pkg upgrade -y
pkg install -y python{,-pip} rust{,-analyzer} golang nodejs kotlin

echo "export GOPATH=~/.go" >> ~/.bashrc
echo "export PATH=$PATH:$GOPATH/bin" >> .bashrc
source ~/.bashrc
go install golang.org/x/tools/gopls@latest

pip install "python-lsp-server[all]"

# install build-essentials
pkg install -y build-essential git emacs
git clone https://github.com/cabins/emacs.d.git ~/.emacs.d

# some funny or useful pkgs
pkg install -y jq tree which wget curl axel aria2 proot-distro openssh

# install the style script
echo "Installing the tstyle..."
git clone https://github.com/htr-tech/tstyle ~/tstyle
