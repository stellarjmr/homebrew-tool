# frozen_string_literal: true

class Codelim < Formula
  desc "Minimal Codex and Claude Code quota checker"
  homepage "https://github.com/stellarjmr/codelim"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/stellarjmr/codelim/releases/download/v0.1.8/codelim-v0.1.8-macos-arm64.tar.gz"
    sha256 "0b33c06dcf57452091219e94f70f71527570176de08ef31d62efc5abcead9561"
  end

  def install
    odie "codelim v#{version} only ships a macOS binary" unless OS.mac?
    odie "codelim v#{version} only ships an Apple Silicon binary" unless Hardware::CPU.arm?

    codelim = Pathname.glob("**/codelim").find(&:file?)
    odie "codelim binary not found in release archive" unless codelim

    bin.install codelim
  end

  test do
    assert_match "codelim #{version}", shell_output("#{bin}/codelim --version")
  end
end
