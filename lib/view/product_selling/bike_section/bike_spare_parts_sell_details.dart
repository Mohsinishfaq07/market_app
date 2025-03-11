import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market/constants/constants.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/models/selling_models/bike_spare_parts_model.dart';
import 'package:market/models/selling_models/cars_spare_parts_model.dart';

import 'package:market/widgets/custom_input/custom_input_field.dart';

class BikeSparePartsSellDetails extends ConsumerWidget {
  const BikeSparePartsSellDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Category: Bike Spare Parts'),
          const Text('Brand Name'),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              return MyTextField(
                hintText: 'Enter Brand Name',
                onChanged: (val) {
                  ref.read(productSellProvider.productName.notifier).state =
                      val;
                },
              );
            },
          ),
          const Text('Ad title'),
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
          const Text('Condition'),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              return MyTextField(
                hintText: 'New/Old',
                onChanged: (val) {
                  ref
                      .read(productSellProvider.productCondition.notifier)
                      .state = val;
                },
              );
            },
          ),
          const Text('Add Description'),
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
          const Text('Add Location'),
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
          const Text('Add Price'),
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
              final productBrand = ref.watch(productSellProvider.productName);
              final productTitle = ref.watch(productSellProvider.productTitle);
              final productCondition =
                  ref.watch(productSellProvider.productCondition);
              final productDescription =
                  ref.watch(productSellProvider.productDescription);
              final productPrice = ref.watch(productSellProvider.productPrice);
              final productLocation =
                  ref.watch(productSellProvider.productLocation);

              return Center(
                child: ElevatedButton(
                    onPressed: () async {
                      if (productBrand.isEmpty ||
                          productTitle.isEmpty ||
                          productDescription.isEmpty ||
                          productPrice.isEmpty ||
                          productCondition.isEmpty ||
                          productLocation.isEmpty) {
                        globalFunctions.showToast(
                            message: 'Please fill all the fields',
                            toastType: ToastType.error);
                      } else {
                        BikeSparePartsModel bikeSparePartsSellDetailsModel =
                            BikeSparePartsModel(
                          productBrand: productBrand,
                          productTitle: productTitle,
                          productCondition: productCondition,
                          productDescription: productDescription,
                          productLocation: productLocation,
                          productPrice: productPrice,
                          images: ['functionality remaining'],
                          uploadedBy: FirebaseAuth.instance.currentUser!.uid,
                        );
                        await firestoreService.uploadProductData(
                          collectionName: "bikeSpareParts",
                          productData: bikeSparePartsSellDetailsModel.toMap(),
                        );
                      }
                    },
                    child: const Text('Post Product')),
              );
            },
          )
        ],
      ),
    );
  }
}
