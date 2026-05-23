class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.15"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.15/bm-darwin-arm64.tar.gz"
    sha256 "2d0ed171d09ac571c351805a9946125e9f2a356b4a0f10ad8e9ed798e3f90ecd"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.15/bm-darwin-amd64.tar.gz"
    sha256 "c4dec298a1156a62c685d6fe704683c182f189b57bd0ddde3715c726e290b9aa"
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
