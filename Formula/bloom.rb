class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.6.16"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.16/bm-darwin-arm64.tar.gz"
    sha256 "f4b7f90905b87b68dd56f67eb2921b415fb8d1a9a6c69e8bef68cce2f12f578f"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.6.16/bm-darwin-amd64.tar.gz"
    sha256 "5cb2d290b953e997b468c23ce562569c36c1d6e9718e07853713e1b56dbdc4a2"
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
