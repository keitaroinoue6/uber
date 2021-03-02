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
      </Switch>
    </Router>
  );
}

export default App;

// propsとは親・子コンポーネント間でのデータの「受け渡し口」のようなもの。
// 親コンポーネントから渡したいデータをpopsという箱に入れ、子コンポーネントもpropsという箱を受け取れるようにし、子コンポーネントの中でpropsの箱の中のデータを参照します。

//
