# frozen_string_literal: true

class Hypermakey < Formula
  desc "Minimal macOS Caps Lock to Hyper key daemon"
  homepage "https://github.com/stellarjmr/hypermakey"
  url "https://github.com/stellarjmr/hypermakey/releases/download/v0.2.0/hypermakey-v0.2.0-aarch64-apple-darwin.tar.gz"
  sha256 "7870b4ee1a934440cb53b53e77d5cf2d0f670048702c62fd949f54c31221c340"
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

      macOS treats every new version as a different program, so grant the
      permission again after each upgrade.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hypermakey --version")
    # Release binaries are signed with the hardened runtime, which blocks DYLD_* code injection.
    assert_match(/flags=0x\h+\([^)]*runtime/, shell_output("codesign --display --verbose #{bin}/hypermakey 2>&1"))
  end
end
