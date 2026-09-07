class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.26/bm-darwin-arm64.tar.gz"
    sha256 "42cd97610718530c183af19c57c8a0835acf34ec604a6ae659c5c279abb66b63"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.26/bm-darwin-amd64.tar.gz"
    sha256 "abc134fc23c83886f241a4245d655dd4c767697c80aa486b09481d8c853a32e1"
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
