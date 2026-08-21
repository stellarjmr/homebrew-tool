# frozen_string_literal: true

class Codelim < Formula
  desc "Minimal local Codex quota checker"
  homepage "https://github.com/stellarjmr/codelim"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/stellarjmr/codelim/releases/download/v0.1.6/codelim-v0.1.6-macos-arm64.tar.gz"
    sha256 "2ef29e634e186adf560ff32138dad67a86d46d2325b5041ad34731f751045036"
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
