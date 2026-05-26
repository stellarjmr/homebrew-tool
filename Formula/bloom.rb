class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.19"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.19/bm-darwin-arm64.tar.gz"
    sha256 "b118bf703b1a23021f83b9b23185c3677f959286a441802e3e1c91ca6faf87b2"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.19/bm-darwin-amd64.tar.gz"
    sha256 "88757aabcd3837b478fee488087df87d52c71392282936f0383d0a8042f4732c"
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
