import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_project/api/api_urls.dart';
import 'package:flutter_getx_project/constant/app_strings.dart';
import 'package:flutter_getx_project/utils/app_routes.dart';
import 'package:flutter_getx_project/widgets/custom_text_widget.dart';
import 'package:flutter_getx_project/widgets/gradient_background.dart';
import 'package:get/get.dart';

class ChatUserListScreen extends StatelessWidget {
  const ChatUserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),

                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: CustomTextWidget(
                          text:
                              '${AppStrings.somethingWrongTextKey}: ${snapshot.error}',
                          color: Colors.red,
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: CustomTextWidget(
                          text: AppStrings.noUserTextKey,
                          color: Colors.white,
                        ),
                      );
                    }

                    final userDocs = snapshot.data!.docs
                        .where(
                          (doc) => doc.id != ApiUrls.defaultName,
                        ) // Exclude current user
                        .toList();

                    if (userDocs.isEmpty) {
                      return Center(
                        child: CustomTextWidget(
                          text: AppStrings.noUserTextKey,
                          color: Colors.white,
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: userDocs.length,
                      itemBuilder: (context, index) {
                        final doc = userDocs[index];
                        final userName = doc['name'] ?? doc.id;

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: CustomTextWidget(
                              text: userName.substring(0, 1).toUpperCase(),
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          title: CustomTextWidget(
                            text: userName,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white54,
                            size: 16,
                          ),
                          onTap: () {
                            Get.toNamed(
                              Routes.chatScreen,
                              arguments: {
                                'currentUserName': ApiUrls.defaultName,
                                'userName': userName,
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
