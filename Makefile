STOW_DIR  = $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

TPM_REPO      = https://github.com/tmux-plugins/tpm
TPM_BRANCH    = master
TPM_DIR       = $(HOME)/.tmux/plugins/tpm

VUNDLE_REPO   = https://github.com/VundleVim/Vundle.vim
VUNDLE_BRANCH = master
VUNDLE_DIR    = $(HOME)/.vim/bundle/Vundle.vim

ZPLUG_REPO    = https://github.com/zplug/zplug
ZPLUG_BRANCH  = master
ZPLUG_DIR     = $(HOME)/.zplug

define PULL_OR_CLONE
	mkdir -pv $(3)
	if [ -d $(3)/.git ]; then \
		cd $(3); \
		git pull; \
	else \
		git clone -b $(2) $(1) $(3); \
	fi
endef

define STOW
	cd $(HOME) \
	&& find $(STOW_DIR)$(1) -name '.no-folding' \
		| sed -E 's|^$(STOW_DIR)$(1)/(.+)/\.no-folding$$|\1|g' \
		| xargs -r mkdir -pv
	stow \
		-d $(STOW_DIR) \
		-t $(HOME) \
		-v --ignore='\.no-folding$$' \
		$(STOW_EXTRA_OPTS) \
		$(1)
endef

.PHONY: default
default: base tpm vundle zplug

.PHONY: base
base:
	$(call STOW,base)

.PHONY: gnome
gnome:
	$(call STOW,gnome)

.PHONY: i3
i3:
	$(call STOW,i3)

.PHONY: tpm
tpm: base
	$(call PULL_OR_CLONE,$(TPM_REPO),$(TPM_BRANCH),$(TPM_DIR))
	tmux start-server \
		\; source $(HOME)/.tmux.conf \
		\; run-shell $(TPM_DIR)/bindings/install_plugins

.PHONY: vundle
vundle: base
	$(call PULL_OR_CLONE,$(VUNDLE_REPO),$(VUNDLE_BRANCH),$(VUNDLE_DIR))
	vim -c VundleInstall -c exit -c exit

.PHONY: zplug
zplug: base
	$(call PULL_OR_CLONE,$(ZPLUG_REPO),$(ZPLUG_BRANCH),$(ZPLUG_DIR))
	zsh -c 'source $(HOME)/.zshrc'
