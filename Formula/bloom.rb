class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.5.10"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.10/bm-darwin-arm64.tar.gz"
    sha256 "ead1f3bef1d4f7c7839a51c63316f4e104bef3948cc6b62c00b9769d154aad69"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.10/bm-darwin-amd64.tar.gz"
    sha256 "91959e26f489efa5f56cced30c473eeb5e88a0fba643f1e33acbca54a6adc264"
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
