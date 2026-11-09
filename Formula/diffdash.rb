# frozen_string_literal: true

class Diffdash < Formula
  desc "Read-only TUI dashboard for lines added and deleted in a git repository"
  homepage "https://github.com/stellarjmr/diffdash"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/stellarjmr/diffdash/releases/download/v0.4.0/diffdash-v0.4.0-macos-arm64.tar.gz"
    sha256 "b74202a88997e03120a74159567cb472358852be7c87aedc4399056f5f0931c2"
  end

  def install
    odie "diffdash v#{version} only ships a macOS binary" unless OS.mac?
    odie "diffdash v#{version} only ships an Apple Silicon binary" unless Hardware::CPU.arm?

    diffdash = Pathname.glob("**/diffdash").find(&:file?)
    odie "diffdash binary not found in release archive" unless diffdash

    bin.install diffdash
  end

  test do
    assert_match "diffdash #{version}", shell_output("#{bin}/diffdash --version")
  end
end
