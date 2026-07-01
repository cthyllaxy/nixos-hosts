# Cthyllaxy NixOS Hosts

![built with nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Built%20with%20Nix&color=41439a)

Repository to manage all my NixOS hosts with
[@nmeusling](https://github.com/nmeusling).

This flake uses the [dendritic pattern](https://www.vimjoyer.com/nix/dendritic)
([`flake-parts`](https://github.com/hercules-ci/flake-parts) +
[`import-tree`](https://github.com/denful/import-tree)): every file under
`./modules` is a flake-parts module. Shared NixOS modules live under
`modules/nixos/` and contribute to the `flake.nixosModules.<key>` namespace;
`modules/nixos/default.nix` assembles them into `nixosConfigurations`. Per-host
config is in `modules/nixos/hosts/<host>/default.nix`, alongside that host's
`_hardware-configuration.nix` and `_disko-config.nix` (the `_` prefix keeps these
raw modules out of the `import-tree` scan; they are pulled in via relative
import).

Home-manager is managed separately in the [`dotfiles`](../dotfiles) repo.

## how to

Rebuild a host (run on that host):

```shell
sudo nixos-rebuild switch --flake .#<host>
# or, with nh:
nh os switch .#<host>
```

Hosts: `kassogtha`, `zoth-ommog`, `ythogtha`, `cthylla`.

## remote install / update

```shell
# Fresh install on a remote machine (partitions via disko + nixos-anywhere,
# and generates modules/nixos/hosts/<host>/_hardware-configuration.nix)
just remote-install <host> <user> <ip>

# Update an existing remote machine
just remote-update <host> <user> <ip>
```

## secrets

Secrets are managed with [sops-nix](https://github.com/Mic92/sops-nix) (age).
See the `just` recipes in the `secrets` group (`get-age-key-from-bw`,
`restore-ssh-key`).

## dev shell

```shell
nix develop   # tooling + pre-commit hooks (alejandra, deadnix, …)
```
