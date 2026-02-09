#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/spotify-adblocker}"
BIN_DIR="${BIN_DIR:-$HOME/.local/bin}"
VERSION="${VERSION:-latest}"

detect_os() {
  case "$(uname -s)" in
    Linux) echo "linux" ;;
    Darwin) echo "darwin" ;;
    *) echo "unsupported" ;;
  esac
}

detect_arch() {
  case "$(uname -m)" in
    x86_64|amd64) echo "amd64" ;;
    arm64|aarch64) echo "arm64" ;;
    *) echo "unsupported" ;;
  esac
}

download_file() {
  local url="$1"
  local out="$2"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$out"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$out" "$url"
  else
    echo "curl or wget is required." >&2
    exit 1
  fi
}

install_app() {
  mkdir -p "$INSTALL_DIR"

  local os_name
  os_name=$(detect_os)
  if [[ "$os_name" == "unsupported" ]]; then
    echo "Unsupported OS." >&2
    exit 1
  fi

  local arch
  arch=$(detect_arch)
  if [[ "$arch" == "unsupported" ]]; then
    echo "Unsupported architecture." >&2
    exit 1
  fi

  local version_path="$VERSION"
  if [[ "$VERSION" == "latest" ]]; then
    version_path="latest"
  else
    version_path="download/$VERSION"
  fi

  local base_url="https://github.com/ryxu-xo/spotiblock/releases/$version_path"
  local raw_url="https://raw.githubusercontent.com/ryxu-xo/spotiblock/main"
  local binary_name="spotiblock-$os_name-$arch"
  download_file "$base_url/$binary_name" "$INSTALL_DIR/spotiblock"
  chmod +x "$INSTALL_DIR/spotiblock"
  download_file "$raw_url/config.json" "$INSTALL_DIR/config.json"

  mkdir -p "$BIN_DIR"
  cat > "$BIN_DIR/spotiblock" <<EOF
#!/usr/bin/env bash
"$INSTALL_DIR/spotiblock" "\$@"
EOF
  chmod +x "$BIN_DIR/spotiblock"

  if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo "Added spotiblock to $BIN_DIR. Ensure it is on your PATH." >&2
  fi
}

install_app
