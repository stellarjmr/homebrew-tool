# frozen_string_literal: true

require_relative "../lib/private_github_release_download_strategy"

class Pawd < Formula
  desc "macOS desktop pet selector and daemon"
  homepage "https://github.com/stellarjmr/pawd"
  version "0.1.3"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/stellarjmr/pawd/releases/download/v0.1.3/pawd-v0.1.3-darwin-arm64.tar.gz",
        using: GitHubPrivateRepositoryReleaseDownloadStrategy
    sha256 "3b8e35090eaa1240c321e0e4249a4c7c7aa65a7e9411f0ab3f0d55123781b16a"
  end

  def install
    odie "pawd v#{version} only ships a macOS Apple Silicon binary" unless OS.mac? && Hardware::CPU.arm?

    pawd = Pathname.glob("**/pawd").find(&:file?)
    daemon = Pathname.glob("**/pets-daemon").find(&:file?)
    odie "pawd binary not found in release archive" unless pawd
    odie "pets-daemon binary not found in release archive" unless daemon

    bin.install pawd
    bin.install daemon
  end

  test do
    assert_match "Usage: pawd", shell_output("#{bin}/pawd --help")
  end
end
