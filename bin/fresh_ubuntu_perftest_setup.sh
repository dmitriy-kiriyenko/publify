#!/bin/bash

sudo apt update
sudo apt install git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev libpq-dev postgresql postgresql-contrib nodejs
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

git clone https://github.com/rbenv/ruby-build.git
PREFIX=/usr/local sudo ./ruby-build/install.sh

rbenv install 3.0.3
echo "gem: --no-document" > ~/.gemrc

gem install bundler
bundle install

sudo -u postgres createuser -s -i -d -r -l -w publify
sudo -u postgres psql -c "ALTER ROLE publify WITH PASSWORD 'publify';"

bundle exec rake db:setup db:migrate db:seed

echo 'start server and run performance tests'
