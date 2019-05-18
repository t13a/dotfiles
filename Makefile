STOW_DIR      = $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
STOW_TARGETS  = $(shell find $(STOW_DIR) -mindepth 1 -maxdepth 1 -name '[^.]*' -type d -printf '%f\n')

SYNC_TARGETS  = tpm vundle zplug

TPM_DIR       = $(HOME)/.tmux/plugins/tpm
TPM_REPO      = https://github.com/tmux-plugins/tpm

VUNDLE_DIR    = $(HOME)/.vim/bundle/Vundle.vim
VUNDLE_REPO   = https://github.com/VundleVim/Vundle.vim

ZPLUG_DIR     = $(HOME)/.zplug
ZPLUG_REPO    = https://github.com/zplug/zplug

.PHONY: default
default: base tmux vim zsh

.PHONY: tmux
tmux: base tpm
	tmux start-server \
		\; source $(HOME)/.tmux.conf \
		\; run-shell $(TPM_DIR)/bindings/install_plugins

.PHONY: vim
vim: base vundle
	vim -c VundleInstall -c exit -c exit

.PHONY: zsh
zsh: base zplug
	zsh -c 'source $(HOME)/.zshrc'

define STOW
.PHONY: $(1)
$(1):
	cd $(HOME) \
	&& find $(STOW_DIR)$(1) -name '.no-folding' \
		| sed -E 's|^$(STOW_DIR)$(1)/(.+)/\.no-folding$$$$|\1|g' \
		| xargs -r mkdir -pv
	stow -d $(STOW_DIR) -t $(HOME) -v --ignore='\.no-folding$$$$' $(1)
endef
$(foreach _,$(STOW_TARGETS),$(eval $(call STOW,$_)))

define SYNC
.PHONY: $(1)
$(1):
	mkdir -pv $$($(2)_DIR)
	if [ -d $$($(2)_DIR)/.git ]; then \
		cd $$($(2)_DIR) \
		&& git pull; \
	else \
		git clone \
			-b $$(if $$($(2)_BRANCH),$$($(2)_BRANCH),master) \
			$$($(2)_REPO) \
			$$($(2)_DIR); \
	fi
endef
$(foreach _,$(SYNC_TARGETS),$(eval $(call SYNC,$_,$(shell echo $_ \
	| tr '[:lower:]' '[:upper:]' \
	| sed 's/[^A-Z0-9]/_/g'))))

define UNSTOW
.PHONY: unstow-$(1)
unstow-$(1):
	stow -d $(STOW_DIR) -t $(HOME) -v --no-folding -D $(1)
endef
$(foreach _,$(STOW_TARGETS),$(eval $(call UNSTOW,$_)))
