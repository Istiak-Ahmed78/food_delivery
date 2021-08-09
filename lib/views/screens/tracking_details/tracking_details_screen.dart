import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/di_containers.dart';
import 'package:food_delivery/models/order_status.dart';
import 'package:food_delivery/models/ordered_info_model.dart';
import 'package:food_delivery/utils/methods.dart';
import 'package:food_delivery/utils/repos/firestore_repo.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ShowcaseTimelineTile extends StatelessWidget {
  final String productID;
  final String imageAddress, productTitle;
  final double productCost;
  const ShowcaseTimelineTile(
      {Key? key,
      required this.productID,
      required this.imageAddress,
      required this.productTitle,
      required this.productCost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CResources.white,
        appBar: AppBar(
          title: const Text(
            'Order tracking',
            style: TextStyle(
                color: CResources.blueGrey,
                fontFamily: Strings.notosansFontFamilly),
          ),
          backgroundColor: CResources.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: CResources.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder(
          future: services<FirestoreRepos>().getOrderDetailsDtat(productID),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData && snapshot.data?.data() != null) {
              print(snapshot.data?.data() ?? 'No Id');
              return HasDataWidget(
                imageAddress: imageAddress,
                productTitle: productTitle,
                productCost: productCost,
                orderInfoModel:
                    OrderedInfoModel.fromMap(snapshot.data!.data()!),
              );
            } else if (snapshot.data == null) {
              print(snapshot.data ?? 'No Id');
              return const Center(
                child: Text('No data avilble'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class HasDataWidget extends StatelessWidget {
  final OrderedInfoModel orderInfoModel;
  final String imageAddress, productTitle;
  final double productCost;
  const HasDataWidget(
      {Key? key,
      required this.orderInfoModel,
      required this.imageAddress,
      required this.productCost,
      required this.productTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Container(
                        height: 80,
                        width: 80,
                        margin: const EdgeInsets.only(right: 30),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: CResources.blueGrey,
                                offset: Offset(0, 3),
                                blurRadius: 7,
                                spreadRadius: 4),
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              image: NetworkImage(imageAddress),
                              fit: BoxFit.cover),
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productTitle,
                          style: const TextStyle(
                              color: CResources.blueGrey,
                              fontSize: 20,
                              fontFamily: Strings.notosansFontFamilly),
                        ),
                        const Text('৳ 30',
                            style: TextStyle(
                              fontFamily: Strings.notosansFontFamilly,
                              color: CResources.red,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              OrderStatusListWidget(
                delivertyStatus:
                    Methods.getStatusFromInt(orderInfoModel.orderState),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderStatusListWidget extends StatelessWidget {
  final DelivertyStatus delivertyStatus;
  const OrderStatusListWidget({Key? key, required this.delivertyStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: OrderStatusModel.getOrderSatatusList(DelivertyStatus.delivered)
          .length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.1,
        isFirst: index == 0,
        isLast: index ==
            OrderStatusModel.getOrderSatatusList(delivertyStatus).length - 1,
        indicatorStyle: IndicatorStyle(
          width: 40,
          height: 40,
          indicator: Indicator(
            isDone: OrderStatusModel.getOrderSatatusList(delivertyStatus)[index]
                .isDone,
            undoneIcon:
                OrderStatusModel.getOrderSatatusList(delivertyStatus)[index]
                    .icon,
          ),
          drawGap: true,
        ),
        beforeLineStyle: const LineStyle(
          color: CResources.grey,
        ),
        endChild: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    OrderStatusModel.getOrderSatatusList(delivertyStatus)[index]
                        .title,
                    style: const TextStyle(
                        color: CResources.blueGrey,
                        fontSize: 17,
                        fontFamily: Strings.notosansFontFamilly),
                  ),
                  subtitle: Text(
                    OrderStatusModel.getOrderSatatusList(delivertyStatus)[index]
                        .subTitle,
                    style: const TextStyle(
                        color: CResources.blueGrey,
                        fontFamily: Strings.notosansFontFamilly),
                  ),
                ),
                Container()
                // delivertyStatus == DelivertyStatus.onTheWay &&
                //         OrderStatusModel.getOrderSatatusList(
                //                     delivertyStatus)[index]
                //                 .title ==
                //             'On the way'
                //     ? const TrackingOnTheMapWidget()
                //     : Container(),
              ],
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({Key? key, required this.isDone, required this.undoneIcon})
      : super(key: key);

  final bool isDone;
  final IconData undoneIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDone ? CResources.blueGrey : null,
        border: Border.fromBorderSide(
          BorderSide(
            color: isDone ? CResources.white.withOpacity(0.4) : CResources.grey,
            width: 4,
          ),
        ),
      ),
      child: isDone
          ? const Center(
              child: Icon(
              Icons.check,
              color: CResources.white,
            ))
          : Icon(
              undoneIcon,
              color: CResources.blueGrey,
              size: 18,
            ),
    );
  }
}

class TrackingOnTheMapWidget extends StatefulWidget {
  const TrackingOnTheMapWidget({Key? key}) : super(key: key);

  @override
  State<TrackingOnTheMapWidget> createState() => _TrackingOnTheMapWidgetState();
}

class _TrackingOnTheMapWidgetState extends State<TrackingOnTheMapWidget> {
  LatLng? currentpososition;
  late BitmapDescriptor markerIcon;
  GoogleMapController? _mapController;
  Set<Marker> markers = {};
  Set<Polyline> polilines = {};
  List<LatLng> poliliensCordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  // LatLng startingPoint = const LatLng(22.50760141993664, 91.80680017513873);
  LatLng startingPoint = const LatLng(26.48424, 50.04551);
  LatLng endpoint = const LatLng(26.46423, 50.06358);

  void setMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(devicePixelRatio: 2.5), '')
        .then((value) {
      markerIcon = value;
    });
  }

  void getUserCurrentPosition() async {
    var currentPosition = await Geolocator.getCurrentPosition();
    currentpososition =
        LatLng(currentPosition.latitude, currentPosition.longitude);
  }

  void onMapCreated(GoogleMapController contro) {
    _mapController = contro;
    animateCamera(startingPoint);
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    _mapController!.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      check(u, c);
    }
  }

  void animateCamera(LatLng position) {
    _mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 11.0)));
  }

  void initZoom() {
    LatLngBounds bounds =
        LatLngBounds(southwest: startingPoint, northeast: endpoint);
    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
    _mapController!.animateCamera(cameraUpdate).then((value) {
      check(cameraUpdate, _mapController!);
    });
  }

  setTwoPoints() {
    markers.add(Marker(
        markerId: const MarkerId('Staeting from'), position: startingPoint));
    markers.add(Marker(
        markerId: const MarkerId(
          'Customers position',
        ),
        position: endpoint));
    setState(() {});
  }

  void setPoliense(PointLatLng startingpoint, PointLatLng destination) async {
    PolylineResult polies = await polylinePoints.getRouteBetweenCoordinates(
        Sectrets.googleMapApiKey, startingpoint, destination,
        travelMode: TravelMode.driving);
    if (polies.points.isNotEmpty) {
      polies.points.forEach((element) {
        poliliensCordinates.add(LatLng(element.latitude, element.longitude));
      });

      setState(() {
        Polyline polyline = Polyline(
            polylineId: const PolylineId('Poly'),
            points: poliliensCordinates,
            color: CResources.blueGrey);
        polilines.add(polyline);
      });
    } else {
      print('Polylines is emty');
    }
  }

  @override
  void initState() {
    super.initState();
    setTwoPoints();
    setPoliense(PointLatLng(startingPoint.latitude, startingPoint.longitude),
        PointLatLng(endpoint.latitude, endpoint.longitude));
    // initZoom();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width * 0.7,
      color: CResources.green,
      child: Center(
        child: GoogleMap(
          onMapCreated: onMapCreated,
          markers: markers,
          polylines: polilines,
          mapType: MapType.terrain,
          zoomGesturesEnabled: true,
          trafficEnabled: true,
          initialCameraPosition: const CameraPosition(
              target: LatLng(22.47017028372685, 91.78719147490759),
              zoom: 11.0,
              tilt: 0.0,
              bearing: 0.0),
        ),
      ),
    );
  }
}
