import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/routes.dart';
import '../getX/product_category_getX.dart';
import '../getX/sub_category_model_getX.dart';
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
      backgroundColor: Colors.white12,
      appBar: AppBar(
        titleTextStyle: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        centerTitle: true,
        title: const Text('Sub_Category'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: GetX<SubCategoryModelGetX>(
        initState: (state) {
          state.controller!.getSubCategoryData();
        },
        builder: (controller) {
          if (SubCategoryModelGetX.to.loading.isTrue) {
            const Center(child: CircularProgressIndicator());
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
          childAspectRatio: 4 / 3.3,
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
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
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
                      color: Colors.white30,
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
                      fontSize: 16,
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
    return const Center(child: CircularProgressIndicator());
  }
}
