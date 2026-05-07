class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.5.7"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.7/bm-darwin-arm64.tar.gz"
    sha256 "93a9707420d34583ed7a332777ba721855ed348e9693c1cae1bcbde59a17ee67"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.7/bm-darwin-amd64.tar.gz"
    sha256 "e256e29d0036b3124fcd0df76778bf60d7722a62b21aaa361546ba937eee1a09"
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
