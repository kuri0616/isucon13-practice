#!/bin/bash

# スクリプト実行中にエラーが発生したら終了する
set -e

# ログディレクトリを作成（すでに存在する場合はエラーを無視）
mkdir -p ~/log

# MySQLのスローログを解析して保存
echo "Analyzing slow query log and saving the result..."
sudo pt-query-digest /var/log/mysql/mysql-slow.log > ~/log/$(date +mysql-slow.log-%m-%d-%H-%M -d "+9 hours")

# 古いスローログを削除
sudo rm /var/log/mysql/mysql-slow.log

# MySQLを再起動して新しいスローログを生成
echo "Restarting MySQL service to regenerate the slow query log..."
sudo systemctl restart mysql

# 完了メッセージ
echo "Script execution completed successfully."
