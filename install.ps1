param(
    [string]$InstallDir = "$env:LOCALAPPDATA\SpotifyAdblocker",
    [string]$Version = "latest"
)

$ErrorActionPreference = "Stop"

function Download-File($Url, $OutFile) {
    Invoke-WebRequest -UseBasicParsing -Uri $Url -OutFile $OutFile
}

function Install-App {
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null

    $versionPath = if ($Version -eq "latest") { "latest" } else { "download/$Version" }
    $baseUrl = "https://github.com/REPLACE_OWNER/REPLACE_REPO/releases/$versionPath"
    $rawUrl = "https://raw.githubusercontent.com/REPLACE_OWNER/REPLACE_REPO/main"
    $arch = $env:PROCESSOR_ARCHITECTURE
    if ($arch -eq "ARM64") {
        $binaryName = "spotiblock-windows-arm64.exe"
    } else {
        $binaryName = "spotiblock-windows-amd64.exe"
    }
    Download-File "$baseUrl/$binaryName" "$InstallDir\spotiblock.exe"
    Download-File "$rawUrl/config.json" "$InstallDir\config.json"

    $shimPath = Join-Path $InstallDir "spotiblock.cmd"
    "@echo off`r`n`"%~dp0spotiblock.exe`" %*`r`n" | Set-Content -Encoding ASCII $shimPath

    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if (-not $userPath) { $userPath = "" }
    if ($userPath -notlike "*$InstallDir*") {
        $newPath = if ($userPath) { "$userPath;$InstallDir" } else { $InstallDir }
        [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
        $env:Path = "$env:Path;$InstallDir"
    }

}

Install-App
