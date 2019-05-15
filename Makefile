DOTFILES_DIR        = $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

TMUX_CONF           = $(HOME)/.tmux.conf

TPM_REPO            = https://github.com/tmux-plugins/tpm
TPM_BRANCH          = master
TPM_DIR             = $(HOME)/.tmux/plugins/tpm
TPM_INSTALL_PLUGINS = $(TPM_DIR)/bindings/install_plugins

VUNDLE_REPO         = https://github.com/VundleVim/Vundle.vim
VUNDLE_BRANCH       = master
VUNDLE_DIR          = $(HOME)/.vim/bundle/Vundle.vim

ZSH_RC              = $(HOME)/.zshrc

define GIT
	mkdir -pv $(3)
	if [ -d $(3)/.git ]; \
	then \
			cd $(3); \
			git pull; \
	else \
			git clone -b $(2) $(1) $(3); \
	fi
endef

define STOW
	find $(DOTFILES_DIR)$(1) -name '.nostow' | sed -E 's|^$(DOTFILES_DIR)$(1)/(.+)/.nostow$$|\1|g' | xargs -r mkdir -pv
	stow --dir=$(DOTFILES_DIR) --target=$(HOME) --verbose --override='.*' $(1)
endef

.PHONY: default
default: base tmux vim zsh

.PHONY: base
base:
	$(call STOW,base)

.PHONY: i3
i3:
	$(call STOW,base)

.PHONY: tmux
tmux: base
	$(call GIT,$(TPM_REPO),$(TPM_BRANCH),$(TPM_DIR))
	tmux start-server \; source $(TMUX_CONF) \; run-shell $(TPM_INSTALL_PLUGINS)

.PHONY: vim
vim: base
	$(call GIT,$(VUNDLE_REPO),$(VUNDLE_BRANCH),$(TPM_DIR))
	vim -c VundleInstall -c exit -c exit

.PHONY: zsh
zsh: base
	zsh -c 'source $(ZSH_RC)'
