class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.12"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.12/bm-darwin-arm64.tar.gz"
    sha256 "cc8ddc81c92a543d26477b66341e6463ffac37c005c61f9b3175ac5771fcc3a6"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.12/bm-darwin-amd64.tar.gz"
    sha256 "472c801b96dafd07fbb300de62dc38eed08014810628e9501038b3d829d7ecc7"
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
