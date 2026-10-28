# dotfiles

Run `./install.sh`. The entrypoint resolves configuration files relative to this
checkout, so it can also be invoked by absolute path from another directory.

## Codespaces

For standalone public setup, enable dotfiles in your GitHub Codespaces settings
and select `chrismason/dotfiles`. Public installation does not fetch or invoke
private setup and requires no private repository credentials.

For private-first setup, select `chrismason/dotfiles-private` instead. Codespaces
runs that repository's `install.sh`, which clones or reuses these public dotfiles
at `$HOME/.dotfiles` and runs `bash "$HOME/.dotfiles/install.sh"` as a subprocess
before applying private setup. The private repository owns orchestration, target
checkout validation, its repository allowlist, and repository-specific settings.
See its documentation for any access requirements for private setup.

The public zsh configuration optionally sources the readable file
`$HOME/.config/dotfiles-private/github.zsh`, provided by the private installer.
The hook disables inherited command tracing while loading that file; private
shell configuration must not enable tracing or print secrets. Public setup
preserves existing `~/.config` contents, including this optional configuration.
No private allowlist or internal configuration belongs in this repository.

### Linux prerequisites

Use a Debian/Ubuntu-based Codespace with Bash, standard Unix utilities, `apt-get`,
`dpkg`, and passwordless `sudo`. For private-first setup, **Bash and Git must
already be in the base image** so the private installer can clone and invoke
this repository; public setup cannot repair prerequisites needed to reach it.

Once running, public setup installs missing `git`, `python3`, `jq`, `curl`,
`wget`, `unzip`, `tar`, `gzip`, and `zsh`. It also installs CA certificates and
the existing editor/font/Python support packages. Existing executables are
reused. If absent, `gh` is installed from the
[official GitHub CLI apt repository](https://github.com/cli/cli/blob/trunk/docs/install_linux.md),
and `copilot` is installed using its official installer into `/usr/local/bin`.
That directory must be on the Codespace PATH, including the calling installer's
PATH, so newly installed tools are immediately available.

Setup verifies the required executables before continuing. Package, download,
and installer failures stop setup with an error; a failed download cannot be
hidden by a successful command later in a pipeline. Provisioning tools does not
authenticate them or grant repository access. This provisioning is Linux-only;
the macOS setup is unchanged.
