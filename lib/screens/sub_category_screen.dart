import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../constants/routes.dart';
import '../getX/product_category_getX.dart';
import '../getX/sub_category_model_getX.dart';
import '../widgets/loading.dart';
import '../widgets/view_details.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final ProductCategoryGetX _productCategory = Get.put(ProductCategoryGetX());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.scaffoldColor,
      appBar: AppBar(
        title:  ViewDetails(
          data:AppLocalizations.of(context)!.sub_category ,
          fontFamily: FontsApp.fontBold,
          color: ColorsApp.green,
          fontSize: 24,
        ),
        iconTheme: const IconThemeData(color: ColorsApp.green),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: GetX<SubCategoryModelGetX>(
        initState: (state) {
          state.controller!.getSubCategoryData();
        },
        builder: (controller) {
          if (SubCategoryModelGetX.to.loading.isTrue) {
            return const Loading();
          }
          return listCategories();
        },
      ),
    );
  }

  Widget listCategories() {
    if (SubCategoryModelGetX.to.subCategory != null) {
      return GridView.builder(
        itemCount: SubCategoryModelGetX.to.subCategory!.data!.length,
        padding: const EdgeInsetsDirectional.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 190 / 200,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                _productCategory.id.value =
                    SubCategoryModelGetX.to.subCategory!.data![index].id;
              });
              Navigator.pushNamed(context, productCategoryScreen);
            },
            child: Container(
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                color: ColorsApp.background.withAlpha(117),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    alignment: AlignmentDirectional.center,
                    padding: const EdgeInsetsDirectional.only(bottom: 20),
                    child: Image(
                      image: NetworkImage(
                        SubCategoryModelGetX
                            .to.subCategory!.data![index].imageUrl,
                      ),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
                    width: double.infinity,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: ColorsApp.green,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: ViewDetails(
                      data: SubCategoryModelGetX
                          .to.subCategory!.data![index].nameEn,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      fontSize: 20,
                      color: ColorsApp.black,
                      fontFamily: FontsApp.fontMedium,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    return const Loading();
  }
}
