class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.5.2"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.2/bm-darwin-arm64.tar.gz"
    sha256 "3a2bba8d379d4360c739d1e43b3e028456e74ce685495e9dce3685a89c9d4249"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.2/bm-darwin-amd64.tar.gz"
    sha256 "9bf42770985e192e480690c41efd19b8b48dc210e8bb459ea962ee53547c2110"
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
