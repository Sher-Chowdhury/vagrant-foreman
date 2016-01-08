#!/bin/bash
# Some useful plugins: http://vimawesome.com/

## The following gems are needed:
gem install puppet-lint              # http://puppet-lint.com/
gem install puppet-syntax


mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim


cd ~/.vim/bundle
git clone https://github.com/scrooloose/syntastic.git
git clone git://github.com/rodjek/vim-puppet.git
git clone git://github.com/godlygeek/tabular.git
git clone https://github.com/scrooloose/nerdtree.git



# vim snippets and shipmate:

git clone https://github.com/tomtom/tlib_vim.git
git clone https://github.com/MarcWeber/vim-addon-mw-utils.git
git clone https://github.com/garbas/vim-snipmate.git
git clone https://github.com/honza/vim-snippets.git

echo "execute pathogen#infect()" > ~/.vimrc
echo "syntax on" >> ~/.vimrc
echo "filetype plugin indent on" >> ~/.vimrc
echo "filetype on" >> ~/.vimrc
echo "set statusline+=%#warningmsg#" >> ~/.vimrc
echo "set statusline+=%{SyntasticStatuslineFlag()}" >> ~/.vimrc
echo "set statusline+=%*" >> ~/.vimrc
echo "let g:syntastic_always_populate_loc_list = 1" >> ~/.vimrc
echo "let g:syntastic_auto_loc_list = 1" >> ~/.vimrc
echo "let g:syntastic_check_on_open = 1" >> ~/.vimrc
echo "let g:syntastic_check_on_wq = 1" >> ~/.vimrc

# http://vim.wikia.com/wiki/Indenting_source_code
echo "set expandtab" >> ~/.vimrc
echo "set shiftwidth=2" >> ~/.vimrc
echo "set softtabstop=2" >> ~/.vimrc
# In vim, to automatically reindent, do "gg=G" while in vim's navigation mode. 


echo 'PATH=$PATH:/home/vagrant/bin' >> /home/vagrant/.bashrc  # this is to get puppet lint to work. 


# here's some extra configurations to make vim easier to use:

cat /vagrant/files/.vimrc >> ~/.vimrc

echo "--no-80chars-check" >> ~/.puppet-lint.rc    # http://stackoverflow.com/questions/29206887/puppet-lint-configuration-file
                                                  # https://github.com/rodjek/puppet-lint#puppet-lint-1

