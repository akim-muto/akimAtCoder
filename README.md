# akimatcoder

[https://yuulis.hatenablog.com/entry/atcoder-cpp-env-build]

上記のURL先の記事を参考にatcorderの環境を制作中です。
ボイラーテンプレートとして使えるようにしようかと思ってます（すでにありそうだけど）

以下技術スタック

* Windows10(2024年の間にwindows11に移行予定、移行したらwindows10バージョンのサポートは終了)
* wsl2
* Ubuntu 24.04.1 LTS
* npm
* uv(pythonのパーケージマネージャ) [<https://docs.astral.sh/uv/getting-started/installation/>]
* vscode [<https://code.visualstudio.com/>]
* ac-library [<https://atcoder.jp/posts/517>] (ライセンスがCC0 1.0 Universalだったのでこのリポジトリに含まれています)
* atcoder-cli [<https://github.com/Tatamo/atcoder-cli>]
* online-judge-tools/oj [<https://github.com/online-judge-tools/oj>]

ToDo：

- [x] pythonのパーケージマネージャをuvに変更
  - [x] readmeを変更
- [ ] setup scriptを制作
  - [ ] <https://github.com/akim-muto/akimAtCoder.git>をクローン
  - [ ] uvをインストール
  - [ ] uvをプロジェクトでイニシャライズ
  - [ ] online-judge-toolsをインストール
  - [ ] npmをインストール
  - [ ] atcoder-cliをインストール
  - [ ] atcoder-cliをイニシャライズ
- [ ] atcoder-cliのコンフィグgit repを作る
- [ ] 導入方法をreadmeに追記
- [ ] readmeの英語版を製作
- [ ] コマンドを設定する
- [ ] ショートカットキーを設定する