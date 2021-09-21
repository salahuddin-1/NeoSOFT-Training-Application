import 'package:neosoft_training_application/src/models/my_cart_model.dart';

class MyCartResources {
  var items = [
    MyCartModel(
      productImage:
          'https://artandantiqueshow.files.wordpress.com/2013/10/intro1.jpg?w=381&h=381',
      productName: 'Pembroke',
      productType: 'Table',
      quantity: 1,
      price: '45',
    ),
    MyCartModel(
      productImage:
          'https://mobileimages.lowes.com/productimages/d9d0258c-c639-468e-9ba0-14709fe8cba1/10268304.jpg?size=pdhi',
      productName: 'Adirondack',
      productType: 'Chair',
      quantity: 2,
      price: '90',
    ),
    MyCartModel(
      productImage:
          'https://cdn11.bigcommerce.com/s-42eba/images/stencil/500x659/products/767/12965/Conrad_96_Vintage_Cigar_Leather_Chesterfield_Sofa__00553.1426714137.jpg?c=2',
      productName: 'Chesterfield',
      productType: 'Sofa',
      quantity: 1,
      price: '45',
    ),
  ];
}
