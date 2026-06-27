class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.21"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.21/bm-darwin-arm64.tar.gz"
    sha256 "05b020d0a8b643c4b67f9d49c948a74863c66abc77dee2dbb942bccabb78fd7d"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.21/bm-darwin-amd64.tar.gz"
    sha256 "68f802d8f5786fa8d675bb90ab1bc41fdc5b042379f3a964b92c5102fd012e41"
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
