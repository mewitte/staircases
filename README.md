# Enhanced Vertical Staircases

This project takes inspiration from [Marin's Enhanced Staircases](https://reliccastle.com/resources/396/) and aims to provide similar functionality for vertical stair movement: "The script provides pixel movement while walking on staircases, while also lsowing down movement to capture the real feeling and motion of a staircase."`

## Usage

## Installation

## Development Setup

I chose following development setup on Windows 10:

* [WSL](https://docs.microsoft.com/en-us/windows/wsl/install) with Debian installed from the Microsoft Store. Open Debian and follow the inital setup
  * I chose WSL specifically for the easier installation of ruby and the gem bundler with rbenv. This is used i.e. for rubocop, a linter (checks for best practices in code style), make sure to select `Add to PATH` during installation to let WSL know about it
* [VSCode](https://code.visualstudio.com/)
  * Also install the plugin [Remote - WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl)
* Install dependencies and ruby in Debian Command Line

  ```bash
  sudo apt install git rbenv

  # add the following two lines at the end of your ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc

  # this will apply the changes you made to the configuration
  source ~/.bashrc

  # this installs a plugin for easier ruby installation
  mkdir -p "$(rbenv root)"/plugins && git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

  # this takes several minutes
  rbenv install 3.1.2 && rbenv global 3.1.2

  # check if your ruby installation was successful
  curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash

  # install gems for VSCode plugins
  gem install rubocop

  # this creates a custom script for rubocop to make it work with the WSL setup
  rm -f ~/rubocop
  echo "#!/bin/zsh" >> ~/rubocop
  echo "/home/melvinw/.rbenv/shims/bundle exec rubocop --format json" >> ~/rubocop
  chmod +x ~/rubocop
  ```

* Clone this project into a folder in your home and open it in code ([how to clone a repo](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) )
  * `git clone git@github.com:mewitte/staircases.git enhanced_vertical_staircases && cd enhanced_vertical_staircases`
  * `bundle install`
  * `code .`
  * This should open the project after installing the VSCode Remote Server for WSL. I would recommend using the VSCode terminal from now on (`` CTRL + \` ``)
* Install VSCode plugins after opening the folder
  * [Ruby](https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby)
  * [ruby-rubocop](https://marketplace.visualstudio.com/items?itemName=misogi.ruby-rubocop)
* Open the settings with `CTRL + ,` and change the following (optional, apart from Rubocop setting)
  * Set `Rubocop: Execute Path` to `~/`
  * Enable `Rubocop: Use Bundler`
  * Set `Editor: Tab Size` to `2`
  * Enable `Files: Insert Final Newline`
  * Enable `Files: Trim Final Newlines`
  * Enable `Files: Trim Final Whitespace`
  * Set `Files: Auto Save` to `afterDelay`
  * Set `Files: Auto Save Delay` to `999` to enable instant auto saving
