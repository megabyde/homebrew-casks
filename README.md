# homebrew-casks

Personal Homebrew tap (`brew tap megabyde/casks`) for casks that need a stable tap home.
It exists because tapping a live dotfiles repository couples `brew update` to that repo's
history; this repo never rewrites history, so the tap clone always fast-forwards.

## Casks

- `logi-options-plus-offline` — Logitech Options+ from the offline installer, with a pinned
  `sha256`. The download URL is versionless, so `brew audit` suggests `sha256 :no_check`;
  the pin is kept deliberately as an integrity check.

## Bumping a cask

Download the new offline installer, then update `version` and `sha256` together in the cask
and commit. On the workstation:

```sh
brew update
brew upgrade --cask logi-options-plus-offline
```
