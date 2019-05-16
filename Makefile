DEFAULT_DEPS        = base tpm vundle zplug

DOTFILES_DIR        = $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
DOTFILES_MKDIR_DIRS = find $(DOTFILES_DIR)$(1) -name '.mkdir' | sed -E 's|^$(DOTFILES_DIR)$(1)/(.+)/.mkdir$$|\1|g'
DOTFILES_STOW       = stow -d $(DOTFILES_DIR) -t $(HOME) -v --ignore='\.mkdir$$' --override='.*'

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
	cd $(HOME) && $(call DOTFILES_MKDIR_DIRS,$(1)) | xargs -r mkdir -pv
	$(DOTFILES_STOW) $(1)
endef

define UNSTOW
	$(DOTFILES_STOW) -D $(1)
	cd $(HOME) && $(call DOTFILES_MKDIR_DIRS,$(1)) | sort -r | (\
		while read DIR; do \
			[ -d $${DIR} ] && echo $${DIR}; \
		done \
	) | xargs -r rmdir --ignore-fail-on-non-empty -v
endef

.PHONY: default
default: $(DEFAULT_DEPS)

.PHONY: base
base:
	$(call STOW,base)

.PHONY: i3
i3:
	$(call STOW,i3)

.PHONY: tpm
tpm: base
	$(call PULL_OR_CLONE,$(TPM_REPO),$(TPM_BRANCH),$(TPM_DIR))
	tmux start-server \; source $(TMUX_CONF) \; run-shell $(TPM_INSTALL_PLUGINS)

.PHONY: vundle
vundle: base
	$(call PULL_OR_CLONE,$(VUNDLE_REPO),$(VUNDLE_BRANCH),$(VUNDLE_DIR))
	vim -c VundleInstall -c exit -c exit

.PHONY: zplug
zplug: base
	$(call PULL_OR_CLONE,$(ZPLUG_REPO),$(ZPLUG_BRANCH),$(ZPLUG_DIR))
	zsh -c 'source $(ZSH_RC)'

.PHONY: clean-default
clean: $(addprefix clean-, $(DEFAULT_DEPS))

.PHONY: clean-base
clean-base:
	$(call UNSTOW,base)

.PHONY: clean-i3
clean-i3:
	$(call UNSTOW,i3)

.PHONY: clean-tpm
clean-tpm:
	rm -rfv $(TPM_DIR)

.PHONY: clean-vundle
clean-vundle:
	rm -rfv $(VUNDLE_DIR)

.PHONY: clean-zplug
clean-zplug:
	rm -rfv $(ZPLUG_DIR)
