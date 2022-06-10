# STEPN dummy contract

これはSTEPNダミーのコントラクトです。
基本的な機能やUIは似せますが、モバイルアプリではなくブラウザ上で動かすので、走る機能については実装しません。ではどのようにエナジーを消費させるのかと言うと、ボタン押すだけで走ったことにできるように実装したいと思います。

## Goal of this contract

- 自分自身のSolidityスキルを証明するため
- ポートフォリオとして公開するため

## Development process

1. 靴NFT（構造体）の定義
2. 靴を作成できるFunction
3. 靴一覧を返すFunction
4. オーナーのみが靴を作成できるModifier