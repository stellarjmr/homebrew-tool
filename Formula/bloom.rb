class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.5.3"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.3/bm-darwin-arm64.tar.gz"
    sha256 "f825e94e615fb02389844b10cb3073a7391e062bfe475318f48eb3949dde4d7f"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.3/bm-darwin-amd64.tar.gz"
    sha256 "e21b1873f034f8b2dc8ec19b69d87a60c8bd71db265900e5b48e50bfca9e5ff7"
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
