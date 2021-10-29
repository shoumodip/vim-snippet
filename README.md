# vim-snippet
Snippets in vim, as minimal as possible.

## Quick start
- Install this plugin

### [Vim Plug](https://github.com/junegunn/vim-plug)
```vim
Plug 'shoumodip/vim-snippet'
PlugInstall
```

### [Vundle](https://github.com/VundleVim/Vundle.vim)
```vim
Plugin 'shoumodip/vim-snippet'
PluginInstall
```

### [Dein](https://github.com/Shougo/dein.vim)
```vim
call dein#add('shoumodip/vim-snippet')
call dein#install()
```

### [Minpac](https://github.com/k-takata/minpac)
```vim
call minpac#add('shoumodip/vim-snippet')
```

### Packages
```console
$ git clone https://github.com/shoumodip/vim-snippet ~/.vim/pack/plugins/start/
$ git clone https://github.com/shoumodip/vim-snippet ~/.config/nvim/pack/plugins/start/
```

- Create the directory `~/.vim/snippets` (`~/.config/nvim/snippets` for Neovim)

```console
$ mkdir -p ~/.vim/snippets
$ mkdir -p ~/.config/nvim/snippets
```

- Copy the snippets in the `~/examples` directory

```console
$ cp -rf examples/* ~/.vim/snippets/
$ cp -rf examples/* ~/.config/nvim/snippets/
```

## Usage
- Use `<tab>` to expand snippets
- Use `<tab>` to jump to cursor markers
- Use `Snippet` to create snippets
- See the snippets in `examples/` for understanding the snippet format
- See `:h snippet.txt`
