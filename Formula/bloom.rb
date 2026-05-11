class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.6"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.6/bm-darwin-arm64.tar.gz"
    sha256 "c8b11f899e746e67115b44d444f52d5c1eef09af6f8c9a16b540efbe223de4aa"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.6/bm-darwin-amd64.tar.gz"
    sha256 "279dd1d556cdc0fd7452cdb74dd98a83495e0c28be24109dc2a4d15eec2b5831"
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
