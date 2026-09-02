# homebrew-tool

Custom Homebrew tap.

The `read-frog` cask is published automatically only after its upstream release
contains a Developer ID-signed and notarized Safari app. The tap revalidates the
checksum, code signature, Gatekeeper assessment, and notarization ticket before
committing the cask.

## Usage

### Add tap

```bash
brew tap stellarjmr/tool
```

### Install a Formula or Cask

```bash
brew install stellarjmr/tool/<formula-name>
brew install --cask stellarjmr/tool/<cask-name>
```

### Available Formulae

| Formula | Install Command |
|---------|----------------|
| Bloom | `brew install stellarjmr/tool/bloom` |
| codelim | `brew install stellarjmr/tool/codelim` |
| hypermakey | `brew install stellarjmr/tool/hypermakey` |
| pawd | `brew install stellarjmr/tool/pawd` |

### Available Casks

| Cask | Install Command |
|------|----------------|
| SailKeys | `brew install --cask stellarjmr/tool/sailkeys` |

### Uninstall

```bash
brew uninstall <formula-name>
brew uninstall --cask <cask-name>
```

### Remove tap

```bash
brew untap stellarjmr/tool
```
