# frozen_string_literal: true

class Hypermakey < Formula
  desc "Minimal macOS Caps Lock to Hyper key daemon"
  homepage "https://github.com/stellarjmr/hypermakey"
  url "https://github.com/stellarjmr/hypermakey/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "4f1301aabfd899feb63c19acfb914e908389bf0697e4ed919f8fb0076573bc34"
  license "MIT"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
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
