class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.1"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.1/bm-darwin-arm64.tar.gz"
    sha256 "f34f84c15c0e933643a51a202a362a0df2a682cbcbce5ded78b3d79cb4bbd7d7"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.1/bm-darwin-amd64.tar.gz"
    sha256 "5e3d4250dee38cfb8d2b458e4fa5dba7444ccd50a61ff4acfdbd058ddf8dc08d"
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
