class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.17"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.17/bm-darwin-arm64.tar.gz"
    sha256 "4de8fcf52432516ca9dc024a533144e78a71e527e5338e6bbdf244f7519b12c3"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.17/bm-darwin-amd64.tar.gz"
    sha256 "a0f7d948861a4f967a0585dc6306785f61c23540ec082fdf97c4e2c0a78fe7a4"
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
