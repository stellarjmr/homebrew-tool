# frozen_string_literal: true

class Codelim < Formula
  desc "Minimal local Codex quota checker"
  homepage "https://github.com/stellarjmr/codelim"
  version "0.1.2"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/stellarjmr/codelim/releases/download/v0.1.2/codelim-v0.1.2-macos-arm64.tar.gz"
    sha256 "ccaeacc7c476ca78c51c7cf6a95f4f7e7b654a269a8dc645a0540237a324dab6"
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
