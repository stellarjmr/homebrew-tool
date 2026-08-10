class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.23/bm-darwin-arm64.tar.gz"
    sha256 "9f5d4f97c54b081d158ed7b3d67d5cef605afeb863fe474e3a5dd5d22b7f574b"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.23/bm-darwin-amd64.tar.gz"
    sha256 "c19ad259d53f8694228f8f793ed8c7b7daa04464a9e94258bd6c1424d78dee96"
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
