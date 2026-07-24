# Homebrew Casks

Personal Homebrew tap (`brew tap megabyde/casks`) for casks that need a stable
tap home. It exists because tapping a live dotfiles repository couples
`brew update` to that repo's history. This repo never rewrites history, so
`brew update` can fast-forward the tap clone.

## Casks

- `logi-options-plus-offline`: Logitech Options+ from the offline installer,
  with a pinned `sha256`. Because the download URL is versionless, `brew audit`
  suggests `sha256 :no_check`; the cask keeps the pinned `sha256` as an
  integrity check.

## Bumping a cask

Download the new offline installer, then update `version` and `sha256` together
in the cask and commit. On the workstation:

```sh
brew update
brew upgrade --cask logi-options-plus-offline
```

## QA

Install the Markdown checker once, then run the local checks:

```sh
brew install markdownlint-cli
make format
make check
```
