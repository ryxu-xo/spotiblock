# Spotify Adblocker (Local Hosts)

![Go Version](https://img.shields.io/badge/go-1.22-blue)
![Release](https://img.shields.io/github/v/release/ryxu-xo/spotiblock)
![Downloads](https://img.shields.io/github/downloads/ryxu-xo/spotiblock/total)
![Platform](https://img.shields.io/badge/platform-windows%20%7C%20macOS%20%7C%20linux-success)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

A cross-platform CLI tool that updates your system `hosts` file with a remote Spotify ad-domain list. Optional UI patching is included for hiding upgrade banners and ad containers.

No Python runtime is required when using the Go binary.

## Features

- Dynamic blocklist fetching via `config.json`
- Windows/macOS/Linux hosts file handling
- Admin/sudo detection
- Backup/restore with `hosts.bak`
- Clean uninstall with `--uninstall`
- DNS cache flush after updates
- Optional UI patch for `xpui.spa`

## Setup

1. Update the blocklist URL in `config.json`.
2. Build the Go binary or use the installer below.
3. Run `spotiblock apply` from an elevated shell (Admin/sudo) when updating hosts.

## Usage

### One-line Install (CLI style)

Windows (PowerShell):

```powershell
iwr -useb https://raw.githubusercontent.com/ryxu-xo/spotiblock/main/install.ps1 | iex
```

Pin a version (PowerShell):

```powershell
$env:Version = "v1.0.0"; iwr -useb https://raw.githubusercontent.com/ryxu-xo/spotiblock/main/install.ps1 | iex
```

macOS/Linux:

```bash
curl -fsSL https://raw.githubusercontent.com/ryxu-xo/spotiblock/main/install.sh | bash
```

Pin a version (macOS/Linux):

```bash
VERSION=v1.0.0 curl -fsSL https://raw.githubusercontent.com/ryxu-xo/spotiblock/main/install.sh | bash
```

The installers download these release assets:

- `spotiblock-windows-amd64.exe`
- `spotiblock-windows-arm64.exe`
- `spotiblock-linux-amd64`
- `spotiblock-linux-arm64`
- `spotiblock-darwin-amd64`
- `spotiblock-darwin-arm64`

After install, you can run:

```bash
spotiblock apply
```

Check status:

```bash
spotiblock status
```

### Windows (PowerShell as Administrator)

```powershell
spotiblock apply
```

Spotiblock-style command (after install):

```powershell
spotiblock apply
```

Check status:

```powershell
spotiblock status
```

Optional UI patch:

```powershell
spotiblock apply --patch-ui
```

Spotiblock-style:

```powershell
spotiblock apply --patch-ui
```

Uninstall:

```powershell
spotiblock uninstall
```

Spotiblock-style:

```powershell
spotiblock uninstall
```

### macOS (Terminal)

```bash
sudo spotiblock apply
```

Spotiblock-style (after install):

```bash
sudo spotiblock apply
```

Check status:

```bash
spotiblock status
```

Optional UI patch:

```bash
sudo spotiblock apply --patch-ui
```

Spotiblock-style:

```bash
sudo spotiblock apply --patch-ui
```

Uninstall:

```bash
sudo spotiblock uninstall
```

Spotiblock-style:

```bash
sudo spotiblock uninstall
```

### Linux (Terminal)

```bash
sudo spotiblock apply
```

Spotiblock-style (after install):

```bash
sudo spotiblock apply
```

Check status:

```bash
spotiblock status
```

Optional UI patch:

```bash
sudo spotiblock apply --patch-ui
```

Spotiblock-style:

```bash
sudo spotiblock apply --patch-ui
```

Uninstall:

```bash
sudo spotiblock uninstall
```

Spotiblock-style:

```bash
sudo spotiblock uninstall
```

## Configuration

Edit `config.json` (defaults to the x0uid blocklist and regex list):

```json
{
  "blocklist_url": "https://raw.githubusercontent.com/x0uid/SpotifyAdBlock/master/SpotifyBlocklist.txt",
  "regex_list_url": "https://raw.githubusercontent.com/x0uid/SpotifyAdBlock/master/regex.list"
}
```

If you installed via the one-line installer, the `config.json` file is placed next to the `spotiblock` binary.
You can also pass a custom config path with `--config`.

## Notes

- Hosts file backups are saved as `hosts.bak` next to the system hosts file.
- The UI patcher looks for `xpui.spa` in common install locations:
  - Windows: `%APPDATA%\Spotify\Apps\xpui.spa`
  - macOS: `/Applications/Spotify.app/Contents/Resources/Apps/xpui.spa`
  - Linux: `/usr/share/spotify/Apps/xpui.spa`
- If `regex_list_url` is set, those regex patterns are applied to `xpui.js` and `xpui.css` when using `--patch-ui`.

## Build From Source

```bash
go build -o spotiblock
```

## Disclaimer

This tool modifies system files. Use at your own risk and ensure you understand the impact of blocking hosts.

## Credits

- Made by ryxu-xo.
- UI/CLI design direction: Goodshit Designs (interactive feel).
