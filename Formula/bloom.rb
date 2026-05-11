class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.3"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.3/bm-darwin-arm64.tar.gz"
    sha256 "d42397e0be72c78b0e1d39ed26b3db28de0fc5d238fd73e120c40097ef3e71a5"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.3/bm-darwin-amd64.tar.gz"
    sha256 "1bd5eea5a9221c80596d9927ceccf8c3f129b03d8e0046d3e2a98cedfc3a505a"
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
