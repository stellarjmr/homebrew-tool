class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  version "0.5.12"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.12/bm-darwin-arm64.tar.gz"
    sha256 "2097283987a1f285f8230b3ac86054ff3558f935e8450e585082a19266f98a14"
  else
    url "https://github.com/stellarjmr/bloom/releases/download/v0.5.12/bm-darwin-amd64.tar.gz"
    sha256 "0e8b03395511fbe8dc43858422c428dd3782eea54c3f0910b19a410539738f20"
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
