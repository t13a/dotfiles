# dotfiles

My personal dotfiles.

## Prerequisites

- `bash`
- `git`
- `stow`

## Bootstrap

```sh
$ curl -L https://git.io/fAGDT | bash
```

## Usage

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
