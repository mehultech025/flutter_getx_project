import 'package:flutter/material.dart';
import 'package:flutter_getx_project/constant/app_strings.dart';
import 'package:flutter_getx_project/models/home_list_res_model.dart';
import 'package:flutter_getx_project/screens/home/controller/home_controller.dart';
import 'package:flutter_getx_project/screens/home/widget/resources_card.dart';
import 'package:flutter_getx_project/widgets/custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeController());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeController>(
        builder: (controller) {
          return PagedListView<int, Data>(
            pagingController: controller.pagingController,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            builderDelegate: PagedChildBuilderDelegate<Data>(
              itemBuilder: (context, item, index) {
                return ResourceCard(
                  resData: item,
                  hexToInt: controller.hexToInt,
                );
              },
              noItemsFoundIndicatorBuilder: (_) =>
                   Center(child: CustomTextWidget(text: AppStrings.noDataTextKey)),
              newPageProgressIndicatorBuilder: (_) =>
                  const Center(child: CircularProgressIndicator()),
              firstPageProgressIndicatorBuilder: (_) =>
                  SizedBox(
                      height: MediaQuery.of(context).size.height/1.3,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(child: CircularProgressIndicator())
                  )
            ),
          );
        },
      ),
    );
  }
}
