class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.0"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.0/bm-darwin-arm64.tar.gz"
    sha256 "2dcd7eef13f047bbceb41350568873759bb3ffc1b0583a8a593c455db581d3f6"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.0/bm-darwin-amd64.tar.gz"
    sha256 "ce60b5ede1643469322be6de9686780270e3dd23dabd5480a11e36001afb77f8"
  end

  def install
    chmod 0755, "bm"
    chmod 0755, "bm-core"
    bin.install "bm"
    libexec.install "bm-core"
  end

  test do
    assert_match "bm v#{version}", shell_output("#{bin}/bm --version")
    (testpath/"config.toml").write <<~TOML
      [settings]
      progress_width = 8
      color = false

      [tasks]
      order = ["npm"]

      [tasks.npm]
      enabled = false
    TOML
    assert_match "no available tasks selected",
      shell_output("#{bin}/bm update --dry-run --config #{testpath}/config.toml")
  end
end
