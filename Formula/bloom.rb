class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.13"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.13/bm-darwin-arm64.tar.gz"
    sha256 "e76fcf84cc7090511c1d3a95861279709b4dccf0f66036dc02a056340d696813"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.13/bm-darwin-amd64.tar.gz"
    sha256 "6fc63b6a8314a9e98f8d64554ef212d1a667eaad6243b757ef2317d10be72f2e"
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
