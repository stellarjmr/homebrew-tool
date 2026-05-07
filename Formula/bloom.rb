class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.5.6"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.6/bm-darwin-arm64.tar.gz"
    sha256 "3efd09e9d75d0ac7b8d43417054842e0172dc362239aef8a5f27383bc4fb2af6"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.6/bm-darwin-amd64.tar.gz"
    sha256 "cf03d8f887b8b847a8ae36d84a52a64f88ac5b5c33de09bd0f4fbc036e2bd496"
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
