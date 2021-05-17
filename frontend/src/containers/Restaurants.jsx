import React, { Fragment, useEffect} from 'react';
import {fetchRestaurants} from '../apis/restaurants';

export const Restaurants = () => {
  useEffect(() => {
    fetchRestaurants() //引数を取らずにそのまま実行しPromiseを返します。
    .then((data) => { //成功した場合はres.dataを返すのでその結果を(data)という形でここで受け取る
      console.log(data)
    })
  }, [])
  return(
    <Fragment>
      レストラン一覧
    </Fragment>
  )
}