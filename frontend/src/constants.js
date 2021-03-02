export const REQEST_STAGE = {
  //REQUEST_STAGEはAPIリクエスト中に画面が今どういう状態なのか?を知るための状態です。
  //REQUEST_STAGE.LOADINGであればAPIリクエスト中としてローディングを出せます。
  //REQUEST_STAGE.OKであれば成功したアラートを出すこともできます。
  INITIAL: 'INITIAL',
  LOADING: 'LOADING',
  OK: 'OK',
}

export const HTTP_STATUS_CODE = {
  NOT_ACCEPTABLE: 406,
}

//定数なので、全て大文字で定数名を定義している。大文字の変数名にすることでこの値が普遍で代入不可であることを明示しています。

//複数のコンポーネント、関数、モジュールから参照される値は別ファイルに定義しておく.
