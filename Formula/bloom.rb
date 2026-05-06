class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  url "https://github.com/stellarjmr/bloom/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "ee2a359fe1f75935babd16848f5ec1196aedb31c1255f18d0d601faf95f66f79"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build",
      "-ldflags=-s -w -X github.com/stellarjmr/bloom/internal/bloom.Version=#{version}",
      "-o", libexec/"bloom-core",
      "./cmd/bloom"

    chmod 0755, ["bloom", "bm"]
    bin.install "bloom", "bm"
  end

  test do
    assert_match "bloom #{version}", shell_output("#{bin}/bloom --version")
    (testpath/"config.toml").write <<~TOML
      [settings]
      progress_width = 8
      color = false

      [tasks]
      order = ["npm"]

      [tasks.npm]
      enabled = false
      install_hint = "brew install node"
    TOML
    assert_match "[━━━━━━━━] 100% [skip] npm disabled",
      shell_output("#{bin}/bm --dry-run --config #{testpath}/config.toml")
  end
end
