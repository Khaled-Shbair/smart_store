import '../../shared_preferences/pref_controller.dart';
import '../../../getX/sub_category_model_getX.dart';
import '../../widgets/view_details.dart';
import 'package:flutter/material.dart';
import '../../getX/category_getX.dart';
import '../../constants/routes.dart';
import '../../constants/colors.dart';
import '../../widgets/loading.dart';
import '../../constants/fonts.dart';
import 'package:get/get.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text('category'.tr)),
      body: GetX<CategoryGetX>(
        builder: (controller) {
          if (_category.loading.isTrue) {
            return const Loading();
          }
          return listCategory();
        },
      ),
    );
  }

  Widget listCategory() {
    if (_category.category != null) {
      return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsetsDirectional.all(15),
        physics: const BouncingScrollPhysics(),
        itemCount: _category.category!.data!.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: ColorsApp.background.withAlpha(117),
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
                data: PrefController().language == 'en'
                    ? _category.category!.data![index].nameEn
                    : _category.category!.data![index].nameAr,
                fontSize: 22,
                fontFamily: FontsApp.fontMedium,
                color: ColorsApp.black,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: ColorsApp.green,
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
      );
    }
    return const Loading();
  }
}
