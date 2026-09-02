# typed: strict
# frozen_string_literal: true

cask "read-frog" do
  version "2.0.0"
  sha256 "e6824839badde5f1ca6dcc2351ab081e02e7c35e4b56092b1987ae06f9dabb5a"

  url "https://github.com/stellarjmr/read-frog/releases/download/v#{version}/Read-Frog-#{version}-macos-unsigned.zip"
  name "Read Frog"
  desc "AI-powered language learning extension for Safari"
  homepage "https://github.com/stellarjmr/read-frog"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "Read Frog.app"

  zap trash: [
    "~/Library/Containers/com.zhimin.readfrog",
    "~/Library/Containers/com.zhimin.readfrog.Extension",
  ]

  caveats <<~EOS
    This Homebrew release is ad-hoc signed and is not notarized by Apple.
    macOS may block the first launch. If it does, open System Settings >
    Privacy & Security and choose Open Anyway for Read Frog.

    Safari ignores unsigned extensions by default. In Safari 17 or later:
      1. Safari > Settings > Advanced > Show features for web developers
      2. Safari > Settings > Developer > Allow unsigned extensions
      3. Open Read Frog once, then enable it in Settings > Extensions

    Safari resets "Allow unsigned extensions" whenever Safari quits.
  EOS
end
