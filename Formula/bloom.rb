class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.14"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.14/bm-darwin-arm64.tar.gz"
    sha256 "75d11381af79a91930e631c1b43fdd90620aa1f1c956610dc410f98762f27082"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.14/bm-darwin-amd64.tar.gz"
    sha256 "1ba40905cb39ef3f3b9bd85f50ede1420ff6464251f43f0633e1855c98703f89"
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
