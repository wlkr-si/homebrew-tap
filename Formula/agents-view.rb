# frozen_string_literal: true

# Installs the published Agents View binary for the current OS and CPU.
class AgentsView < Formula
  desc "Local editor and source browser for AGENTS.md"
  homepage "https://github.com/wlkr-si/agents-view"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/wlkr-si/agents-view/releases/download/v0.1.1/agents-view_0.1.1_darwin_arm64.tar.gz"
      sha256 "3231ea858647f86d62ccb44aa4bd85c6b2fd8e03658619925d02ad0276cc2f51"
    end
    on_intel do
      url "https://github.com/wlkr-si/agents-view/releases/download/v0.1.1/agents-view_0.1.1_darwin_amd64.tar.gz"
      sha256 "d00b89845a1775c93a9767c3e974156635b54224372c6d2473f2ded806ca7b7f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/wlkr-si/agents-view/releases/download/v0.1.1/agents-view_0.1.1_linux_arm64.tar.gz"
      sha256 "608fda0da63ec400375fb49d2f30f27435b51350ceb0d2f59603a83e7a50a3f5"
    end
    on_intel do
      url "https://github.com/wlkr-si/agents-view/releases/download/v0.1.1/agents-view_0.1.1_linux_amd64.tar.gz"
      sha256 "7193c9da2833334734146365fd986486a2701434e702040bccb628b053cfc970"
    end
  end

  def install
    bin.install "agents-view"
  end

  test do
    assert_equal "agents-view v#{version}", shell_output("#{bin}/agents-view --version").strip
  end
end
