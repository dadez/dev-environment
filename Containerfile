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
ENV USER=dadez
ENV HOME=/home/${USER}
ENV SHELL=/usr/bin/zsh

RUN useradd -m -s /bin/zsh ${USER}

# create directories
RUN mkdir -p \
  ${HOME}/.config/zsh \
  ${HOME}/.local/state/zsh \
  ${HOME}/.config/nvim \
  ${HOME}/.local/share/nvim \
  ${HOME}/.local/state/nvim \
  ${HOME}/.cache/nvim \
  ${HOME}/.local/bin


COPY conf/k9s ${HOME}/.config/k9s
COPY conf/lazygit ${HOME}/.config/lazygit
COPY conf/mise ${HOME}/.config/mise
COPY conf/tmux ${HOME}/.config/tmux
COPY conf/zsh ${HOME}/.config/zsh

# Install lazyvim
# TODO: how to persist configuration
RUN git clone https://github.com/LazyVim/starter ${HOME}/.config/nvim \
  && rm -rf ${HOME}/.config/nvim/.git

RUN mkdir -p /workspace \
  && chown -R \
  1000:0 \
  ${HOME} \
  /workspace \
  && chmod -R u+rwX,g+rwX \
  ${HOME} \
  /workspace

USER ${USER}
WORKDIR ${HOME}

ENV PATH=${HOME}/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ENTRYPOINT [ "/usr/bin/zsh" ]
