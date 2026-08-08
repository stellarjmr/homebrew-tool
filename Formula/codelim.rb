# frozen_string_literal: true

class Codelim < Formula
  desc "Minimal local Codex quota checker"
  homepage "https://github.com/stellarjmr/codelim"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/stellarjmr/codelim/releases/download/v0.1.4/codelim-v0.1.4-macos-arm64.tar.gz"
    sha256 "3075d67e5c8a40766469a95b6a8bbac5933b3d54beb2891ac30cc9e36e4bead1"
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
