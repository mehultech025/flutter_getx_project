import 'package:flutter_getx_project/api/repo/home_repo.dart';
import 'package:flutter_getx_project/models/home_list_res_model.dart';
import 'package:flutter_getx_project/models/response_item.dart';
import 'package:flutter_getx_project/widgets/app_snackbar.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeController extends GetxController {
  PageController pageController = PageController();

  bool isLoading = false;

  HomeListResModel? homeListResModel;

  static const pageSize = 10;
  final PagingController<int, Data> pagingController = PagingController(
    firstPageKey: 1,
  );

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      getHomeListData(pageKey);
    });
  }



  int hexToInt(String hex) {
    return int.parse(hex.replaceFirst('#', '0xff'));
  }

  Future<void> getHomeListData(int pageKey) async {
    Map<String, dynamic> body = {
      "page": "$pageKey",
    };

    isLoading = true;
    ResponseItem result = await HomeRepo.homeList(body: body);
    try {
      if (result.status) {
        if (result.data != null) {
          homeListResModel = HomeListResModel.fromJson(result.data);
          if (homeListResModel!.data != null) {
            try {
              final newItems = homeListResModel!.data ?? [];

              final isLastPage = pageKey >= (homeListResModel!.totalPages ?? 1);
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
