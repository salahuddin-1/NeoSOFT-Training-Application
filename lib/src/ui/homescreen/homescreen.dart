import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_application/src/blocs_api/get_account_details_BLOC.dart';
import 'package:neosoft_training_application/src/blocs_api_flutter_bloc/get_list_cart_items_BLOC.dart';
import 'package:neosoft_training_application/src/blocs_api_flutter_bloc/order_BLOC.dart';
import 'package:neosoft_training_application/src/models/account_details_model.dart';
import 'package:neosoft_training_application/src/models/get_list_cart_items_model.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/ui/login/login.dart';
import 'package:neosoft_training_application/src/ui/login/logout.dart';
import 'package:neosoft_training_application/src/ui/my_account/my_account.dart';
import 'package:neosoft_training_application/src/ui/my_orders/my_orders.dart';
import 'package:neosoft_training_application/src/ui/neo_store/neo_store_screen.dart';
import 'package:neosoft_training_application/src/ui/product_listing/my_cart.dart';
import 'package:neosoft_training_application/src/ui/product_listing/product_listing.dart';
import 'package:neosoft_training_application/src/widgets/carousel.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:neosoft_training_application/src/constants/images.dart';
import 'package:neosoft_training_application/src/widgets/circular_progress.dart';
import 'package:neosoft_training_application/src/widgets/error_widget.dart';
import 'package:sizer/sizer.dart';

Map<String, String?> credentials = {};

class HomeScreen extends StatefulWidget {
  final Map<String, String?> credentials;

  HomeScreen({
    required this.credentials,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    credentials = this.widget.credentials;
    _getAccountDetailsBLOC = GetAccountDetailsBLOC();
    super.initState();
  }

  GetListCartItemsBLOC? _getListCartItemsBLOC;
  late final GetAccountDetailsBLOC _getAccountDetailsBLOC;
  String? profilePhoto;

  @override
  void didChangeDependencies() {
    _getListCartItemsBLOC = BlocProvider.of<GetListCartItemsBLOC>(context);
    _getListCartItemsBLOC!.add(Status.LOADING);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _getAccountDetailsBLOC.dispose();
    _getListCartItemsBLOC!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
      drawer: _drawer(),
    );
  }

  Drawer _drawer() {
    return Drawer(
      child: Container(
        color: Grey,
        child: StreamBuilder<ApiResponse<GetAccountDetailsResponseModel>>(
          stream: _getAccountDetailsBLOC.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressCustom(),
                  );

                case Status.ERROR:
                  return ErrorWidgetCustom(
                    message: snapshot.data!.message!,
                    onPressed: () {
                      _getAccountDetailsBLOC.getAccDetails();
                    },
                  );

                case Status.COMPLETED:
                  profilePhoto =
                      snapshot.data!.data!.data!.userData!.profilePic!;

                  return BlocBuilder<GetListCartItemsBLOC,
                      ApiResponse<GetListCartItemsResponse>>(
                    builder: (context, state) {
                      if (state.status == Status.LOADING) {
                        return Center(
                          child: CircularProgressCustom(),
                        );
                      } else if (state.status == Status.ERROR) {
                        return ErrorWidgetCustom(
                          message: state.message!,
                          onPressed: () {
                            _getListCartItemsBLOC!.add(Status.LOADING);
                          },
                        );
                      } else if (state.status == Status.COMPLETED) {
                        final cartItemsLength = state.data!.count;

                        return ListView(
                          children: [
                            _drawerHeader(),
                            SizedBox(height: 3.h),
                            _drawerItems(
                              title: 'My Cart',
                              image: 'MyCart',
                              trailing: cartItemsLength != null
                                  ? _cartIemCount(cartItemsLength)
                                  : SizedBox.shrink(),
                              onPressed: () {
                                Push(
                                  context,
                                  screen: BlocProvider(
                                    create: (context) => GetListCartItemsBLOC(),
                                    child: MyCart(),
                                  ),
                                );
                              },
                            ),
                            _drawerItems(
                                title: 'Tables',
                                image: 'Tables',
                                onPressed: () {
                                  Push(context,
                                      screen: ProductListing(title: 'Tables'));
                                }),
                            _drawerItems(
                                title: 'Sofas',
                                image: 'Sofas',
                                onPressed: () {
                                  Push(context,
                                      screen: ProductListing(title: 'Sofas'));
                                }),
                            _drawerItems(
                                title: 'Chairs',
                                image: 'Chairs',
                                onPressed: () {
                                  Push(context,
                                      screen: ProductListing(title: 'Chairs'));
                                }),
                            _drawerItems(
                                title: 'Cupboards',
                                image: 'Cupboards',
                                onPressed: () {
                                  Push(context,
                                      screen:
                                          ProductListing(title: 'Cupboards'));
                                }),
                            _drawerItems(
                                title: 'My Account',
                                image: 'MyAccount',
                                onPressed: () {
                                  Push(context, screen: MyAccount());
                                }),
                            _drawerItems(
                                title: 'Store Locator',
                                image: 'StoreLocator',
                                onPressed: () {
                                  Push(context, screen: NeoStoreScreen());
                                }),
                            _drawerItems(
                              title: 'My Orders',
                              image: 'MyOrders',
                              onPressed: () {
                                Push(
                                  context,
                                  screen: BlocProvider(
                                    create: (context) => OrdersListBLOC(),
                                    child: MyOrders(),
                                  ),
                                );
                              },
                            ),
                            _drawerItems(
                              title: 'Logout',
                              image: 'Logout',
                              onPressed: _logout,
                            ),
                          ],
                        );
                      }
                      return SizedBox.shrink();
                    },
                  );

                default:
                  return SizedBox.shrink();
              }
            }

            return Center(
              child: CircularProgressCustom(),
            );
          },
        ),
      ),
    );
  }

  void _logout() {
    LogOut.logout();
    PushAndRemoveUntil(
      context,
      screen: LoginScreen(),
    );
  }

  Container _cartIemCount(int cartItemsLength) {
    return Container(
      alignment: Alignment.center,
      child: Text("$cartItemsLength"),
      height: 8.w,
      width: 8.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Red,
      ),
    );
  }

  Column _drawerItems({
    required String title,
    required String image,
    Widget? trailing,
    Function? onPressed,
  }) {
    return Column(
      children: [
        Divider(
          color: Colors.black,
          thickness: 0.5,
          height: 0,
        ),
        ListTile(
          onTap: () {
            onPressed!();
          },
          leading: Container(
            child: CachedNetworkImage(
              imageUrl: iconImages[image]!,
              color: Colors.white,
              height: 7.w,
              width: 7.w,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
          trailing: trailing,
        ),
      ],
    );
  }

  Column _drawerHeader() {
    return Column(
      children: [
        _drawerProfilePhoto(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: FittedBox(
            child: Text(
              "Salahuddin Shaikh",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 19.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 1.5.h),
        FittedBox(
          child: Text(
            "salahuddinshaikh16@gmail.com",
            style: TextStyle(),
          ),
        ),
      ],
    );
  }

  Container _drawerProfilePhoto() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      height: 25.w,
      width: 25.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              profilePhoto!,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: Text(
        'NeoSTORE',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
        ),
      ),
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
            iconSize: 25.sp,
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
          iconSize: 25.sp,
        ),
      ],
    );
  }

  _body() {
    return Center(
      child: ListView(
        padding: EdgeInsets.only(bottom: 5.h),
        children: [
          Carousel(
            children: [
              for (int i = 0; i < images.length; i++) _image(images[i])
            ],
            indicatorInActiveColor: Red,
            indicatorActiveColor: Grey,
          ),
          _items(),
        ],
      ),
    );
  }

  Container _items() {
    return Container(
      height: 55.h,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                _Category(
                  top: 4.w,
                  bottom: 2.w,
                  left: 4.w,
                  right: 2.w,
                  child: Material(
                    color: Red,
                    child: InkWell(
                      onTap: () {
                        Push(
                          context,
                          screen: ProductListing(
                            title: "Tables",
                          ),
                        );
                      },
                      child: Ink(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.only(top: 20, right: 20),
                                alignment: Alignment.topRight,
                                child: Text(
                                  "Tables",
                                  textScaleFactor: 1.6,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20, left: 20),
                                alignment: Alignment.bottomLeft,
                                child: Image.network(
                                  iconImages['Tables']!,
                                  color: White,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _Category(
                  top: 4.w,
                  left: 2.w,
                  right: 4.w,
                  bottom: 2.w,
                  child: Material(
                    color: Red,
                    child: InkWell(
                      onTap: () {
                        Push(context, screen: ProductListing(title: 'Sofas'));
                      },
                      child: Ink(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.only(top: 20, right: 20),
                                alignment: Alignment.topRight,
                                child: Image.network(
                                  iconImages['Sofas']!,
                                  color: White,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20, left: 20),
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Sofas",
                                  textScaleFactor: 1.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                _Category(
                  top: 2.w,
                  left: 4.w,
                  right: 2.w,
                  bottom: 4.w,
                  child: Material(
                    color: Red,
                    child: InkWell(
                      onTap: () {
                        Push(context, screen: ProductListing(title: 'Chairs'));
                      },
                      child: Ink(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.only(top: 20, left: 20),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Chair",
                                  textScaleFactor: 1.6,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20, right: 20),
                                alignment: Alignment.bottomRight,
                                child: Image.network(
                                  iconImages['Chairs']!,
                                  color: White,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _Category(
                  top: 2.w,
                  left: 2.w,
                  right: 4.w,
                  bottom: 4.w,
                  child: Material(
                    color: Red,
                    child: InkWell(
                      onTap: () {
                        Push(context,
                            screen: ProductListing(title: 'Cupboards'));
                      },
                      child: Ink(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.only(top: 20, left: 20),
                                alignment: Alignment.topLeft,
                                child: Image.network(
                                  iconImages['Cupboards']!,
                                  color: White,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20, right: 20),
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  "Cupboards",
                                  textScaleFactor: 1.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _image(String image) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(image),
        ),
      ),
    );
  }
}

class _Category extends StatelessWidget {
  final double top;
  final double left;
  final double right;
  final double bottom;
  final Widget child;

  const _Category({
    Key? key,
    required this.top,
    required this.left,
    required this.right,
    required this.bottom,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
        ),
        color: Red,
        child: child,
      ),
    );
  }
}
