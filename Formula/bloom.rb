class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  url "https://github.com/stellarjmr/bloom/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "d20c1ca304ecbf500bbb6fb008198074fc76c5363baec84108d8341131380d80"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build",
      "-ldflags=-s -w -X github.com/stellarjmr/bloom/internal/bloom.Version=#{version}",
      "-o", libexec/"bm-core",
      "./cmd/bloom"

    chmod 0755, "bm"
    bin.install "bm"
  end

  test do
    assert_match "bm #{version}", shell_output("#{bin}/bm --version")
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
    assert_match "[━━━━━━━━] 100% · npm disabled",
      shell_output("#{bin}/bm update --dry-run --config #{testpath}/config.toml")
  end
end
