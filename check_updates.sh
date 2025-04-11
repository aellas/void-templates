#!/usr/bin/env bash

declare -A templates=(
  [Vesktop]="$HOME/Documents/void/void-templates/srcpkgs/vesktop/template"
  [Floorp]="$HOME/Documents/void/void-templates/srcpkgs/floorp-bin/template"
  [Brave]="$HOME/Documents/void/void-templates/srcpkgs/brave-browser/template"
  [YoutubeMusic]="$HOME/Documents/void/void-templates/srcpkgs/youtube-music/template"
  [Liquidctl]="$HOME/Documents/void/void-templates/srcpkgs/liquidctl/template"
)

declare -A github_repos=(
  [Vesktop]="Vencord/Vesktop"
  [Floorp]="Floorp-Projects/Floorp"
  [Brave]="brave/brave-browser"
  [YoutubeMusic]="th-ch/Youtube-Music"
  [Liquidctl]="liquidctl/liquidctl"
)

get_current_version() {
  grep -E '^version=' "$1" | cut -d= -f2
}

get_latest_github_release() {
  curl -s "https://api.github.com/repos/$1/releases/latest" | jq -r .tag_name
}

for name in "${!templates[@]}"; do
  template_file="${templates[$name]}"
  github_repo="${github_repos[$name]}"

  current_version=$(get_current_version "$template_file")
  latest_version=$(get_latest_github_release "$github_repo")

  current_clean=${current_version#v}
  latest_clean=${latest_version#v}

  if [[ "$current_clean" != "$latest_clean" ]]; then
    echo "$name: Update available! $current_version → $latest_version"
  else
    echo "$name: Up to date ($current_version)"
  fi
done
