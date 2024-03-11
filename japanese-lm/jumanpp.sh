export BUILD=/tmp/jumanpp
export PREFIX=/usr

mkdir -p $BUILD
cd $BUILD
wget https://github.com/ku-nlp/jumanpp/releases/download/v2.0.0-rc4/jumanpp-2.0.0-rc4.tar.xz -O jumanpp.tar.xz
tar xvf jumanpp.tar.xz
rm jumanpp.tar.xz
mv jumanpp-2.0.0-rc4 jumanpp-src
cmake jumanpp-src \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX
make install -j8
