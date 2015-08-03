#!/bin/bash
# Some useful plugins: http://vimawesome.com/

## The following gems are needed:
gem install puppet-lint 
gem install puppet-syntax


mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim


cd ~/.vim/bundle
git clone https://github.com/scrooloose/syntastic.git
git clone git://github.com/rodjek/vim-puppet.git
git clone git://github.com/godlygeek/tabular.git
git clone https://github.com/scrooloose/nerdtree.git

echo "execute pathogen#infect()"
echo "syntax on"
echo "filetype plugin indent on"
echo "filetype on"
echo "set statusline+=%#warningmsg#"
echo "set statusline+=%{SyntasticStatuslineFlag()}"
echo "set statusline+=%*"
echo "let g:syntastic_always_populate_loc_list = 1"
echo "let g:syntastic_auto_loc_list = 1"
echo "let g:syntastic_check_on_open = 1"
echo "let g:syntastic_check_on_wq = 1"


