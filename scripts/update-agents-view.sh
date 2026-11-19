#!/usr/bin/env bash
# Point Formula/agents-view.rb at the latest Agents View release.
# Reads only the public release and its checksums.txt; exits quietly when current.
set -euo pipefail
repo=wlkr-si/agents-view
formula=Formula/agents-view.rb
tag=$(gh release view --repo "$repo" --json tagName --jq .tagName)
version=${tag#v}
current=$(sed -n 's/^  version "\(.*\)"$/\1/p' "$formula")
if [ "$version" = "$current" ]; then
  echo "agents-view is current at $version"
  exit 0
fi
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
gh release download "$tag" --repo "$repo" --pattern checksums.txt --dir "$work"
sum() {
  local name="agents-view_${version}_$1.tar.gz" hash
  hash=$(awk -v name="$name" '$2 == name { print $1 }' "$work/checksums.txt")
  if ! printf '%s' "$hash" | grep -Eq '^[0-9a-f]{64}$'; then
    echo "missing checksum for $name" >&2
    exit 1
  fi
  printf '%s' "$hash"
}
url() { printf 'https://github.com/%s/releases/download/%s/agents-view_%s_%s.tar.gz' "$repo" "$tag" "$version" "$1"; }
cat > "$formula" <<RUBY
# frozen_string_literal: true

# Installs the published Agents View binary for the current OS and CPU.
class AgentsView < Formula
  desc "Local editor and source browser for AGENTS.md"
  homepage "https://github.com/$repo"
  version "$version"
  license "MIT"

  on_macos do
    on_arm do
      url "$(url darwin_arm64)"
      sha256 "$(sum darwin_arm64)"
    end
    on_intel do
      url "$(url darwin_amd64)"
      sha256 "$(sum darwin_amd64)"
    end
  end

  on_linux do
    on_arm do
      url "$(url linux_arm64)"
      sha256 "$(sum linux_arm64)"
    end
    on_intel do
      url "$(url linux_amd64)"
      sha256 "$(sum linux_amd64)"
    end
  end

  def install
    bin.install "agents-view"
  end

  test do
    assert_equal "agents-view v#{version}", shell_output("#{bin}/agents-view --version").strip
  end
end
RUBY
echo "agents-view updated $current -> $version"
