#!/usr/bin/env bash
#Copyright 2024 The dahliaOS Authors

#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at

#    http://www.apache.org/licenses/LICENSE-2.0

#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.

set -euo pipefail

VERSION="0.1.0"
INSTALL_DIR="/lib/flutter"
sudo_user_home=$(eval echo "~$USER")

# Check for OS and architecture

if [[ ${OS:-} = Windows_NT ]]; then
    echo 'error: This script only works on Linux0' >&2
    exit 1
fi

if [[ $(uname) = Darwin ]]; then
    echo 'error: This script only works on Linux' >&2
    exit 1
fi

# Check for required dependencies

command -v unzip >/dev/null ||
    error 'unzip is required to install Flutter/Dart'

command -v tar >/dev/null ||
    error 'tar is required to install Flutter/Dart'

command -v wget >/dev/null ||
    error 'wget is required to install Flutter/Dart'

command -v git >/dev/null ||
    error 'git is required to install Flutter/Dart'

banner=$(cat << "EOF"
       __            __        __  __             ______    ______
      /  |          /  |      /  |/  |           /        /
  ____$$ |  ______  $$ |____  $$ |$$/   ______  /$$$$$$  |/$$$$$$  |
 /    $$ | /        $$        $$ |/  | /  $$ |  $$ |  $$__$$/
/$$$$$$$ | $$$$$$  |$$$$$$$  |$$ |$$ | $$$$$$  |$$ |  $$ |$$
$$ |  $$ | /    $$ |$$ |  $$ |$$ |$$ | /    $$ |$$ |  $$ | $$$$$$
$$  __$$ |/$$$$$$$ |$$ |  $$ |$$ |$$ |/$$$$$$$ |$$  __$$ |/   __$$
$$    $$ |$$    $$ |$$ |  $$ |$$ |$$ |$$    $$ |$$    $$/ $$    $$/s
 $$$$$$$/  $$$$$$$/ $$/   $$/ $$/ $$/  $$$$$$$/  $$$$$$/   $$$$$$/
EOF
)

echo -e "\e[31m$banner\e[0m"
echo -e "\e[31m\n     DahliaOS - Flutter/Dart Manager - Version $VERSION\n     By Quinten Van Damme & Co\n\e[0m"

spinner() {
    local pid=$1
    local delay=0.1
    local spin='-\|'

    while ps -p $pid > /dev/null; do
        for i in $(seq 0 2); do
            echo -n -e "\b${spin:i:1}"
            sleep $delay
        done
    done

    # remove all the spinner stuff
    echo -ne "\b\b\b\b"

    if [ $? -eq 0 ]; then
        echo -e "\e[32m✅ Done!\e[0m"
    else
        echo -e "\e[31m❌ Error!\e[0m"
    fi

    echo -e "\b"
}

check_flutter_installed() {
    local file_path="$INSTALL_DIR/flutter/bin/flutter"
    if [ -f "$file_path" ]; then
        echo "true"
    else
        echo "false"
    fi
}

get_file_contents() {
    local file_path="$1"

    if [ -f "$file_path" ]; then
        local file_contents
        file_contents=$(<"$file_path")
        echo "$file_contents"
    else
        echo -e "\e[31merror: Flutter is not installed.\e[0m"
        exit 1
    fi
}

get_flutter_version() {
    local file_path="$INSTALL_DIR/flutter/version"
    local version=$(get_file_contents "$file_path")
    echo "$version"
}

get_dart_version() {
    local file_path="$INSTALL_DIR/flutter/bin/cache/dart-sdk/version"
    local version=$(get_file_contents "$file_path")
    echo "$version"
}

prepare_flutter_dir() {
    if [ ! -d "$INSTALL_DIR" ]; then
        mkdir -p "$INSTALL_DIR"
    fi

    chown -R "$USER":"$USER" "$INSTALL_DIR"
}

download_unpack_stable_release_archive() {
    local jsonUrl="https://raw.githubusercontent.com/leoafarias/fvm/main/releases_linux.json"
    local json_data=$(curl -s "$jsonUrl")

    local archiveName=$(echo "$json_data" | grep -m 1 -o '"archive": "[^"]*' | cut -d '"' -f 4)
    local version=$(echo "$json_data" | grep -m 1 -o '"version": "[^"]*' | cut -d '"' -f 4)
    local dartVersion=$(echo "$json_data" | grep -m 1 -o '"dart_sdk_version": "[^"]*' | cut -d '"' -f 4)
    local sha256=$(echo "$json_data" | grep -m 1 -o '"sha256": "[^"]*' | cut -d '"' -f 4)

    if [ -n "$archiveName" ] && [ -n "$version" ] && [ -n "$sha256" ]; then
        local downloadUrl="https://storage.googleapis.com/flutter_infra_release/releases/$archiveName"
        local archiveFileName=$(echo "$archiveName" | awk -F/ '{print $NF}')
        curl -o "/tmp/$archiveFileName" "$downloadUrl" > /dev/null 2>&1 &
        echo -e "Downloading Flutter SDK v$version [\e[34mStable\e[0m]"
        pid=$!
        spinner $pid
        wait

        # Calculate the actual SHA-256 hash of the zip file
        actual_sha256=$(sha256sum "/tmp/$archiveFileName" | cut -d ' ' -f 1)

        # Compare the actual hash to the expected hash
        if [ "$actual_sha256" != "$sha256" ]; then
            echo -e "\e[31merror: SHA-256 hash does not match. The file may be corrupted or tampered with.\e[0m"
            exit 1
        fi

        tar xf "/tmp/$archiveFileName" -C "$INSTALL_DIR" > /dev/null 2>&1 &
        echo "Unpacking Binary"
        pid=$!
        spinner $pid
        wait
    else 
        echo -e "\e[31merror: No stable release found.\e[0m"
        exit 1
    fi
}

finish_install() {
    case $(basename "$SHELL") in
    fish)
        echo -e "\n# Flutter\nset --export PATH $INSTALL_DIR/flutter/bin" >> $sudo_user_home/.config/fish/config.fish
        ;;
    zsh)
        echo -e "\n# Flutter\nexport PATH=\"\$PATH:$INSTALL_DIR/flutter/bin\"" >> $sudo_user_home/.zshrc
        ;;
    bash)
        echo -e "\n# Flutter\nexport PATH=\"\$PATH:$INSTALL_DIR/flutter/bin\"" >> $sudo_user_home/.bashrc
        ;;
    esac
    
    flutter precache > /dev/null 2>&1 &
    echo "Downloading Dart SDK"
    pid=$!
    spinner $pid
    wait

    echo -e "\n\e[32m✅ installed successfully!\e[0m"
    echo -e "Installed Flutter v$(get_flutter_version) [\e[34mStable\e[0m]"
    echo -e "Installed Dart v$(get_dart_version) [\e[34mStable\e[0m]"
    echo "Restart your shell to apply changes."
}

install()
{
    if [ "$(check_flutter_installed)" = "true" ]; then
        echo -e "Flutter is already installed."
        exit 0
    fi

    prepare_flutter_dir
    download_unpack_stable_release_archive
    finish_install
}

update()
{
    if [ "$(check_flutter_installed)" = "false" ]; then
        install
        exit 0
    fi


    local jsonUrl="https://raw.githubusercontent.com/leoafarias/fvm/main/releases_linux.json"
    local json_data=$(curl -s "$jsonUrl")

    local version=$(echo "$json_data" | grep -m 1 -o '"version": "[^"]*' | cut -d '"' -f 4)
    local dartVersion=$(echo "$json_data" | grep -m 1 -o '"dart_sdk_version": "[^"]*' | cut -d '"' -f 4)

    # if the version is the same as the installed version, exit
    if [ "$version" = "$(get_flutter_version)" ]; then
        if [ "$dartVersion" = "$(get_dart_version)" ]; then
            echo -e "Flutter is already up to date."
            exit 0
        fi
    fi

    flutter upgrade > /dev/null 2>&1 &
    echo "Upgrading Flutter SDK"
    pid=$!
    spinner $pid
    wait

    flutter precache > /dev/null 2>&1 &
    echo "Downloading Dart SDK"
    pid=$!
    spinner $pid
    wait
}

remove()
{
    if [ "$(check_flutter_installed)" = "false" ]; then
        echo -e "\e[31merror: Flutter is not installed or not located in $INSTALL_DIR\e[0m"
        exit 0
    fi

    local flutter_version=$(get_flutter_version)
    local dart_version=$(get_dart_version)

    rm -rf "$INSTALL_DIR"
    echo -e "\e[32m✅ removed flutter v$flutter_version & dart v$dart_version successfully!\e[0m";

    # remove flutter from shell config
    
    sudo_user_home=$(eval echo "~$SUDO_USER")

    case $(basename "$SHELL") in
    fish)
        sed -i '/# Flutter/d' $sudo_user_home/.config/fish/config.fish
        sed -i '/flutter/d' $sudo_user_home/.config/fish/config.fish
        ;;
    zsh)
        sed -i '/# Flutter/d' $sudo_user_home/.zshrc
        sed -i '/flutter/d' $sudo_user_home/.zshrc
        ;;
    bash)
        sed -i '/# Flutter/d' $sudo_user_home/.bashrc
        sed -i '/flutter/d' $sudo_user_home/.bashrc
        ;;
    esac
}

specify_action() {
    echo -e "     Please specify an action:\n"
    echo "     $0 install"
    echo "     $0 update"
    echo "     $0 remove"
    exit 1
}

if [ $# -eq 0 ]; then
    specify_action
fi

case "$1" in
    install)
        install
        ;;
    update)
        update
        ;;
    remove)
        remove
        ;;
    *)
        specify_action
        ;;
esac