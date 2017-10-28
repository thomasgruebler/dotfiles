# Myconf

Repository for managing and distributing my personal dotfiles across various unix systems.

## Structure
| Folder | Info                             |
|--------|----------------------------------|
| bin    | Folder symlinked to ~/bin/myconf |
| home   | Contents symlinked to ~/         |

## Setup
```
cd && git clone git@github.com:thomasgruebler/dotfiles.git ~/.myconf && ~/.myconf/bin/myc -i
```

### Configure git
Don't forget to change your name and email after using the contained `.gitconfig`
```
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
```

### Acknowledgements
The repository was forked from github user flowm, who teached me how to use the command line so efficient. Thanks :)
