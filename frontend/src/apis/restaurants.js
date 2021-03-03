import axios from 'axios';
//axiosはiimport axios from 'axios'; と、axios.get(...のように使うのが基本。
//今回はGETリクエストなので、axios.getですが、POSTであれば、axios.postになる。
import { restaurantsIndex } from '../urls/index'
//作成したURLの文字列をimportし、使っている部分
export const fetchRestaurants =() => {
  return axios.get(restaurantsIndex) //importした文字列に対して, axios.getでHTTPリクエストを投げています。
  .then(res => { //最終的にzxios.getした結果成功した場合はthen(...)にいき、失敗した場合はcatch(...)に入ります。
    return res.data //返り値をresという名前で取得し、res.dataでレスポンスの中身だけをreturnしている.
  })
  .catch((e) => console.error(e))
  //本来はここでバリデーションエラーメッセージなどを返すことで、フロントエンドでそれを画面に表示できます。
}

//関数を定義する前にひとつやらなければいけないことがある。axiosというHTTPクライアントを導入することです.
//これがあることで、ブラウザからHTTPリクエストを送ることが非常にシンプルになる。