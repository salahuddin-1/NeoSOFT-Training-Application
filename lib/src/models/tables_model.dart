import 'package:neosoft_training_application/src/constants/images.dart';

class TableModel {
  final String image;
  String price;
  final String tableName;
  final String shopName;
  int ratings;

  TableModel({
    required this.image,
    this.price: '27,800',
    required this.tableName,
    required this.shopName,
    this.ratings: 4,
  });
}

List<TableModel> tableModel = [
  TableModel(
    image: tableImages[0],
    price: '27,800',
    tableName: 'Stylish Modern Dining Tables',
    shopName: 'Aron Table Center',
    ratings: 4,
  ),
  TableModel(
    image: tableImages[1],
    price: '27,800',
    tableName: '4 Seater Dining Table',
    shopName: 'Future Furniture Center',
    ratings: 3,
  ),
  TableModel(
    image: tableImages[2],
    price: '27,800',
    tableName: '6 Seater Dining Table',
    shopName: 'Aron Table Center',
    ratings: 5,
  ),
  TableModel(
    image: tableImages[3],
    price: '27,800',
    tableName: 'Stylish 4 Seater Dining Tables',
    shopName: 'Aron Table Center',
    ratings: 3,
  ),
  TableModel(
    image: tableImages[4],
    price: '27,800',
    tableName: 'Stylish Table',
    shopName: 'Aron Table Center',
    ratings: 3,
  ),
  TableModel(
    image: tableImages[5],
    price: '27,800',
    tableName: 'Stylish Modern Dining Tables',
    shopName: 'Aron Table Center',
    ratings: 2,
  ),
  TableModel(
    image: tableImages[6],
    price: '27,800',
    tableName: 'Sharkness Table for Offices',
    shopName: 'Aron Table Center',
    ratings: 1,
  ),
  TableModel(
    image: tableImages[7],
    price: '27,800',
    tableName: 'Stylish Modern Dining Tables',
    shopName: 'Aron Table Center',
    ratings: 3,
  ),
  TableModel(
    image: tableImages[8],
    price: '27,800',
    tableName: 'Stylish Modern Dining Tables',
    shopName: 'Aron Table Center',
    ratings: 3,
  ),
  TableModel(
    image: tableImages[9],
    price: '27,800',
    tableName: 'Stylish Modern Dining Tables',
    shopName: 'Aron Table Center',
    ratings: 3,
  ),
];
