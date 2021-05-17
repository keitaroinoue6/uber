import axios from 'axios';
//axiosはimport axios from 'axios'; と、axios.get(...のように使うのが基本。
//今回はGETリクエストなので、axios.getですが、POSTであれば、axios.postになる。

import { restaurantsIndex } from '../urls/index' //作成したURLの文字列をimportし、使っている部分

export const fetchRestaurants =() => {
  return axios.get(restaurantsIndex) //axios.getの引数には文字列が必要では、ここではHTTPリクエストを投げる先のURL文字列が必要になります。
  .then(res => { //最終的にaxios.getした結果成功した場合はthen(...)にいき、失敗した場合はcatch(...)に入ります。
    return res.data //返り値をresという名前で取得し、res.dataでレスポンスの中身だけをreturnしている.
  })
  .catch((e) => console.error(e)) //失敗 例外が帰ってきた時にcatchに入ります。
  //本来はここでバリデーションエラーメッセージなどを返すことで、フロントエンドでそれを画面に表示できます。
}

//関数を定義する前にひとつやらなければいけないことがある。axiosというHTTPクライアントを導入することです.
//これがあることで、ブラウザからHTTPリクエストを送ることが非常にシンプルになる。


//こノファイルはフロントエンドからサーバーサイドのAPIを叩くための関数だけを定義します。