class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.8"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.8/bm-darwin-arm64.tar.gz"
    sha256 "f5022b82aeaa63339f6e217b3c953f0fd11b23579dc9f23acee0894a44b8f0d3"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.8/bm-darwin-amd64.tar.gz"
    sha256 "29060923976805b4acbd1e9fad79caade4a75449dc340bd535656540b979296f"
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
