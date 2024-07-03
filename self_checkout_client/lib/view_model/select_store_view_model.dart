import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:self_checkout_client/model/store_model.dart';
import 'package:self_checkout_client/repository/store_repository.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:self_checkout_client/res/components/round_button.dart';
import 'package:self_checkout_client/res/components/row_data.dart';
import 'package:self_checkout_client/utils/routes/routes_name.dart';
import 'package:self_checkout_client/utils/utils.dart';
import 'package:sizer/sizer.dart';

class SelectStoreViewModel extends ChangeNotifier {
  final _storeRepo = StoreRepository();

  bool _isLoading = false;
  toggleLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  bool get loading => _isLoading;

  List<StoreModel> _storesList = [];

  List<StoreModel> get storesList => _storesList;

  List<Marker> _markers = [];

  List<Marker> get markers => _markers;

  StoreModel _selectedStore = StoreModel();
  setSelectedStore(StoreModel store) {
    _selectedStore = store;
    // notifyListeners();
  }

  StoreModel get getSelectedStore => _selectedStore;

  LatLng createLatLng(String val) {
    var new_val = val.split(',');
    double lat = double.parse(new_val[0].toString());
    double lng = double.parse(new_val[1].toString());
    return LatLng(lat, lng);
  }

  late BuildContext _context;

  void showSheet(StoreModel data) {
    print('${data.getapi} ${data.postapi}');
    showModalBottomSheet(
        context: _context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Wrap(
              children: [
                Center(
                  child: Text(
                    'Store Details',
                    style: Theme.of(_context).textTheme.bodyLarge!.copyWith(
                        fontSize: 25.sp, color: AppColors.primaryColor),
                  ),
                ),
                RowData(name: 'Name', value: data.storename.toString()),
                ButtonRound(
                  title: 'Start Order',
                  onPress: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RoutesName.placeOrderView,
                        arguments: data);
                  },
                  borderRadius: BorderRadius.circular(12.0),
                  padding: const EdgeInsets.all(0),
                  height: 50.0,
                ),
              ],
            ),
          );
        });
  }

  Future<List<StoreModel>> getStores(BuildContext context) async {
    _context = context;
    // print(context);
    _storeRepo.getStoresApi({}).then((val) {
      if (val.length > 0) {
        for (var i = 0; i < val.length; i++) {
          StoreModel el = StoreModel.fromJson(val[i]);
          _storesList.add(el);
          _markers.add(Marker(
            markerId: MarkerId(el.sId.toString()),
            position: createLatLng(el.latlng.toString()),
            onTap: () {
              if (kDebugMode) {
                print(_context);
                print(el.latlng.toString());
              }
              map_controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: createLatLng(el.latlng.toString()), zoom: 18)));
              Future.delayed(Duration.zero).then((value) {
                showSheet(el);
              });
            },
          ));
        }
        notifyListeners();
      }
      if (kDebugMode) {
        print(val);
        print({"stores list:", _storesList});
        print({"markers list:", _markers.toSet()});
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    });
    return _storesList;
  }

  //maps functions
  // Completer<GoogleMapController> map_controller =
  //     Completer<GoogleMapController>();

  late GoogleMapController map_controller;

  void _onMapCreated(GoogleMapController controller) {
    map_controller = controller;
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  // ignore: prefer_function_declarations_over_variables
  setCurrentLocation() async {
    getUserCurrentLocation().then((value) async {
      if (kDebugMode) {
        print(value.latitude.toString() + " " + value.longitude.toString());
      }

      // marker added for current users location

      // specified current users location
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 18,
      );

      // final GoogleMapController controller = await map_controller.future;
      // controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      map_controller
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      notifyListeners();
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    });
  }
}
