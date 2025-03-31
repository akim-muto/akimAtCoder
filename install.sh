#!/bin/bash
#
# Ubuntu インストールシェルスクリプト ひな型
#
# このスクリプトは、Ubuntu の Web サーバー環境構築を目的としたひな型です。
# ※実運用前に内容を十分に確認し、必要に応じて修正してください。
#

# エラーハンドリングと安全な実行環境の設定
set -euo pipefail
IFS=$'\n\t'

# Use package manager Flag
pm=0

# ログ出力用関数
log_info() {
    echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - $*"
}

log_error() {
    echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') - $*" >&2
}

# display the help
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -h, --help       このヘルプメッセージを表示"
    exit 1
}

# arg processing
while [[ "${1:-}" != "" ]]; do
    case $1 in
        -h | --help )
            usage
            ;;
        --pm)
            pm=1
            ;;
        *)
            log_error "不明なオプション: $1"
            usage
            ;;
    esac
    shift
done

if [[ $EUID -ne 0 ]]; then
    log_error "Please root user. You can use sudo."
    exit 1
fi

# Check Ubuntu Version
UBUNTU_VERSION=$(lsb_release -rs)
log_info "Ubuntu バージョン: $UBUNTU_VERSION"

log_info "Update package..."
apt update && apt upgrade -y

log_info "Start Install related package..."
apt install -y git build-essential gcc g++ curl
echo "Done"

# Check nodejs and npm
if ! command -v node >/dev/null 2>&1 || ! command -v npm >/dev/null 2>&1; then
    echo "Not available nodejs and npm"
  
    if [ "$pm" -eq 1 ]; then
        echo "Use pm Flag On"
        echo "Install NVM..."
        curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
        
        # Activate NVM on current bash session
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        
        echo "Install nodejs and npm..."
        nvm install stable

        echo "done"
    else
        
        echo "Install nodejs and npm..."
        apt install nodejs npm

        echo "done"
    fi

fi

echo "install atcoder-cli"
npm install -g atcoder-cli
echo "Done"

# Check python
if ! command -v /usr/local/bin/python3 >/dev/null 2>&1; then
    echo "Not available python"
  
    if [ "$pm" -eq 1 ]; then
        echo "Use pm Flag On"
        echo "Install UV..."

        curl -LsSf https://astral.sh/uv/install.sh | bash
        
        # Activate NVM on current bash session
        export UV_DIR="$HOME/.local/bin"
        [ -s "$UV_DIR/env" ] && \. "$UV_DIR/env"

        # add uv shell completion
        uv generate-shell-completion

        echo "done"
    else
        echo "Install python3..."
        sudo apt install python3
        echo "done"
    fi

fi

# Clone akimAtCoder rep
git clone https://github.com/akim-muto/akimAtCoder.git

cd akimAtCoder

if [ "$pm" -eq 1 ]; then
        echo "Use pm Flag On"
        echo "Install online-judge-tools..."

        uv sync

        echo "done"
else
    echo "Install online-judge-tools..."

    pip3 install online-judge-tools

    echo "done"
fi 

log_info "インストールと初期設定が完了しました。"
exit 0
