import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market/constants/constants.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/view/product_show/home_page_show.dart';
import 'package:market/widgets/custom_input/custom_input_field.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Search Page'),
      ),
      body: SafeArea(
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(
              builder: (_, WidgetRef ref, __) {
                return MyTextField(
                  onChanged: (val) {
                    ref.read(productSellProvider.searchProduct.notifier).state =
                        val;
                  },
                  hintText: 'Search Product',
                );
              },
            ),
            StreamBuilder<List<String>>(
              stream: firestoreService.fetchCategoryNames(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text("Error fetching data"));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No categories available"));
                }

                List<String> categoryNames = snapshot.data!;

                return SizedBox(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width - 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryNames.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Consumer(
                          builder: (_, WidgetRef ref, __) {
                            String categoryName = categoryNames[index];

                            return GestureDetector(
                              onTap: () {
                                String selectedCategoryString = categoryName;

                                final selectedCategoryEnum =
                                    Categories.values.firstWhere(
                                  (e) =>
                                      e.toString().split('.').last ==
                                      selectedCategoryString,
                                  orElse: () => Categories.mobiles,
                                );

                                ref
                                    .read(productSellProvider
                                        .selectedCategory.notifier)
                                    .state = selectedCategoryEnum;
                                debugPrint(
                                    'selectedCategoryEnum: $selectedCategoryEnum');
                              },
                              child: Chip(
                                label: Text(categoryNames[index]),
                                backgroundColor: Colors.blue.withOpacity(0.2),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Expanded(
              child: Consumer(
                builder: (_, WidgetRef ref, __) {
                  final selectedCategory =
                      ref.watch(productSellProvider.selectedCategory);
                  debugPrint(
                      'selectedCategory in 2nd builder: ${selectedCategory.name}');

                  return Consumer(
                    builder: (_, WidgetRef ref, __) {
                      final searchProduct =
                          ref.watch(productSellProvider.searchProduct);
                      return StreamBuilder<List<Map<String, dynamic>>>(
                        stream: firestoreService.fetchCategoryProducts(
                            categoryName: selectedCategory.name),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return const Center(
                                child: Text("Error fetching data"));
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text("No categories available"));
                          }

                          List<Map<String, dynamic>> products = snapshot.data!;
                          List<Map<String, dynamic>> filteredProducts =
                              searchProduct.isEmpty
                                  ? products
                                  : products.where((product) {
                                      return product['productCondition']
                                          .toString()
                                          .toLowerCase()
                                          .contains(
                                              searchProduct.toLowerCase());
                                    }).toList();
                          return SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: filteredProducts.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> product =
                                    filteredProducts[index];
                                debugPrint('${product.entries.map((entry) {
                                  return Text("${entry.key}: ${entry.value}");
                                }).toList()}');
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  child: HomePageProductShow(
                                      productData: product,
                                      productSellType: selectedCategory),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
