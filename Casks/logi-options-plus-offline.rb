# frozen_string_literal: true

# The download URL is versionless, so keep the pinned `sha256` as an integrity check
# Ignore the `brew audit` suggestion to use `sha256 :no_check`
# Update `version` and `sha256` together when Logitech ships a new offline installer
cask "logi-options-plus-offline" do
  version "2.6.944893"
  sha256 "133465fb8c7ef6bd34cc11df16f4ad6ee3066df773178cf269e321860d9cf20c"

  url "https://download01.logi.com/web/ftp/pub/techsupport/optionsplus/logioptionsplus_installer_offline.zip"
  name "Logitech Options+"
  desc "Software for Logitech devices"
  homepage "https://www.logitech.com/en-us/software/logi-options-plus.html"

  livecheck do
    url "https://download01.logi.com/web/ftp/pub/techsupport/optionsplus/logioptionsplus_installer_offline.zip"
    strategy :extract_plist
  end

  auto_updates true
  conflicts_with cask: "logi-options+"
  depends_on macos: :sonoma

  installer script: {
    executable: "logioptionsplus_installer_offline.app/Contents/MacOS/logioptionsplus_installer",
    args:       ["--quiet"],
    sudo:       true,
  }

  uninstall launchctl: [
              "com.logi.cp-dev-mgr",
              "com.logi.optionsplus",
              "com.logi.optionsplus.updater",
              "com.logitech.LogiRightSight",
              "com.logitech.LogiRightSight.Agent",
            ],
            quit:      [
              "com.logi.cp-dev-mgr",
              "com.logi.optionsplus",
              "com.logi.optionsplus.driverhost",
              "com.logi.optionsplus.updater",
              "com.logitech.FirmwareUpdateTool",
              "com.logitech.logiaipromptbuilder",
            ],
            pkgutil:   "com.logitech.LogiRightSightForWebcams.pkg",
            delete:    [
              "/Applications/logioptionsplus.app",
              "/Applications/Utilities/Logi Options+ Driver Installer.bundle",
              "/Library/Application Support/Logi",
              "/Library/Application Support/Logitech.localized/LogiOptionsPlus",
            ],
            rmdir:     "/Library/Application Support/Logitech.localized"

  zap trash: [
    "/Users/Shared/logi",
    "/Users/Shared/LogiOptionsPlus",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.logi.*.sfl*",
    "~/Library/Application Support/Logi",
    "~/Library/Application Support/LogiOptionsPlus",
    "~/Library/HTTPStorages/LogiPluginServiceNative",
    "~/Library/Logs/xlog_logitech",
    "~/Library/Preferences/com.logi.cp-dev-mgr.plist",
    "~/Library/Preferences/com.logi.lps.settings.plist",
    "~/Library/Preferences/com.logi.optionsplus.driverhost.plist",
    "~/Library/Preferences/com.logi.optionsplus.plist",
    "~/Library/Preferences/com.logi.pluginservice.plist",
    "~/Library/Saved Application State/com.logi.optionsplus.savedState",
  ]

  caveats do
    reboot
  end
end
