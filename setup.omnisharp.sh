#!/bin/bash

set -eE -o pipefail
trap 'status=$?; printf "dotfiles: ERROR: OmniSharp setup failed at line %s (exit %s).\n" "$LINENO" "$status" >&2; exit "$status"' ERR

case "$(uname -m)" in
    x86_64) arch=x64 ;;
    aarch64|arm64) arch=arm64 ;;
    *) printf 'dotfiles: ERROR: Unsupported OmniSharp architecture.\n' >&2; exit 1 ;;
esac

version=v2.0.0
asset="omnisharp-linux-$arch.tar.gz"
release_url="https://github.com/OmniSharp/omnisharp-roslyn/releases/download/$version"
install_dir="$HOME/.local/omnisharp"
mkdir -p "$HOME/.local"
stage="$(mktemp -d "$HOME/.local/.omnisharp-install.XXXXXX")"
trap 'rm -rf -- "$stage"' EXIT

has_dotnet_sdk() {
    local sdks runtimes
    sdks="$("$1" --list-sdks)" || return 1
    runtimes="$("$1" --list-runtimes)" || return 1
    grep -q '^10\.' <<< "$sdks" &&
        grep -q '^Microsoft.NETCore.App 10\.' <<< "$runtimes"
}

dotnet="$(command -v dotnet || true)"
if [ -z "$dotnet" ] || ! has_dotnet_sdk "$dotnet"; then
    dotnet="$HOME/.local/share/dotnet/dotnet"
    if [ ! -x "$dotnet" ] || ! has_dotnet_sdk "$dotnet"; then
        curl -fsSL https://dot.net/v1/dotnet-install.sh -o "$stage/dotnet-install.sh"
        bash "$stage/dotnet-install.sh" --channel 10.0 \
            --install-dir "$HOME/.local/share/dotnet" --no-path
    fi
fi
if ! has_dotnet_sdk "$dotnet"; then
    printf 'dotfiles: ERROR: OmniSharp requires a .NET 10 SDK and runtime.\n' >&2
    exit 1
fi

curl -fsSL "$release_url/$asset" -o "$stage/$asset"
curl -fsSL "$release_url/SHA256SUMS" -o "$stage/SHA256SUMS"
(
    cd "$stage"
    awk -v asset="$asset" '$2 == asset' SHA256SUMS | sha256sum --check -
)
mkdir "$stage/omnisharp"
tar -xzf "$stage/$asset" -C "$stage/omnisharp"
if [ ! -s "$stage/omnisharp/OmniSharp.dll" ] || [ ! -x "$stage/omnisharp/OmniSharp" ]; then
    printf 'dotfiles: ERROR: OmniSharp archive is missing its entrypoint.\n' >&2
    exit 1
fi

# Scope SDK discovery to this process without changing the user's default SDK.
dotnet_root="$(dirname -- "$(readlink -f -- "$dotnet")")"
printf '#!/bin/bash\nexport DOTNET_ROOT=%q\nexport PATH="$DOTNET_ROOT:$PATH"\nexec "$DOTNET_ROOT/dotnet" "$(dirname -- "${BASH_SOURCE[0]}")/OmniSharp.dll" "$@"\n' \
    "$dotnet_root" > "$stage/omnisharp/run"
chmod +x "$stage/omnisharp/run"

if [ -e "$install_dir" ] || [ -L "$install_dir" ]; then
    backup="$(mktemp -d "$HOME/.local/omnisharp-backup.XXXXXX")"
    mv -- "$install_dir" "$backup/omnisharp"
    printf 'dotfiles: Previous OmniSharp installation preserved at %s/omnisharp\n' "$backup"
fi
mv -- "$stage/omnisharp" "$install_dir"
printf 'dotfiles: OmniSharp %s installed; launch with %s/run\n' "$version" "$install_dir"
