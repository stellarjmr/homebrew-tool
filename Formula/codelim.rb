# frozen_string_literal: true

class Codelim < Formula
  desc "Minimal local Codex quota checker"
  homepage "https://github.com/stellarjmr/codelim"
  version "0.1.0"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/stellarjmr/codelim/releases/download/v0.1.0/codelim-v0.1.0-macos-arm64.tar.gz"
    sha256 "284a7cb5beaddea98b896878f32098a3e51869dd69cc62b9dbfbd60945b14cd0"
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
