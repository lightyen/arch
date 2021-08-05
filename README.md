# Arch Linux Installation Guide

## Make liveCD

[rufus](https://github.com/pbatard/rufus)
[etcher](https://github.com/balena-io/etcher)

## Insert liveCD

First, switch to pretty terminal font:

```sh
setfont ter-132n.psf.gz
```

Connect to the internet, if wireless, use iwctl:

```sh
iwctl
```

Update the system clock:

```sh
timedatectl set-ntp true
```

## Partition

Check devices and create your partitions:

```sh
fdisk -l
gdisk
cgdisk
```

Format FAT32, format ext4 file system:

```sh
mkfs.fat -F32 $boot
mkfs.ext4 $root
mkfs.ext4 $home
```

Mount `root` and `esp` devices:

```sh
# boot=/dev/nvme0n1p1
# root=/dev/nvme0n1p3
mount $root /mnt
mkdir /mnt/{boot,home}
mount $boot /mnt/boot
mount $home /mnt/home

# swap=/dev/nvme0n1p2
# mkswap $swap
# swapon $swap
```

Install basic packages:

```sh
pacstrap -i /mnt base linux
pacstrap -i /mnt base-devel linux-firmware vim
# pacstrap -i /mnt intel-ucode
# pacstrap -i /mnt amd-ucode
```

Generate fstab:

```sh
genfstab -U /mnt >> /mnt/etc/fstab
```

Move to root directory:

```sh
arch-chroot /mnt
```

## systemd-boot

Edit `/boot/loader/loader.conf`:

```txt
default arch
```

```sh
bootcfg=/boot/loader/entries/arch.conf
echo "title Arch Linux" > $bootcfg
echo "linux /vmlinuz-linux" >> $bootcfg
# echo "initrd /intel-ucode.img" >> $bootcfg
# echo "initrd /amd-ucode.img" >> $bootcfg
echo "initrd /initramfs-linux.img" >> $bootcfg
echo "options root=PARTUUID=$(blkid -s PARTUUID -o value $root) rw" >> $bootcfg
```

Install systemd-boot:

```sh
bootctl install
```

> If there are old items in EFI, use `efibootmgr` to remove them.

## Root password

```sh
passwd
```

## Locale (always en_US)

```sh
sed -i '/^#\(en_US.UTF-8 UTF-8\)/\1/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
```

## Time

```sh
# timezone=Asia/Taipei
ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
hwclock --systohc
```

## Network

### local

```sh
# hostname=lightyen-pc
echo $hostname > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 $hostname.localdomain $hostname" >> /etc/hosts
```

### ssh

```sh
pacman -S openssh
systemctl enable sshd
systemctl start sshd
```

### NetworkManager

```sh
pacman -S networkmanager
systemctl enable NetworkManager
```

### buletooth

```sh
systemctl enable bluetooth
```

### pacman

```sh
# mirrorlist=/etc/pacman.d/mirrorlist

pacman -S pacman-contrib
curl -fsSL "https://archlinux.org/mirrorlist/?country=TW&protocol=https&ip_version=4&ip_version=6" -o $mirrorlist
sed -i 's/^#\(.*\)/\1/' $mirrorlist
cp $mirrorlist $mirrorlist.backup
rankmirrors -n 5 $mirrorlist.backup > $mirrorlist
rm $mirrorlist.backup
pacman -Sy
```

## Add administrators

```sh
useradd -G wheel -m <username>
passwd <username>
EDITOR=vim visudo
```

Remove liveCD and reboot.

---

## Shell

### zsh

```sh
pacman -S zsh git
```

#### oh-my-zsh

Install oh-my-zsh:

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Change theme:

```sh
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/1' ~/.zshrc
```

#### zsh-completions

Clone the repository inside your oh-my-zsh repo:

```sh
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins/zsh-completions
```

Enable it in your .zshrc by adding it to your plugin list and reloading the completion:

```sh
plugins=(… zsh-completions)
autoload -U compinit && compinit
```

#### zsh-autosuggestions

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

.zshrc

```sh
plugins=(… zsh-autosuggestions)
```

## AUR

### yay

```sh
pacman -S --needed base-devel
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
```

### paru

```sh
pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

## Editor(Vim)

### vundle

```sh
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
```

Create `.vimrc` in `$HOME`:

```vimrc
set encoding=utf-8
set history=3000
set ttimeoutlen=50

set tabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

set signcolumn=yes
syntax enable
syntax on
set hls
set termguicolors

filetype off
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-commentary'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'joshdick/onedark.vim'
call vundle#end()
filetype plugin indent on

if &term == "alacritty"
  let &term = "xterm-256color"
endif

let g:powerline_pycmd = 'py3'

" itchyny/lightline settings
set laststatus=2

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

colorscheme onedark


set numberwidth=4
set runtimepath+=$HOME/.vim/plugins/vim-gitgutter
let g:gitgutter_async = 0
let g:gitgutter_enabled = 0
set autochdir
let NERDTreeChDirMode=2
au VimEnter NERD_tree_1 enew | execute 'NERDTree '.argv()[0]


" NERDTree
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }


" YouCompleteMe
let g:ycm_use_clangd = 0

" Prettier
let g:prettier#autoformat = 1

highlight LineNr guifg=#BD93F9 guibg=#303030

set listchars=tab:→\ ,space:\ ,extends:⟩,precedes:⟨
set list

set noerrorbells             " No beeps
set number                   " Show line numbers
set noswapfile               " Don't use swapfile
set showcmd                  " Show me what I'm typing
set nobackup                 " Don't create annoying backup files
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows
set autowrite                " Automatically save before :next, :make etc.
set hidden
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set noshowmatch              " Do not show matching brackets by flickering
set noshowmode               " We show the mode with airline or lightline
set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case
set completeopt=menu,menuone
set nocursorcolumn           " speed up syntax highlighting
set cursorline               " show the focus line
set updatetime=500
set pumheight=10             " Completion window max size
set conceallevel=2           " Concealed text is completely hidden
set nowrap
set autoread
set clipboard=unnamedplus

" Keyboard mapping
nnoremap <C-c> "+yy
nnoremap <C-v> "+p
nnoremap <A-Down> :m+<CR>==
nnoremap <A-Up> :m .-2<CR>==
nnoremap <ESC>j :m+<CR>==
nnoremap <ESC>k :m .-2<CR>==
nnoremap <F2> :set nu!<CR>
nnoremap <F4> :set list!<CR>
nnoremap <F5> :set rnu!<CR>
nnoremap <F3> :set hlsearch!<CR>
nnoremap <F9> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTree .<CR>

" Output the current syntax group
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>
```

Then run `:PluginInstall`

---

# Archlinux window environment

## Fonts

[https://wiki.archlinux.org/title/Font](https://wiki.archlinux.org/title/Fonts)

## Software

### SDDM

```sh
pacman -Syu

pacman -S sddm sddm-kcm
systemctl enable sddm
```

### GVim

```sh
pacman -S gvim
```

### Input Method(fcitx)

```sh
pacman -S fcitx kcm-fcitx fcitx-chewing fcitx-configtool
echo "INPUT_METHOD=fcitx"  >> /etc/environment
echo "GTK_IM_MODULE=fcitx" >> /etc/environment
echo "QT_IM_MODULE=fcitx" >> /etc/environment
echo "XMODIFIERS=@im=fcitx" >> /etc/environment
```

### VirtualBox

```sh
pacman -S virtualbox-host-modules-arch
```


### Edge

```sh
git clone https://aur.archlinux.org/microsoft-edge-beta-bin.git
makepkg -si
```

### VScode

```sh
git clone https://aur.archlinux.org/visual-studio-code-bin.git
makepkg -si
```

### KDE

```sh
pacman -S plasma kde-applications
```

### bspwm

[https://wiki.archlinux.org/title/bspwm](https://wiki.archlinux.org/title/bspwm)

```sh
pacman -S xorg bspwm sxhkd picom dmenu nitrogen alacritty lxappearance nautilus file-roller
```

```sh
echo "xrandr --dpi 120 &" >> ~/.xprofile
echo "picom --experimental-backends &" >> ~/.xprofile
echo "fcitx &" >> ~/.xprofile
echo "nitrogen --restore &" >> ~/.xprofile
```

```txt
# /etc/xdg/picom.conf

...

backend = "glx";


```

`sxhkdrc`:

```sh
super + Return
    alacritty

ctrl + alt + t
    alacritty

super + {r}
    bspc node @/ -R 180

super + shift + {r}
    bspc node @/ -R 90
```

Change DPI to 1.25:

```txt
# ~/.Xresources
Xft.dpi: 120

xrandr --dpi 120
```

### titlebar

polybar

## Hardware

### Audio

```sh
pacman -S alsa-utils
alsactl init
alsamixer
```

### Video

```sh
# optional
# pacman -S xf86-video-[intel/nvidia/amdgpu/ati/vesa/nouveau]
```

### Network problem

related: `/etc/NetworkManager/system-connections/wired1.nmconnection`

```sh
nmcli connection modify <conn> ipv4.dns "8.8.8.8,1.1.1.1"
nmcli connection modify <conn> ipv4.ignore-auto-dns yes
nmcli connection modify <conn> connection.autoconnect yes
nmcli connection down <conn>
nmcli connection up <conn>
```
