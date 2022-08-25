import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_store/getX/sub_category_model_getX.dart';
import '../constants/String.dart';
import '../getX/category_getX.dart';
import '../widgets/view_details.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryGetX _category = Get.put(CategoryGetX());
  final SubCategoryModelGetX _subCategory = Get.put(SubCategoryModelGetX());

  @override
  Widget build(BuildContext context) {
    return GetX<CategoryGetX>(
      builder: (controller) {
        if (_category.loading.isTrue) {
          return const Center(child: CircularProgressIndicator());
        }
        return listCategory();
      },
    );
  }

  Widget listCategory() {
    if (_category.category != null) {
      return ListView.separated(
        padding: const EdgeInsetsDirectional.all(15),
        shrinkWrap: true,
        itemCount: _category.category!.data!.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(50),
            ),
            child: ListTile(
              contentPadding: const EdgeInsetsDirectional.only(
                top: 10,
                bottom: 10,
                start: 20,
                end: 20,
              ),
              leading: Image(
                image: NetworkImage(_category.category!.data![index].imageUrl),
              ),
              title: ViewDetails(
                data: _category.category!.data![index].nameEn,
                fontSize: 24,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.red,
              ),
              onTap: () {
                setState(() {
                  _subCategory.id.value = _category.category!.data![index].id;
                });
                Navigator.pushNamed(context, subCategoryScreen);
              },
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}
