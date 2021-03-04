import React, { Fragment, useEffect } from 'react';
import styled from 'styled-components'; //このようにすることでstyled-componentsを使うことができる

// apis
import { fetchRestaurants } from '../apis/restaurants';

// images
import MainLogo from '../images/logo.png';
import MainCoverImage from '../images/main-cover-image.png';

const HeaderWrapper = styled.div` 

  display: flex;
  justify-content: flex-start;
  padding: 8px 32px;
`;
//styyled.divでdivElementsに対してスタイルを当てています。ここではページの一番上部にあるヘッダー全体を定義しています。

const MainLogoImage = styled.img`
  height: 90px;
`
//style.imgのようにすることで、imgElementsに対してもスタイルを当てることができます。

const MainCoverImageWrapper = styled.div`
  text-align: center;
`;

const MainCover = styled.img`
  height: 600px;
`;

export const Restaurants = () => {
  useEffect(() => {
    fetchRestaurants()
    .then((data) =>
      console.log(data)
    )
  }, [])

  return (
    <Fragment>
      <HeaderWrapper>
        <MainLogoImage src={MainLogo} alt="main logo" />
      </HeaderWrapper>
      <MainCoverImageWrapper>
        <MainCover src={MainCoverImage} alt="main cover" />
      </MainCoverImageWrapper>
    </Fragment>
  )
}





//useEffect自体をimport { useEffect } from 'react'; このようにimportします。
//今回はコンポーネントのレンダリング時に一度だけ実行したいので、useEffectの第二引数に空配列[]を入れている。


//fetchRestaurants()は引数は取らずに、そのまま実行し、promiseを返します。
//成功した場合には、res.dataを返すので、その結果を(data)という形でここでは受け取り、そのままconsloe.log()に渡すことで、APIの返り値をコンソールに出すことができます。


//useEffectはReact16.8で追加されたReact Hooksの一つです。
//ファンクションコンポーネントの中で、従来使われてきたcomponentDidMountやcomponentDidUpdateなどと同じような動きをすることができます。
