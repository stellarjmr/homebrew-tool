# frozen_string_literal: true

class Hypermakey < Formula
  desc "Minimal macOS Caps Lock to Hyper key daemon"
  homepage "https://github.com/stellarjmr/hypermakey"
  url "https://github.com/stellarjmr/hypermakey/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "eec38c60935d2f1bebd1913bab2ff04c08a3541c821d170fe1f8e9528d487fc7"
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

  test do
    assert_match version.to_s, shell_output("#{bin}/hypermakey --version")
  end
end
