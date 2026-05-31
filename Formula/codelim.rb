# frozen_string_literal: true

class Codelim < Formula
  desc "Minimal local Codex quota checker"
  homepage "https://github.com/stellarjmr/codelim"
  version "0.1.3"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/stellarjmr/codelim/releases/download/v0.1.3/codelim-v0.1.3-macos-arm64.tar.gz"
    sha256 "a7039154458d1373be6386419bb0c22a48d1b6b012b0e173f8d6e1b540832211"
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
