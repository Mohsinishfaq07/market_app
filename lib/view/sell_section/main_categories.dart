import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market/constants/constants.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/widgets/app_bar/custom_app_bar.dart';
import 'package:market/widgets/custom_dropdown/custom_dropdown.dart';

class MainCategoriesPage extends ConsumerWidget {
  const MainCategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<String, dynamic>> mainCategoryList =
        lists.mainCategoryListMap(context: context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: 'Main Categories'),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: mainCategoryList.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> categoryDetail = mainCategoryList[index];
              return ListTile(
                onTap: categoryDetail['onTap'],
                title: Text(categoryDetail['name']),
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