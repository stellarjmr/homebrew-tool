class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.5.4"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.4/bm-darwin-arm64.tar.gz"
    sha256 "0b01532ce48a84d179cd5944180e55fbe5b52ab3fca951e98187d6033e6bf21f"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.4/bm-darwin-amd64.tar.gz"
    sha256 "6a271b041fc9dfa4005c9c9e5a7f622feeda0dc5c2bb61baaf2177d6ab46907a"
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
