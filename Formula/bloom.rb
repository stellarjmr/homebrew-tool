class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.5.11"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.11/bm-darwin-arm64.tar.gz"
    sha256 "02f3d5307648901a6c18538fae2a923e942fb6e9997f203dee60b4f2b1353d4d"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.11/bm-darwin-amd64.tar.gz"
    sha256 "2617d488b8f091e5880123b224a474dfd5877149ddfa0bbb7056b1d3520eb412"
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
