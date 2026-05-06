class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.4.0"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.4.0/bm-darwin-arm64.tar.gz"
    sha256 "4150bc45100b6f2cadd5e48fa4d2f9cecbe900d28ae170abd3b48221708477aa"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.4.0/bm-darwin-amd64.tar.gz"
    sha256 "22fc7b344b0c479de14c1682d7f6a6b9182f856689b1f676c371b7fae83179c2"
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
