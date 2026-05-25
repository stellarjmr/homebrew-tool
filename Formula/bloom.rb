class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.18"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.18/bm-darwin-arm64.tar.gz"
    sha256 "3033dfbacb5de749c3497f04fa80895c8589184033b874b32738dcc0edb1e487"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.18/bm-darwin-amd64.tar.gz"
    sha256 "d56fb7205348be5fbbe82065d9ea5d7b80f97336d75852a1a9d2da78105f5427"
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
