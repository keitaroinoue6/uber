import React, { Fragment } from 'react';

export const Foods = (props) => {
  return(
    <Fragment>
      フード一覧
      <p>
        RestaurantIdは{props.match.params.restaurantId}です
      </p>
    </Fragment>
  )
}