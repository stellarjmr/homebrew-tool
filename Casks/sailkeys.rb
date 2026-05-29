# frozen_string_literal: true

cask "sailkeys" do
  version "0.1.0"
  sha256 "a6628ec464aea0f9418b580934d19e20b5daa3096a02a5761d44494f6bceaa09"

  url "https://github.com/stellarjmr/sailkeys/releases/download/v#{version}/SailKeys-#{version}-macos.zip"
  name "SailKeys"
  desc "Vimium-style keyboard navigation for Safari"
  homepage "https://github.com/stellarjmr/sailkeys"

  depends_on macos: :tahoe

  app "SailKeys.app"

  zap trash: [
    "~/Library/Containers/com.zhimin.sailkeys",
    "~/Library/Containers/com.zhimin.sailkeys.Extension",
  ]
end
