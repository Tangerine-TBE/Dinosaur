import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/search/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchPage extends BaseEmptyPage<SearchFriController> {
  const SearchPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        title: TextField(
          enabled: true,
          autofocus: true,
          minLines: 1,
          textInputAction: TextInputAction.done,
          cursorColor: MyColors.textBlackColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10.h,left: 10.w),
            hintText: '用户昵称或萌宠ID',
            constraints: BoxConstraints(maxHeight: 40.h,minHeight: 40.h),
            hintStyle: TextStyle(
              color: MyColors.textGreyColor.withAlpha(180),
            ),
            prefixIcon: Container(
              width: double.minPositive,
              alignment: Alignment.center,
              child: Icon(
                Icons.search,color: MyColors.textGreyColor.withAlpha(170),
              ),
            ),
            suffixIcon:Container(
              width: double.minPositive,
              alignment: Alignment.center,
              child: Icon(
                Icons.cancel_outlined,color: MyColors.textGreyColor.withAlpha(170),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.w),
              borderSide: BorderSide(color: MyColors.textGreyColor.withAlpha(145))
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.w),
                borderSide: BorderSide(color: MyColors.textGreyColor.withAlpha(145))
            ),
          ),
        ),
      ),
    );
  }
}
