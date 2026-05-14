# frozen_string_literal: true

require "download_strategy"
require "utils/github"

class GitHubPrivateRepositoryReleaseDownloadStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **meta)
    super
    parse_url_pattern
    set_github_token
  end

  def resolved_basename
    @filename
  end

  def resolve_url_basename_time_file_size(_url, timeout: nil)
    [download_url, @filename, Time.now, 0, false]
  end

  private

  def _fetch(url:, resolved_url:, timeout:)
    curl_download download_url,
                  "--header", "Accept: application/octet-stream",
                  "--header", "Authorization: Bearer #{@github_token}",
                  to: temporary_path
  end

  def parse_url_pattern
    match = @url.match(%r{https://github\.com/([^/]+)/([^/]+)/releases/download/([^/]+)/(.+)})
    raise CurlDownloadStrategyError, "Invalid GitHub release URL: #{@url}" unless match

    _, @owner, @repo, @tag, @filename = match.to_a
  end

  def download_url
    "https://api.github.com/repos/#{@owner}/#{@repo}/releases/assets/#{asset_id}"
  end

  def asset_id
    @asset_id ||= begin
      release_url = "https://api.github.com/repos/#{@owner}/#{@repo}/releases/tags/#{@tag}"
      release = GitHub::API.open_rest(release_url)
      asset = release.fetch("assets").find { |item| item["name"] == @filename }
      raise CurlDownloadStrategyError, "Asset #{@filename} not found in #{@owner}/#{@repo} #{@tag}" unless asset

      asset.fetch("id")
    end
  end

  def set_github_token
    @github_token = ENV["HOMEBREW_GITHUB_API_TOKEN"].to_s
    @github_token = ENV["GITHUB_TOKEN"].to_s if @github_token.empty?
    @github_token = gh_auth_token if @github_token.empty?

    if @github_token.empty?
      raise CurlDownloadStrategyError,
            "Set HOMEBREW_GITHUB_API_TOKEN or run `gh auth login` to download private GitHub releases"
    end

    ENV["HOMEBREW_GITHUB_API_TOKEN"] = @github_token
  end

  def gh_auth_token
    ["gh", "/opt/homebrew/bin/gh", "/usr/local/bin/gh"].each do |gh|
      token = `#{gh} auth token 2>/dev/null`.strip
      return token unless token.empty?
    end

    ""
  end
end
