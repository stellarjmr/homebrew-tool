class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.5.9"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.9/bm-darwin-arm64.tar.gz"
    sha256 "31582d16b2e16ae61f57aa1376d1c3e8a88ea87895a9f5a2c81e52ef18c93a60"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.9/bm-darwin-amd64.tar.gz"
    sha256 "4d3868d06ccd5fb3dac1c9d9c8b71693cd4542cbb0ea19509953e47700b5a81d"
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
