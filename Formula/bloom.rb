class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.5"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.5/bm-darwin-arm64.tar.gz"
    sha256 "7f3d811e38d8cd576840b88094883d1ee245ddea13a4812dce7714866dc5ac08"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.5/bm-darwin-amd64.tar.gz"
    sha256 "c93e67853a11d44d46111ef84b0a631d85418937256b25e16d0cfdb766ee2d3b"
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
