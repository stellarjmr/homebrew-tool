class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.25/bm-darwin-arm64.tar.gz"
    sha256 "35de876cc6c28ae3190d95bc3ad1af43a9627c1b05147a4f55fa6f0d4080937c"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.25/bm-darwin-amd64.tar.gz"
    sha256 "dd5959ae9bb11360af81ee9765b947ab155196995ce76068e0d9eb7f61bb61ab"
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
