class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.20"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.20/bm-darwin-arm64.tar.gz"
    sha256 "189f7a7eea4ee151cf53e9049f073691653e4e393c0e903664f70dbe7dde9313"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.20/bm-darwin-amd64.tar.gz"
    sha256 "dd750ec79985c0f250d43b47dec1ff2032ebc8e724000409c471c409926d4974"
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
