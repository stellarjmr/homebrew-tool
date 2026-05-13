class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.9"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.9/bm-darwin-arm64.tar.gz"
    sha256 "0678d050284695d3d5592a3d86b9904df9d02a70cb5e761709004d8dba6c5743"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.9/bm-darwin-amd64.tar.gz"
    sha256 "0eaabf88c23a746e28b14374c40894b02626832d077e168f3fdb3be27b1baa1e"
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
