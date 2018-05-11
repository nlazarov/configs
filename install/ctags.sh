git clone git@github.com:universal-ctags/ctags.git
cd ctags
./autogen.sh
.configure
make
make install
rm -rf ctags
