import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market/constants/constants.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/models/selling_models/headphone_model.dart';
import 'package:market/widgets/custom_input/custom_input_field.dart';

class AccessoryHeadphones extends ConsumerWidget {
  const AccessoryHeadphones({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Category: Accessories - Headphones'),
          const Text('HeadPhone Type'),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              return MyTextField(
                hintText: 'Wireless / Wired',
                onChanged: (val) {
                  ref.read(productSellProvider.headphoneType.notifier).state =
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
              final headPhoneType =
                  ref.watch(productSellProvider.headphoneType);
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
                      if (headPhoneType.isEmpty ||
                          productCondition.isEmpty ||
                          productTitle.isEmpty ||
                          productDescription.isEmpty ||
                          productPrice.isEmpty ||
                          productLocation.isEmpty) {
                        globalFunctions.showToast(
                            message: 'Please fill all the fields',
                            toastType: ToastType.error);
                      } else {
                        AccessoryHeadphonesModel accessoryHeadphonesModel =
                            AccessoryHeadphonesModel(
                          headphoneType: headPhoneType,
                          productCondition: productCondition,
                          productTitle: productTitle,
                          productDescription: productDescription,
                          productLocation: productLocation,
                          productPrice: productPrice,
                          images: ['functionality remaining'],
                          uploadedBy: FirebaseAuth.instance.currentUser!.uid,
                        );
                        await firestoreService.uploadProductData(
                          collectionName: "headphones",
                          productData: accessoryHeadphonesModel.toMap(),
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
