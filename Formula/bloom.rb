class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.4"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.4/bm-darwin-arm64.tar.gz"
    sha256 "3e5709e46f1ede64f6ad1c4be265704c7bb034f83aef5b05a2a9be1bac2643ca"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.4/bm-darwin-amd64.tar.gz"
    sha256 "2f16ef000125a07bc3cd0df7907bb846b97eedee27b2175aa31239de1cec4bff"
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
