# at3mic/nixpkgs
My personal Nix packages. If you need any of the packages I ship, feel free to add this repo as an input.

# Packages

<!-- Same style as https://raw.githubusercontent.com/numtide/llm-agents.nix/refs/heads/main/README.md -->
<details>
<summary><strong>SKlauncher 3.0</strong> - Secure and modern Minecraft Launcher</summary>

- **Source**: binary
- **License**: unfree
- **Homepage**: https://skmedix.pl
- **Usage**: `nix run github:at3mic/nixpkgs#sklauncher3`
- **Nix**: [packages/sklauncher/sklauncher3.nix](packages/sklauncher/sklauncher3.nix)

</details>
<details>
<summary><strong>SKlauncher 4.0</strong> - The cross-platform SKlauncher for managing Minecraft instances, mods, and modpacks across Windows, macOS, and Linux</summary>

- **Source**: binary
- **License**: unfree
- **Homepage**: https://next.skmedix.pl
- **Usage**: `nix run github:at3mic/nixpkgs#sklauncher4`
- **Nix**: [packages/sklauncher/sklauncher4.nix](packages/sklauncher/sklauncher4.nix)

</details>

# Installing

## With Flakes (recommended)

Add this to your `flake.nix`:

```nix
{
  inputs = {
    at3mic.url = "github:at3mic/nixpkgs";
  };
}
```

> [!WARNING]
> Only pin the input to your `nixpkgs` if you use `nixpkgs-unstable`!
> 
> Packages will not be tested against stable NixOS.

## Using temporarily

You can run a specific tool temporarily using this command:

```
nix run github:at3mic/nixpkgs#some-package
```

> [!NOTE]
> `nix` commands require the experimental feature `nix-command`.
>
> Don't make issues about this command not existing.