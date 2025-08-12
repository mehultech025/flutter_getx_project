import 'package:flutter/material.dart';
import 'package:flutter_getx_project/constant/app_strings.dart';
import 'package:flutter_getx_project/models/user_profile_res_model.dart';
import 'package:flutter_getx_project/screens/profile/controller/profile_controller.dart';
import 'package:flutter_getx_project/screens/profile/widget/user_card.dart';
import 'package:flutter_getx_project/widgets/custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

late ProfileController controller;

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ProfileController>(
        builder: (controller) {
          return PagedListView<int, Data>(
            pagingController: controller.pagingController,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            builderDelegate: PagedChildBuilderDelegate<Data>(
              itemBuilder: (context, item, index) {
                return UserCard(data: item);
              },
              noItemsFoundIndicatorBuilder: (_) =>
                  Center(child: CustomTextWidget(text: AppStrings.noDataTextKey)),
              newPageProgressIndicatorBuilder: (_) =>
                  const Center(child: CircularProgressIndicator()),
              firstPageProgressIndicatorBuilder: (_) => SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                width: MediaQuery.of(context).size.width,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        },
      ),
    );
  }
}
