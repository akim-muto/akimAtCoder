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

# ログ出力用関数
log_info() {
    echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - $*"
}

log_error() {
    echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') - $*" >&2
}

# ヘルプメッセージの表示
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -h, --help       このヘルプメッセージを表示"
    exit 1
}

# コマンドライン引数の処理
while [[ "${1:-}" != "" ]]; do
    case $1 in
        -h | --help )
            usage
            ;;
        *)
            log_error "不明なオプション: $1"
            usage
            ;;
    esac
    shift
done

# このスクリプトは root 権限で実行する必要があります
if [[ $EUID -ne 0 ]]; then
    log_error "このスクリプトは root 権限で実行してください。"
    exit 1
fi

# Ubuntu のバージョン確認 (任意)
UBUNTU_VERSION=$(lsb_release -rs)
log_info "Ubuntu バージョン: $UBUNTU_VERSION"

# システムパッケージの更新・アップグレード
log_info "システムパッケージの更新を開始します..."
apt update && apt upgrade -y

# 必要なパッケージのインストール
# 例として Nginx、Git、curl をインストールします。用途に合わせてパッケージを追加してください。
log_info "必要なパッケージのインストールを開始します..."
apt install -y nginx git curl

# Nginx サービスの起動と自動起動設定
log_info "Nginx サービスの起動と自動起動設定を行います..."
systemctl start nginx
systemctl enable nginx

# ファイアウォールの設定 (例: UFW を使用して Nginx のアクセスを許可)
if command -v ufw >/dev/null 2>&1; then
    log_info "UFW がインストールされています。ファイアウォールの設定を行います..."
    ufw allow 'Nginx Full'
    ufw --force enable
else
    log_info "UFW がインストールされていません。必要に応じて別途ファイアウォール設定を行ってください。"
fi

# ユーザー定義のカスタム設定
# ここに Web サーバー用の設定ファイルの配置や SSL 証明書の取得、その他初期設定を追加してください。

log_info "インストールと初期設定が完了しました。"
exit 0
