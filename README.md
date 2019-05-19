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

### Delete stowed packages

```sh
$ make unstow-<package>...
```

## Development

```
$ docker build -t dotfiles .
$ docker run -it --rm dotfiles
```

## References

- [Systemd sleep.target for user level](https://medium.com/@aiguofer/systemd-sleep-target-for-user-level-10eb003b3bfd)
