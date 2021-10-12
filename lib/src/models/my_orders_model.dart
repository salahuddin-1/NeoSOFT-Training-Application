class MyOrdersModel {
  final String orderId;
  final String orderDate;
  final String amount;

  MyOrdersModel({
    required this.orderId,
    required this.orderDate,
    required this.amount,
  });
}

final myOrdersDummyList = <MyOrdersModel>[
  MyOrdersModel(
    orderId: '15879',
    orderDate: "07 Aug' 15",
    amount: '45',
  ),
  MyOrdersModel(
    orderId: '15871',
    orderDate: "08 Aug' 15",
    amount: '90',
  ),
  MyOrdersModel(
    orderId: '15872',
    orderDate: "07 Aug' 15",
    amount: '45',
  ),
  MyOrdersModel(
    orderId: '15873',
    orderDate: "09 Aug' 15",
    amount: '45',
  ),
  MyOrdersModel(
    orderId: '15874',
    orderDate: "10 Aug' 15",
    amount: '90',
  ),
  MyOrdersModel(
    orderId: '15876',
    orderDate: "01 Aug' 15",
    amount: '45',
  ),
];
