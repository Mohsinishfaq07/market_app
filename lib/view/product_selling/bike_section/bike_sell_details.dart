import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market/constants/constants.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/models/selling_models/bike_model.dart';
import 'package:market/models/selling_models/cars_model.dart';
import 'package:market/widgets/custom_dropdown/custom_dropdown.dart';
import 'package:market/widgets/custom_input/custom_input_field.dart';

class BikeSell extends ConsumerWidget {
  const BikeSell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Category: Bike'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Product Images'),
              Consumer(
                builder: (_, WidgetRef ref, __) {
                  return ElevatedButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        final List<XFile> images =
                            await picker.pickMultiImage();
                        List<String> imagesList = [];
                        for (var image in images) {
                          imagesList.add(image.path);
                        }
                        ref
                            .read(productSellProvider.imageLists.notifier)
                            .state = imagesList;
                      },
                      child: Text('Add Images'));
                },
              ),
            ],
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey, width: 2),
            ),
            child: Consumer(
              builder: (_, WidgetRef ref, __) {
                final images = ref.watch(productSellProvider.imageLists);
                return ListView.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey, width: 2),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: FileImage(
                            File(
                              images[index],
                            ),
                          ),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              final updatedImages = List<String>.from(images);
                              updatedImages.removeAt(index);
                              ref
                                  .read(productSellProvider.imageLists.notifier)
                                  .state = updatedImages;
                            },
                            icon: Icon(Icons.delete, color: Colors.red)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Text('Bike Company Name'),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              final selectedBrand =
                  ref.watch(productSellProvider.bikeCompanyName);
              return CustomDropdown(
                items: [
                  'Select',
                  'Honda',
                  'Yamaha',
                  'Suzuki',
                  'Road Prince',
                  'Others'
                ],
                onChanged: (val) {
                  if (val != null) {
                    ref
                        .read(productSellProvider.bikeCompanyName.notifier)
                        .state = val;
                  }
                },
                selectedValue: selectedBrand.toString(),
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
              final bikeCompanyName =
                  ref.watch(productSellProvider.bikeCompanyName);
              final productTitle = ref.watch(productSellProvider.productTitle);
              final productCondition =
                  ref.watch(productSellProvider.productCondition);
              final productDescription =
                  ref.watch(productSellProvider.productDescription);
              final productPrice = ref.watch(productSellProvider.productPrice);
              final productLocation =
                  ref.watch(productSellProvider.productLocation);
              final images = ref.watch(productSellProvider.imageLists);
              return Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (bikeCompanyName.isEmpty ||
                        bikeCompanyName == 'Select' ||
                        productTitle.isEmpty ||
                        productCondition.isEmpty ||
                        productDescription.isEmpty ||
                        productPrice.isEmpty ||
                        images.isEmpty ||
                        productLocation.isEmpty) {
                      globalFunctions.showToast(
                          message: 'Please fill all the fields',
                          toastType: ToastType.error);
                    } else {
                      BikeSellModel carSell = BikeSellModel(
                        productTitle: productTitle,
                        productDescription: productDescription,
                        productLocation: productLocation,
                        productPrice: productPrice,
                        images: images,
                        uploadedBy: FirebaseAuth.instance.currentUser!.uid,
                        bikeCompanyName: bikeCompanyName,
                      );

                      await firestoreService.uploadProductData(
                        collectionName: "bikes",
                        productData: carSell.toMap(),
                      );

                      globalFunctions.showToast(
                          message: 'Posted Successfully',
                          toastType: ToastType.success);
                    }
                  },
                  child: const Text('Post Product'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
