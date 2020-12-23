# Usage
# $ source github_download_release.sh

github_download_latest_release() {
    curl -s https://api.github.com/repos/$1/releases/latest |
        grep "browser_download_url" |
        cut -d : -f 2,3 |
        tr -d \" |
        wget --show-progress -qi -
    # curl --fail --silent --show-error $url --output $file
}

github_get_latest_release() {
    curl --silent "https://api.github.com/repos/$1/releases/latest" # Get latest release from GitHub api
}

github_get_latest_release_version() {
    curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
        grep '"tag_name":' |                                          # Get tag line
        sed -E 's/.*"([^"]+)".*/\1/'                                  # Pluck JSON value
}

# Usage
# $ github_get_latest_release "creationix/nvm"
# v0.31.4

mcd() {
    mkdir -p $1
    cd $1
}

github_download_from_list() {
    while read -r line; do
        [[ -n "$line" ]] && github_download_latest_release_download $line
    done <$1
}

# Usage
# $ download_all plugin_list.txt

# example plugin_list.txt
#
# retorquere/zotero-auto-index
# jlegewie/zotfile
# ethanwillis/zotero-scihub
# wshanks/Zutilo
# retorquere/zotero-storage-scanner
# retorquere/zotero-better-bibtex
# MaxKuehn/zotero-scholar-citations
