class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.11"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.11/bm-darwin-arm64.tar.gz"
    sha256 "5e42b0043cf208c00d4ec407eed7306c299e4bb9ad8fa900bb08154bcea5cc55"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.11/bm-darwin-amd64.tar.gz"
    sha256 "b2def8a4e60a86fb958aa92cf19c319dbb2d6b5e9bbed1a4dab636a5cfdba78b"
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
