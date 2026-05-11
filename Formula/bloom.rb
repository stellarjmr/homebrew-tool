class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.2"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.2/bm-darwin-arm64.tar.gz"
    sha256 "9e614089eefa59c6e5ae047d4aac037e5ac9d9b40454e29fdd2d598841b169f2"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.2/bm-darwin-amd64.tar.gz"
    sha256 "69773aaf7ed9de5679b2cc6dfe8f044f7e84b97b59d562f27c16fe45af24c488"
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
