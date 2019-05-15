DOTFILES_DIR        = $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

TMUX_CONF           = $(HOME)/.tmux.conf

TPM_REPO            = https://github.com/tmux-plugins/tpm
TPM_BRANCH          = master
TPM_DIR             = $(HOME)/.tmux/plugins/tpm
TPM_INSTALL_PLUGINS = $(TPM_DIR)/bindings/install_plugins

VUNDLE_REPO         = https://github.com/VundleVim/Vundle.vim
VUNDLE_BRANCH       = master
VUNDLE_DIR          = $(HOME)/.vim/bundle/Vundle.vim

ZPLUG_REPO          = https://github.com/zplug/zplug
ZPLUG_BRANCH        = master
ZPLUG_DIR           = $(HOME)/.zplug

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
default: base tpm vundle zplug

.PHONY: base
base:
	$(call STOW,base)

.PHONY: i3
i3:
	$(call STOW,base)

.PHONY: tpm
tpm: base
	$(call GIT,$(TPM_REPO),$(TPM_BRANCH),$(TPM_DIR))
	tmux start-server \; source $(TMUX_CONF) \; run-shell $(TPM_INSTALL_PLUGINS)

.PHONY: vundle
vundle: base
	$(call GIT,$(VUNDLE_REPO),$(VUNDLE_BRANCH),$(VUNDLE_DIR))
	vim -c VundleInstall -c exit -c exit

.PHONY: zplug
zplug: base
	$(call GIT,$(ZPLUG_REPO),$(ZPLUG_BRANCH),$(ZPLUG_DIR))
	zsh -c 'source $(ZSH_RC)'
