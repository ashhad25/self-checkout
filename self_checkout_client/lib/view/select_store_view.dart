import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:self_checkout_client/view_model/select_store_view_model.dart';
import 'package:sizer/sizer.dart';

import '../utils/utils.dart';

class SelectStoreView extends StatefulWidget {
  const SelectStoreView({super.key});

  @override
  State<SelectStoreView> createState() => _SelectStoreViewState();
}

class _SelectStoreViewState extends State<SelectStoreView> {
  List<Marker> _markers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final controller =
        Provider.of<SelectStoreViewModel>(context, listen: false);
    controller.getStores(context);
    // if (controller.storesList.isEmpty) {
    //   controller.getStores(context);
    // }
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.3789238, 68.3362088),
    zoom: 18,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<SelectStoreViewModel>(builder: (context, value, child) {
        return Scaffold(
          appBar: Utils.backButtonAppbar(context, 'Select Store', () {
            Navigator.pop(context);
          }),
          backgroundColor: AppColors.lightPrimaryColor,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 20, 255, 28),
            onPressed: () async {
              await value.setCurrentLocation();
            },
            child: Icon(
              Icons.location_on_outlined,
              color: AppColors.textIconColor,
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  compassEnabled: true,
                  zoomControlsEnabled: true,
                  markers: value.markers.toSet(),
                  onMapCreated: (GoogleMapController controller) {
                    value.map_controller = controller;
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
