#!/bin/bash
echo "Welcome to ONE"
echo "Lets begin the install now"
echo "Time to ensure all required gems are installed"
cd src
gem install bundler
bundle install
echo "All gems have been installed, running application for the first time now"
ruby ./one.rb
