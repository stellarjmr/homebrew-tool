class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.5.5"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.5/bm-darwin-arm64.tar.gz"
    sha256 "408ccc1293c328e36feb0e906fa6b2c0710b6577d85bd4f94b331a9f6d36ac0f"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.5/bm-darwin-amd64.tar.gz"
    sha256 "c7c1822945da23f7c82f7e30aa27064e75dad26d36400bae3ed9e01d6ab6f22e"
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
