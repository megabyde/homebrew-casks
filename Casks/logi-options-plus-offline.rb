# frozen_string_literal: true

# Intentional: the pinned sha256 is kept even though `brew audit` asks for `sha256 :no_check`
# because the download URL is versionless. The pin is an integrity check; bump `version` and
# `sha256` together when Logitech ships a new offline installer. Do not switch to `:no_check`.
cask "logi-options-plus-offline" do
  version "2.1.854977"
  sha256 "51cd89e239f08f2f00eec1dc712934df67aff8376e06a02d3a8879451661d4b7"

  url "https://download01.logi.com/web/ftp/pub/techsupport/optionsplus/logioptionsplus_installer_offline.zip?versionId=hsz5VxF6QouTPFPrWNEcQqPgrN5blDEA",
      verified: "download01.logi.com/web/ftp/pub/techsupport/optionsplus/"
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
