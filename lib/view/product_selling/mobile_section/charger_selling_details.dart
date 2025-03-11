import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market/constants/constants.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/models/selling_models/charger_model.dart';
import 'package:market/widgets/custom_input/custom_input_field.dart';

class AccessoryCharger extends ConsumerWidget {
  const AccessoryCharger({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Category: Accessories - Charger'),
          const Text('Device Type'),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              return MyTextField(
                hintText: 'Enter Device Type',
                onChanged: (val) {
                  ref
                      .read(productSellProvider.chargerForDevice.notifier)
                      .state = val;
                },
              );
            },
          ),
          const Text('Type'),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              return MyTextField(
                hintText: 'C Type or other',
                onChanged: (val) {
                  ref.read(productSellProvider.chargerType.notifier).state =
                      val;
                },
              );
            },
          ),
          const Text('Condition'),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              return MyTextField(
                hintText: 'Old/New',
                onChanged: (val) {
                  ref
                      .read(productSellProvider.productCondition.notifier)
                      .state = val;
                },
              );
            },
          ),
          const Text('Ad Title'),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              return MyTextField(
                hintText: 'Enter Title',
                onChanged: (val) {
                  ref.read(productSellProvider.productTitle.notifier).state =
                      val;
                },
              );
            },
          ),
          const Text('Description'),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              return MyTextField(
                hintText: 'Enter Description',
                onChanged: (val) {
                  ref
                      .read(productSellProvider.productDescription.notifier)
                      .state = val;
                },
              );
            },
          ),
          const Text('Location'),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              return MyTextField(
                hintText: 'Enter Location',
                onChanged: (val) {
                  ref.read(productSellProvider.productLocation.notifier).state =
                      val;
                },
              );
            },
          ),
          const Text('Price'),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              return MyTextField(
                hintText: 'Enter Price',
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  ref.read(productSellProvider.productPrice.notifier).state =
                      val;
                },
              );
            },
          ),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              final chargerForDevice =
                  ref.watch(productSellProvider.chargerForDevice);
              final chargerType = ref.watch(productSellProvider.chargerType);
              final productCondition =
                  ref.watch(productSellProvider.productCondition);
              final productTitle = ref.watch(productSellProvider.productTitle);
              final productDescription =
                  ref.watch(productSellProvider.productDescription);
              final productPrice = ref.watch(productSellProvider.productPrice);
              final productLocation =
                  ref.watch(productSellProvider.productLocation);

              return Center(
                child: ElevatedButton(
                    onPressed: () async {
                      if (chargerForDevice.isEmpty ||
                          chargerType.isEmpty ||
                          productCondition.isEmpty ||
                          productTitle.isEmpty ||
                          productDescription.isEmpty ||
                          productPrice.isEmpty ||
                          productLocation.isEmpty) {
                        globalFunctions.showToast(
                            message: 'Please fill all the fields',
                            toastType: ToastType.error);
                      } else {
                        AccessoryChargerModel accessoryChargerModel =
                            AccessoryChargerModel(
                          chargerForDevice: chargerForDevice,
                          chargerType: chargerType,
                          productCondition: productCondition,
                          productTitle: productTitle,
                          productDescription: productDescription,
                          productLocation: productLocation,
                          productPrice: productPrice,
                          images: ['functionality remaining'],
                          uploadedBy: FirebaseAuth.instance.currentUser!.uid,
                        );
                        await firestoreService.uploadProductData(
                          collectionName: "chargers",
                          productData: accessoryChargerModel.toMap(),
                        );
                      }
                    },
                    child: const Text('Post')),
              );
            },
          )
        ],
      ),
    );
  }
}
