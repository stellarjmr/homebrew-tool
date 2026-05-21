# frozen_string_literal: true

class Hypermakey < Formula
  desc "Minimal macOS Caps Lock to Hyper key daemon"
  homepage "https://github.com/stellarjmr/hypermakey"
  url "https://github.com/stellarjmr/hypermakey/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "9e881183aa79a2dd75746dd35d71a75490b9169099dd0e47bfc5b89b2e752349"
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
