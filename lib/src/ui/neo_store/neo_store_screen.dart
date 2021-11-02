import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neosoft_training_application/src/constants/images.dart';
import 'package:neosoft_training_application/src/models/neostore_location_model.dart';
import 'package:neosoft_training_application/src/widgets/common_appbar.dart';
import 'package:sizer/sizer.dart';

class NeoStoreScreen extends StatefulWidget {
  const NeoStoreScreen({Key? key}) : super(key: key);

  @override
  _NeoStoreScreenState createState() => _NeoStoreScreenState();
}

class _NeoStoreScreenState extends State<NeoStoreScreen> {
  late final CameraPosition _initialPosition;
  late final GoogleMapController _controller;

  final List<Marker> _markers = [];

  @override
  void initState() {
    _setinitialPosition();
    _setInitialLocationMarkers();

    super.initState();
  }

  void _setinitialPosition() {
    _initialPosition = CameraPosition(
      target: LatLng(
        19.298147194989234,
        72.85082876795798,
      ),
    );
  }

  void _setInitialLocationMarkers() {
    int i = 0;
    locations.forEach(
      (model) {
        _markers.add(
          Marker(
            markerId: MarkerId(
              i.toString(),
            ),
            position: LatLng(
              model.lattitude,
              model.longitude,
            ),
          ),
        );
        i++;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        title: "Store Locator",
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 30.h,
            child: GoogleMap(
              initialCameraPosition: _initialPosition,
              mapType: MapType.normal,
              onMapCreated: (controller) {
                _controller = controller;
                _onCreateAnimateToThisPosition();
              },
              onTap: (coordinate) => _onTapMapAnimateToLocation(coordinate),
              markers: _markers.toSet(),
            ),
          ),
          SizedBox(height: 1.h),
          for (int i = 0; i < locations.length; i++)
            InkWell(
              onTap: () => _onTapLocationListTile(i),
              child: _LocationListItem(
                title: locations[i].title,
                subtitle: locations[i].subtitle,
              ),
            ),
        ],
      ),
    );
  }

  void _onTapLocationListTile(int i) {
    double zoomRatio = 6;

    if (i == 1 || i == 2) {
      zoomRatio = 17;
    }
    _controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(locations[i].lattitude, locations[i].longitude),
        zoomRatio,
      ),
    );
  }

  void _onTapMapAnimateToLocation(LatLng coordinate) {
    _controller.animateCamera(
      CameraUpdate.newLatLng(
        coordinate,
      ),
    );
  }

  void _onCreateAnimateToThisPosition() {
    _controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(
          locations[2].lattitude,
          locations[2].longitude,
        ),
        5,
      ),
    );
  }
}

class _LocationListItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _LocationListItem({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 2.5.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 2.5.h,
                  child: CachedNetworkImage(
                    imageUrl: iconImages['StoreLocator']!,
                    height: 7.w,
                    width: 7.w,
                    color: Color(0xff4f4f4f),
                  ),
                ),
                SizedBox(width: 4.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.title,
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Container(
                      width: 80.w,
                      child: Text(
                        this.subtitle,
                        style: TextStyle(
                          color: Color(0xff4f4f4f),
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 4,
            color: Colors.grey,
            thickness: 0.4,
          ),
        ],
      ),
    );
  }
}
