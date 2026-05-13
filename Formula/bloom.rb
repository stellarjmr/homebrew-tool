class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.10"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.10/bm-darwin-arm64.tar.gz"
    sha256 "5b9523fd6adb346483d577d75e430cc8684c90218dec70de416eb16d66885b0e"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.10/bm-darwin-amd64.tar.gz"
    sha256 "5c509b340ce86c9206fb5fcf134807e8da310df6891ddcbd0ca86b04ef71e77b"
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
