#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 track-slug /path/to/chord-chart.png /path/to/scale-diagram.png" >&2
  exit 1
fi

slug="$1"
chord_source="$2"
scale_source="$3"

if [[ ! "$slug" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
  echo "Track slug must be lowercase letters, numbers, and hyphens only." >&2
  exit 1
fi

if [[ ! -f "$chord_source" ]]; then
  echo "Chord chart file not found: $chord_source" >&2
  exit 1
fi

if [[ ! -f "$scale_source" ]]; then
  echo "Scale diagram file not found: $scale_source" >&2
  exit 1
fi

repo_root="$(git rev-parse --show-toplevel)"
target_dir="$repo_root/tracks/$slug"
mkdir -p "$target_dir"

cp "$chord_source" "$target_dir/chord-chart.png"
cp "$scale_source" "$target_dir/scale-diagram.png"

git -C "$repo_root" add "$target_dir/chord-chart.png" "$target_dir/scale-diagram.png"

if git -C "$repo_root" diff --cached --quiet; then
  echo "No asset changes to publish."
else
  git -C "$repo_root" commit -m "Add assets for $slug"
  git -C "$repo_root" push
fi

echo
echo "Chord diagram URL:"
echo "https://raw.githubusercontent.com/TimLemke/btbt-track-assets/main/tracks/$slug/chord-chart.png"
echo
echo "Scale diagram URL:"
echo "https://raw.githubusercontent.com/TimLemke/btbt-track-assets/main/tracks/$slug/scale-diagram.png"
