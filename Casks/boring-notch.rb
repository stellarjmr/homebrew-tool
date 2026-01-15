cask "boring-notch" do
  version "2.7.3_1"
  sha256 "a86f44ce6b1d4fc02a89cd5679104c3bafb800195f5e085f11acce06f3d06b6d"

  url "https://github.com/stellarjmr/boring.notch/releases/download/v#{version}/boringNotch.zip"
  name "boring.notch"
  desc "Not so boring notch with scrolling lyrics"
  homepage "https://github.com/stellarjmr/boring.notch"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "boringNotch.app"
end
