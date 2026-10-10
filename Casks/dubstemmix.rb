cask "dubstemmix" do
  version "0.11.0"
  sha256 "992830f204348aa92c0a89c907496a8564f0072e021e26348ea44dd5c3ee38a5"

  url "https://github.com/yoanbernabeu/DubStemMix/releases/download/v#{version}/DubStemMix-#{version}.zip"
  name "DubStemMix"
  desc "Live dub mixing console for stems on the Akai MIDImix"
  homepage "https://yoanbernabeu.github.io/DubStemMix/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself (Help > Check for Updates…).
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "DubStemMix.app"

  # Signed ad hoc, not notarized: clear the quarantine flag, as install.sh does.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/DubStemMix.app"]
  end

  # Projects, setlists, stems and recordings in ~/Music/DubStemMix are the user's files: never zapped.
  zap trash: [
    "~/Library/Application Support/DubStemMix",
    "~/Library/Preferences/com.yoanbernabeu.DubStemMix.plist",
  ]
end
