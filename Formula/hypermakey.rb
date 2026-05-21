# frozen_string_literal: true

class Hypermakey < Formula
  desc "Minimal macOS Caps Lock to Hyper key daemon"
  homepage "https://github.com/stellarjmr/hypermakey"
  url "https://github.com/stellarjmr/hypermakey/releases/download/v0.1.0/hypermakey-v0.1.0-aarch64-apple-darwin.tar.gz"
  sha256 "1ad9283498e03d8833066c9c5e80d388a4c950862b4de0056884c0094520a7d2"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "hypermakey"
  end

  service do
    run [opt_bin/"hypermakey"]
    keep_alive true
    run_type :immediate
    log_path var/"log/hypermakey.log"
    error_log_path var/"log/hypermakey.log"
  end

  def caveats
    <<~EOS
      hypermakey requires macOS Accessibility permission before Caps Lock can be remapped:

        System Settings → Privacy & Security → Accessibility

      Grant permissions to:

        #{opt_bin}/hypermakey

      Then restart the service:

        brew services restart stellarjmr/tool/hypermakey
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hypermakey --version")
  end
end
