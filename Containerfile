FROM archlinux:latest
LABEL image.authors="dadez@pm.me" \
  image.title="Devtoolbox image" \
  image.description="Image for run daily tools"

# Install packages
RUN pacman -Syu --noconfirm \
  git git-delta lazygit \
  wget curl unzip \
  fish \
  zsh zsh-autocomplete zsh-autosuggestions zsh-completions zsh-syntax-highlighting \
  bat dos2unix entr fd fzf go-yq jq lsd eza ripgrep starship yamllint yazi zoxide \
  helm k9s kubectl kubectx kubie stern \
  vim neovim tree-sitter-cli \
  tmux

# Install non packaged tools
SHELL [ "/bin/bash", "-o", "pipefail", "-c" ]

# Mise
ENV MISE_VERSION="v2026.10.24"

RUN set -uxe \
  && ARCH="$(uname -m | sed 's/x86_64/x64/;s/aarch64/arm64/')" \
  && curl -Ss --fail-with-body -L "https://github.com/jdx/mise/releases/download/${MISE_VERSION}/mise-${MISE_VERSION}-linux-${ARCH}.tar.gz" \
  | tar -xz --strip-components=2 -C /usr/local/bin mise/bin/mise

# TODO: install oc binary

# Configure zsh environment
RUN cat <<'EOF' >> /etc/zsh/zshenv
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
EOF

# Create user
RUN useradd -m -s /bin/zsh dadez

USER dadez
WORKDIR /home/dadez/
RUN umask 0002

# create directories
RUN mkdir -p \
  .config/zsh \
  .local/state/zsh \
  .config/nvim \
  .local/share/nvim \
  .local/state/nvim \
  .cache/nvim

RUN git clone https://github.com/LazyVim/starter .config/nvim \
  && rm -rf .config/nvim/.git

COPY conf/k9s .config/k9s
COPY conf/lazygit .config/lazygit
COPY conf/mise .config/mise
COPY conf/tmux .config/tmux
COPY conf/yazi .config/yazi
COPY conf/zsh .config/zsh

ENTRYPOINT [ "/bin/zsh" ]









