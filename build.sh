set -ex
prefix="${PREFIX:-$HOME/.pyenv/versions/3.9-dev}"
./configure --prefix="$prefix"
cp pyconfig-osx.h pyconfig.h
make -j4 "$@"
make install
