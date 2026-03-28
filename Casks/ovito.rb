cask "ovito" do
  version "3.15.1"
  sha256 "cf343ae8c6a9bd64100c9444733bb303dade40ce6f5ecd257b1ce4108f4d712c"

  url "https://www.ovito.org/download/master/ovito-basic-#{version}-macos-arm64.dmg"
  name "OVITO"
  desc "Scientific data visualization and analysis software"
  homepage "https://www.ovito.org/"

  auto_updates true

  app "Ovito.app"
end
