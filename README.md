# dotfiles

My personal dotfiles.

## Prerequisites

- `bash`
- `git`
- `stow`

## Usage

### Bootstrap

```sh
$ curl -L https://git.io/fAGDT | bash
```

or

```sh
$ curl -L https://raw.githubusercontent.com/t13a/dotfiles/master/bootstrap | bash
```

### Push changes

```sh
$ dotfiles git add FILE...
$ dotfiles git commit -m MESSAGE
$ dotfiles git push origin
```

### Pull changes (experimental)

```sh
$ dotfiles sync
```
