import 'package:flutter_getx_project/api/repo/home_repo.dart';
import 'package:flutter_getx_project/api/repo/profile_repo.dart';
import 'package:flutter_getx_project/models/response_item.dart';
import 'package:flutter_getx_project/models/user_profile_res_model.dart';
import 'package:flutter_getx_project/widgets/app_snackbar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProfileController extends GetxController {
  PageController pageController = PageController();

  bool isLoading = false;

  UserProfileResModel? profileListResModel;

  static const pageSize = 10;
  final PagingController<int, Data> pagingController = PagingController(
    firstPageKey: 1,
  );

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      getProfileListData(pageKey);
    });
  }

  /// GET JOB LIST DATA
  Future<void> getProfileListData(int pageKey) async {
    Map<String, dynamic> body = {
      "page": "$pageKey",
    };

    isLoading = true;
    ResponseItem result = await ProfileRepo.profileList(body: body);
    try {
      if (result.status) {
        if (result.data != null) {
          profileListResModel = UserProfileResModel.fromJson(result.data);
          if (profileListResModel!.data != null) {
            try {
              final newItems = profileListResModel!.data ?? [];

              final isLastPage = pageKey >= (profileListResModel!.totalPages ?? 1);
              if (isLastPage) {
                pagingController.appendLastPage(newItems);
              } else {
                final nextPageKey = pageKey + 1;
                pagingController.appendPage(
                  newItems,
                  int.parse(nextPageKey.toString()),
                );
              }
            } catch (error) {
              pagingController.error = error;
            }
          }
          isLoading = false;
          update();
        } else {
          isLoading = false;
          showSnackBar(message: result.message.toString());
          update();
        }
      } else {
        isLoading = false;
        showSnackBar(message: result.message.toString());
        update();
      }
    } catch (e) {
      isLoading = false;
      showSnackBar(message: result.message.toString());
      update();
    }
    update();
  }
}
