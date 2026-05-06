class Bloom < Formula
  desc "Config-driven terminal updater for developer tools"
  homepage "https://github.com/stellarjmr/bloom"
  url "https://github.com/stellarjmr/bloom/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d80140bc73acea13900550780c7e35c99d04606cebe1228f43003dc6a1991f50"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(
      ldflags: "-s -w -X github.com/stellarjmr/bloom/internal/bloom.Version=#{version}",
    ), "./cmd/bloom"
  end

  test do
    assert_match "bloom #{version}", shell_output("#{bin}/bloom --version")
  end
end
