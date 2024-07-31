import 'package:flutter/material.dart';

// String getAllShoes = """
// query GetAllShoes {
//   shoes(sort: "release_date:asc") {
//     id
//     brand
//     model
//     release_date
//     price
//     image_url

//   }
// }
// """;

String getAllShoes = """
query GetAllShoes {
  shoes(sort: "release_date:asc") {
    id
    brand
    model
    release_date
    price
    image_url
    image {
      url
    }
    raffles {
      retailer {
        id
        retailer_name
        retailer_image_link
      }
      id
      raffle_url
      raffle_type
      raffle_datetime
    }
  }
}

""";
