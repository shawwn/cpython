# prerequisites:
# - set up a Rosetta terminal, and run all of the following in it.
# - create a custom homebrew at /opt/i386/homebrew
# - symlink /opt/i386/homebrew/bin/brew to i386-brew
# - i386-brew install zlib readline openssl


# For reference, i386-brew install output is below.


# $ i386-brew install zlib
# ==> Downloading https://homebrew.bintray.com/bottles/zlib-1.2.11.big_sur.bottle.tar.gz
# ######################################################################## 100.0%
# ==> Pouring zlib-1.2.11.big_sur.bottle.tar.gz
# ==> Caveats
# zlib is keg-only, which means it was not symlinked into /opt/i386/homebrew,
# because macOS already provides this software and installing another version in
# parallel can cause all kinds of trouble.

# For compilers to find zlib you may need to set:
#   export LDFLAGS="-L/opt/i386/homebrew/opt/zlib/lib"
#   export CPPFLAGS="-I/opt/i386/homebrew/opt/zlib/include"

# For pkg-config to find zlib you may need to set:
#   export PKG_CONFIG_PATH="/opt/i386/homebrew/opt/zlib/lib/pkgconfig"

# ==> Summary
# 🍺  /opt/i386/homebrew/Cellar/zlib/1.2.11: 12 files, 413.6KB


# $ i386-brew install readline openssl
# ==> Tapping homebrew/core
# Cloning into '/opt/i386/homebrew/Library/Taps/homebrew/homebrew-core'...
# remote: Enumerating objects: 40, done.
# remote: Counting objects: 100% (40/40), done.
# remote: Compressing objects: 100% (27/27), done.
# remote: Total 933754 (delta 21), reused 30 (delta 13), pack-reused 933714
# Receiving objects: 100% (933754/933754), 375.98 MiB | 32.75 MiB/s, done.
# Resolving deltas: 100% (634134/634134), done.
# Tapped 2 commands and 5547 formulae (5,868 files, 412.2MB).
# ==> Downloading https://homebrew.bintray.com/bottles/readline-8.1.big_sur.bottle.tar.gz
# ==> Downloading from https://d29vzk4ow07wi7.cloudfront.net/2cc3a9582e3c7e21eb3c2c8964abd33e9720fb4a9588c626d8424ff8cc9b1aed?response-content-disposition=attachm
# ######################################################################## 100.0%
# ==> Pouring readline-8.1.big_sur.bottle.tar.gz
# ==> Caveats
# readline is keg-only, which means it was not symlinked into /opt/i386/homebrew,
# because macOS provides BSD libedit.

# For compilers to find readline you may need to set:
#   export LDFLAGS="-L/opt/i386/homebrew/opt/readline/lib"
#   export CPPFLAGS="-I/opt/i386/homebrew/opt/readline/include"

# For pkg-config to find readline you may need to set:
#   export PKG_CONFIG_PATH="/opt/i386/homebrew/opt/readline/lib/pkgconfig"

# ==> Summary
# 🍺  /opt/i386/homebrew/Cellar/readline/8.1: 48 files, 1.6MB



# ==> openssl@1.1
# A CA file has been bootstrapped using certificates from the system
# keychain. To add additional certificates, place .pem files in
#   /opt/i386/homebrew/etc/openssl@1.1/certs

# and run
#   /opt/i386/homebrew/opt/openssl@1.1/bin/c_rehash

# openssl@1.1 is keg-only, which means it was not symlinked into /opt/i386/homebrew,
# because macOS provides LibreSSL.

# If you need to have openssl@1.1 first in your PATH, run:
#   echo 'export PATH="/opt/i386/homebrew/opt/openssl@1.1/bin:$PATH"' >> ~/.zshrc

# For compilers to find openssl@1.1 you may need to set:
#   export LDFLAGS="-L/opt/i386/homebrew/opt/openssl@1.1/lib"
#   export CPPFLAGS="-I/opt/i386/homebrew/opt/openssl@1.1/include"

# For pkg-config to find openssl@1.1 you may need to set:
#   export PKG_CONFIG_PATH="/opt/i386/homebrew/opt/openssl@1.1/lib/pkgconfig"



set -ex

for lib in readline openssl zlib
do
  export LDFLAGS="${LDFLAGS} -L$(i386-brew --prefix $lib)/lib"
  export CPPFLAGS="${CPPFLAGS} -I$(i386-brew --prefix $lib)/include"
  export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:$(i386-brew --prefix $lib)/lib/pkgconfig"
done

prefix=/opt/i386/python3.7.10/install
mkdir -p "$prefix"
./configure --with-ssl --with-zlib --with-readline --with-zlib --prefix=$prefix
make -j7
make test
make install
