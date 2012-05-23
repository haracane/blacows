cd ~/src
curl -O http://mecab.googlecode.com/files/mecab-0.993.tar.gz
tar zxvf mecab-0.993.tar.gz
./configure
make
sudo make install

cd ~/src
wget http://mecab.googlecode.com/files/mecab-ipadic-2.7.0-20070801.tar.gz
tar zxvf mecab-ipadic-2.7.0-20070801.tar.gz
cd mecab-ipadic-2.7.0-20070801/
./configure --with-charset=utf8
make
sudo make install


cd ~/src
curl -O http://mecab.googlecode.com/files/mecab-ruby-0.993.tar.gz
tar zxvf mecab-ruby-0.993.tar.gz
cd mecab-ruby-0.993
ruby extconf.rb
make
sudo make install
