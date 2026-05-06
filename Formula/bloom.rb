class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.5.0"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.0/bm-darwin-arm64.tar.gz"
    sha256 "0b5d868f3c38fb66f5591c708e115ff6c746f635b7241c9b30b8292a9af73164"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.0/bm-darwin-amd64.tar.gz"
    sha256 "cda5f396297bf28efe819700b77d92c525e1286feb21d91e005ec38582578d1f"
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
