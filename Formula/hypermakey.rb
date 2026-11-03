# frozen_string_literal: true

class Hypermakey < Formula
  desc "Minimal macOS Caps Lock to Hyper key daemon"
  homepage "https://github.com/stellarjmr/hypermakey"
  url "https://github.com/stellarjmr/hypermakey/releases/download/v0.2.1/hypermakey-v0.2.1-aarch64-apple-darwin.tar.gz"
  sha256 "e2b76b22267ae55b5e6053196167879b4d9658e8f18ea050d539b0bf5503f4d3"
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
    # Every keystroke waits for hypermakey's event tap; don't let launchd throttle it.
    process_type :interactive
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

      If macOS denies the permission after an upgrade, switch hypermakey back on
      in the same list. Never remove hypermakey from the list or switch it off
      while the service is running; stop the service first.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hypermakey --version")
    # Release binaries are signed with the hardened runtime, which blocks DYLD_* code injection.
    assert_match(/flags=0x\h+\([^)]*runtime/, shell_output("codesign --display --verbose #{bin}/hypermakey 2>&1"))
  end
end
