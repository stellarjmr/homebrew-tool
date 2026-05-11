class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.5.15"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.15/bm-darwin-arm64.tar.gz"
    sha256 "156bda829a2c8ac53bc473635cf07c6f370b663bd049ab31eb5240a6aaaf0c31"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.15/bm-darwin-amd64.tar.gz"
    sha256 "2fd60edeffb5ca6f19e8c3bdd974839716ea958a56eff01060f2a47792b5e627"
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
