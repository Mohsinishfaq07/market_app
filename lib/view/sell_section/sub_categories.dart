import 'package:flutter/material.dart';
import 'package:market/constants/constants.dart';
import 'package:market/enums/global_enums.dart';
import 'package:market/widgets/app_bar/custom_app_bar.dart';

class SubCategoriesPage extends StatelessWidget {
  final List<Map<String, dynamic>> subCategoryList;
  const SubCategoriesPage({super.key, required this.subCategoryList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: 'Sub Categories'),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: subCategoryList.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> categoryDetail = subCategoryList[index];
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
