class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.5.8"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.8/bm-darwin-arm64.tar.gz"
    sha256 "8878b89efeac59d998bd400f8692303e2e304a8512004f941655fbc1cc322ce2"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.8/bm-darwin-amd64.tar.gz"
    sha256 "f4efae279b6a0740694e6a75ad25036b276691edba89612b72141375e651a9e7"
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
