class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.24/bm-darwin-arm64.tar.gz"
    sha256 "69f9445ccaae108d3458565ddf4de458cdfe10e02c037e9e22f3b8ee865c84d9"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.24/bm-darwin-amd64.tar.gz"
    sha256 "01ba2b05e71bcce66df7fdfc12598ec590c57adaf43bd16fa0c8d93395f803e3"
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
