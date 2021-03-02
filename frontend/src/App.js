import React from 'react';
import './App.css';
import {
  BrowserRouter as Router,
  Switch,
  Route,
} from "react-router-dom";

// components
import { Restaurants } from './containers/Restaurants.jsx';
import { Foods } from './containers/Foods.jsx';
import { Orders } from './containers/Orders.jsx';

function App() {
  return (
    <Router>
      <Switch>
        // 店舗一覧ページ
        <Route
          exact
          // exactというpropsはデフォルトではfalseになっており、ここをtrueにすると明示しなくても、exactとするだけでok
          path="/restaurants">
          <Restaurants />
        </Route>
        // フード一覧ページ
        <Route
          exact
          path="/foods"
        >
          <Foods />
        </Route>
        // 注文ページ
        <Route
          exact
          path="/orders">
          <Orders />
        </Route>
        <Route
          exact
          path="/restaurants/:restaurantsId/foods" //パラメータとして設定したい部分は:paramNameと: をつけます
          render={({ match }) => //コンポーネントにmatchというpropsを渡しながら、設定したPATHに対応するリクエストがあった場合にパラメーターと一緒にコンポーネントをレンダリングします
            <Foods
              match={match}
            />
          }
          />
      </Switch>
    </Router>
  );
}

export default App;

// propsとは親・子コンポーネント間でのデータの「受け渡し口」のようなもの。
// 親コンポーネントから渡したいデータをpopsという箱に入れ、子コンポーネントもpropsという箱を受け取れるようにし、子コンポーネントの中でpropsの箱の中のデータを参照します。

// propsにはふたつ書き方がある
// export const ChildComponent = (props) => {
//   // (1) props.idの方法で取得する方法
//   const hoge = () => { props.id }
// }

// export const ChildComponent = ({ id }) => {
//   // (2) idと直接key名を指定してデータを参照する方法
//   const hoge = () => { id }
// }

