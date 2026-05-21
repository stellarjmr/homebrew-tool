# frozen_string_literal: true

class Hypermakey < Formula
  desc "Minimal macOS Caps Lock to Hyper key daemon"
  homepage "https://github.com/stellarjmr/hypermakey"
  url "https://github.com/stellarjmr/hypermakey/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "18a08a13850eff666ac50b2fbde59857c52d8790e22683b6a832e5d50ab8eab8"
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
