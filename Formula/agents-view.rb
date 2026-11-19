# frozen_string_literal: true

# Installs the published Agents View binary for the current OS and CPU.
class AgentsView < Formula
  desc "Local editor and source browser for AGENTS.md"
  homepage "https://github.com/wlkr-si/agents-view"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/wlkr-si/agents-view/releases/download/v0.1.0/agents-view_0.1.0_darwin_arm64.tar.gz"
      sha256 "a436d37ef2ea0f00df340b4070a3e90f40a409342d11807e1c3e9bda431785a3"
    end
    on_intel do
      url "https://github.com/wlkr-si/agents-view/releases/download/v0.1.0/agents-view_0.1.0_darwin_amd64.tar.gz"
      sha256 "a5d8a3beaf36c89f48e56a6fb2330f6356fe21505a9f442c961f48649a36fdf7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/wlkr-si/agents-view/releases/download/v0.1.0/agents-view_0.1.0_linux_arm64.tar.gz"
      sha256 "f33dec7d165c9d5c1d5fdcffe325808c91a986565fa9154a1233851262429ca3"
    end
    on_intel do
      url "https://github.com/wlkr-si/agents-view/releases/download/v0.1.0/agents-view_0.1.0_linux_amd64.tar.gz"
      sha256 "15ab77c07158f8e7655b8ae38858e8ebc75ef01d5d268b354f833c8d4e1c2ee8"
    end
  end

  def install
    bin.install "agents-view"
  end

  test do
    assert_equal "agents-view v#{version}", shell_output("#{bin}/agents-view --version").strip
  end
end
