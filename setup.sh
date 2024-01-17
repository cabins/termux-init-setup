# setup for storage
termux-setup-storage

# setup for packages
termux-change-repo

# install packages for programming
pkg upgrade -y
pkg install -y python{,-pip} rust{,-analyzer} golang nodejs kotlin openjdk-17

mkdir -p ~/.devel/{go,java/jdtls}

echo "export GOPATH=~/.devel/go" >> ~/.bashrc
echo "export PATH=\$PATH:\$GOPATH/bin" >> .bashrc
source ~/.bashrc
go env -w GOPROXY=https://goproxy.cn,direct
go install golang.org/x/tools/gopls@latest

pip install "python-lsp-server[all]"

# install build-essentials
pkg install -y build-essential git emacs
git clone https://github.com/cabins/emacs.d.git ~/.emacs.d

# some funny or useful pkgs
pkg install -y jq tree which wget curl axel aria2 proot-distro openssh

# install jdtls
axel -c -n 5 https://www.eclipse.org/downloads/download.php?file=/jdtls/snapshots/jdt-language-server-latest.tar.gz -o ~/.devel/java/jdtls-latest.tar.gz
tar xvf ~/.devel/java/jdtls-latest.tar.gz -C ~/.devel/java/jdtls
echo "export JDTLS_HOME=~/.devel/java/jdtls" >> ~/.bashrc
echo "export PATH=\$PATH:\$JDTLS_HOME/bin" >> ~/.bashrc

# install the style script
echo "Installing the tstyle..."
git clone https://github.com/htr-tech/tstyle ~/tstyle
