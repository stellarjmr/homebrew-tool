class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.5.14"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.14/bm-darwin-arm64.tar.gz"
    sha256 "8e8cce13014bfd4ee1ca4db250bc84265e5f4d33558f6e6bbbc85893f9fd2ddb"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.14/bm-darwin-amd64.tar.gz"
    sha256 "f40c4bf4a5c132d3cfe3a2763bccd2b2cec010890712f0eab44ef83cfef4479f"
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
