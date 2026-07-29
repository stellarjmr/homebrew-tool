class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.22/bm-darwin-arm64.tar.gz"
    sha256 "96bdad92ae7c9d1442c6a71faeb98ba19444256ff10b721864a02503204c0399"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.22/bm-darwin-amd64.tar.gz"
    sha256 "756d3fc35be9d462f774f617af9351a93b49404ba8cfcfd1b04ac7c99732a439"
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
