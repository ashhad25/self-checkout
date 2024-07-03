import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:self_checkout_client/model/product_model.dart';
import 'package:self_checkout_client/res/app_colors.dart';
import 'package:self_checkout_client/utils/routes/routes_name.dart';
import 'package:self_checkout_client/utils/utils.dart';
import 'package:self_checkout_client/view/scanner/qr_scanner_overlay.dart';
import 'package:self_checkout_client/view_model/place_order_view_model.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  String code = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Utils.backButtonAppbar(context, 'Scan Item', () {
          Navigator.pop(context);
        }),
        backgroundColor: AppColors.lightPrimaryColor,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Place the Barcode in the area',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(letterSpacing: 1, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Scanning will be started automatically',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    )),
                Consumer<PlaceOrderViewModel>(builder: (context, value, child) {
                  return Expanded(
                      flex: 4,
                      child: Container(
                        // color: Colors.green,
                        child: Stack(
                          children: [
                            MobileScanner(
                              allowDuplicates: true,
                              onDetect: (Barcode barcode,
                                  MobileScannerArguments? args) {
                                if (value.productsMap[barcode.rawValue] !=
                                    null) {
                                  Navigator.pushReplacementNamed(
                                      context, RoutesName.productDetailView,
                                      arguments:
                                          value.productsMap[barcode.rawValue]);
                                } else {
                                  Utils.displayFlushbar(
                                      context,
                                      'Not Found',
                                      '${barcode.rawValue} not found in data.',
                                      Colors.red);
                                }
                              },
                            ),
                            const QRScannerOverlay(
                                overlayColour: AppColors.lightPrimaryColor)
                          ],
                        ),
                      ));
                }),
                Expanded(
                    flex: 2,
                    child: Container(
                        // color: Colors.red,
                        )),
                // Stack(children: [
                //   MobileScanner(
                //     onDetect: (barcode, args) {
                //       print(barcode.rawValue);
                //     },
                //   ),
                //   QRScannerOverlay(
                //       overlayColour: Theme.of(context).scaffoldBackgroundColor)
                // ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
