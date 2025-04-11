#!/usr/bin/env bash

# Paths to your template files
declare -A templates=(
  [Vesktop]="/home/$USER/Documents/void/void-templates/srcpkgs/vesktop/template"
  [Floorp]="/home/$USER/Documents/void/void-templates/srcpkgs/floorp-bin/template"
  [Brave]="/home/$USER/Documents/void/void-templates/srcpkgs/brave-browser/template"
  [YoutubeMusic]="/home/$USER/Documents/void/void-templates/srcpkgs/youtube-music/template"
)

# GitHub repos in format "user/repo"
declare -A github_repos=(
  [Vesktop]="Vencord/Vesktop"
  [Floorp]="Floorp-Projects/Floorp"
  [Brave]="brave/brave-browser"
  [YoutubeMusic]="th-ch/Youtube-Music"
)

# Function to get current version from template
get_current_version() {
  grep -E '^version=' "$1" | cut -d= -f2
}

# Function to get latest version from GitHub
get_latest_github_release() {
  curl -s "https://api.github.com/repos/$1/releases/latest" | jq -r .tag_name
}

# Loop through and check each package
for name in "${!templates[@]}"; do
  template_file="${templates[$name]}"
  github_repo="${github_repos[$name]}"

  current_version=$(get_current_version "$template_file")
  latest_version=$(get_latest_github_release "$github_repo")

  # Clean up version formatting if needed (e.g. strip 'v' prefix)
  current_clean=${current_version#v}
  latest_clean=${latest_version#v}

  if [[ "$current_clean" != "$latest_clean" ]]; then
    echo "$name: Update available! $current_version → $latest_version"
  else
    echo "$name: Up to date. ($current_version)"
  fi
done
