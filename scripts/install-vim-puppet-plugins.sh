#!/bin/bash

# How to run vagrant provision script as non root user:  config.vm.provision :shell, :path => "setup-nodejs.sh", privileged: false


## The following gems are needed:
# gem install puppet-lint 
# gem install puppet-syntax



echo "execute pathogen#infect()" > ~/.vimrc
echo "syntax on" >> ~/.vimrc
echo "filetype plugin indent on" >> ~/.vimrc



echo "set statusline+=%#warningmsg#"  >> ~/.vimrc
echo "set statusline+=%{SyntasticStatuslineFlag()}" >> ~/.vimrc
echo "set statusline+=%*" >> ~/.vimrc
echo "let g:syntastic_always_populate_loc_list = 1" >> ~/.vimrc
echo "let g:syntastic_auto_loc_list = 1" >> ~/.vimrc
echo "let g:syntastic_check_on_open = 1" >> ~/.vimrc
echo "let g:syntastic_check_on_wq = 1" >> ~/.vimrc
echo "let g:syntastic_puppet_checkers = ['puppet']" >> ~/.vimrc
echo "let g:syntastic_puppet_checkers = ['puppetlint']" >> ~/.vimrc






mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim


cd ~/.vim/bundle
git clone https://github.com/scrooloose/syntastic.git
git clone git://github.com/rodjek/vim-puppet.git
git clone git://github.com/godlygeek/tabular.git

#systemctl restart NetworkManager
#systemctl restart network
