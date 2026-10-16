class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.27/bm-darwin-arm64.tar.gz"
    sha256 "d765b64916caed141c9c803ca612adc79cb90be215eff231775950d1b8011cf1"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.27/bm-darwin-amd64.tar.gz"
    sha256 "75be344d6a11975d126dc8bd1c8307d426f304f8743222d9246972cd7ab487fe"
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
