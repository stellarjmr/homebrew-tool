class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.7"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.7/bm-darwin-arm64.tar.gz"
    sha256 "82ba5c5d8e974610a982585682c68b3d24b60d532e285fb753958bacff340b29"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.7/bm-darwin-amd64.tar.gz"
    sha256 "3df34b8eb9f068aae7e907ce38736ee6d66de125ef219df274c67ccd8d036a36"
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
