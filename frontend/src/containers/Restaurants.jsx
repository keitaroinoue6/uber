import React, { Fragment, useEffect } from 'react';
import { fetchRestaurants } from '../apis/restaurants';

export const Restaurants = () => {
  useEffect(() => {
    fetchRestaurants()
    .then((data) =>
      console.log(data)
      )
  },[])
  return (
    <Fragment>
      レストラン一覧
    </Fragment>
  )
}

//useEffect自体をimport { useEffect } from 'react'; このようにimportします。
//今回はコンポーネントのレンダリング時に一度だけ実行したいので、useEffectの第二引数に空配列[]を入れている。


//fetchRestaurants()は引数は取らずに、そのまま実行し、promiseを返します。
//成功した場合には、res.dataを返すので、その結果を(data)という形でここでは受け取り、そのままconsloe.log()に渡すことで、APIの返り値をコンソールに出すことができます。


//useEffectはReact16.8で追加されたReact Hooksの一つです。
//ファンクションコンポーネントの中で、従来使われてきたcomponentDidMountやcomponentDidUpdateなどと同じような動きをすることができます。
