# dotfiles

My personal dotfiles.

## Prerequisites

- `git`
- `make`
- `stow`

## Installation

```sh
$ git clone https://github.com/t13a/dotfiles
$ cd dotfiles
$ make
```

## Hacks

### Delete stowed package

```sh
$ make -e STOW_EXTRA_OPTS='--no-folding -D' PACKAGE...
```

## Development

```
$ docker build -t dotfiles .
$ docker run -it --rm dotfiles
```
