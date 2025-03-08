import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market/constants/constants.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/widgets/app_bar/custom_app_bar.dart';
import 'package:market/widgets/custom_dropdown/custom_dropdown.dart';

class SellPage extends ConsumerWidget {
  const SellPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: 'Sell Page'),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: lists.categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  globalFunctions.showToast(
                      message: 'working on it', toastType: ToastType.info);
                },
                title: Text(lists.categories[index]),
                trailing: Icon(Icons.arrow_forward_ios),
              );
            },
          ),
        ));
  }
}


/*
Column(
          spacing: 20.0,
          children: [
            // Consumer(builder: (context, ref, child) {
            //   final mainSelectedCategory =
            //       ref.watch(sellSectionProvider.mainSelectedCategory);
            //   return CustomDropdown(
            //     items: lists.mainCategoryList,
            //     selectedValue: mainSelectedCategory,
            //     onChanged: (val) {
            //       if (val != null) {
            //         ref
            //             .read(sellSectionProvider.mainSelectedCategory.notifier)
            //             .state = val;
            //       }
            //     },
            //   );
            // }),
          ],
        ),
*/