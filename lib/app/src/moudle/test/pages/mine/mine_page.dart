import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/mine_controller.dart';

class MinePage extends BaseEmptyPage<MineController> {
  const MinePage({super.key});

  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.pageBgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.pageBgColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 405,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      MyColors.bgLinearShapeColor1,
                      MyColors.bgLinearShapeColor2,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        ResName.mineBg,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 248,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: controller
                              .buildTitleItem()
                              .asMap()
                              .entries
                              .map<Widget>(
                                  (e) => _buildTitleBar(e.value.name, e.value.assetName,e.key))
                              .toList(),
                        ),
                        SizedBox(height: 24),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return _buildContentItem(
                                controller.buildLineItem()[index].name,
                                controller.buildLineItem()[index].assetName,
                                index
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox();
                            },
                            itemCount: controller.buildLineItem().length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildContentItem(String name, String assetName,int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: (){
          controller.onContentItemClicked(index);
        },
        child: Row(
          children: [
            Image.asset(
              assetName,
              width: 24,
              height: 24,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(child: Text(name)),
            Icon(Icons.arrow_right, size: 26),
          ],
        ),
      ),
    );
  }

  _buildTitleBar(String name, String assetName,int index) {
    return InkWell(
      onTap:(){controller.onLineItemClicked(index);} ,
      child: Column(
        children: [
          Image.asset(
            assetName,
            width: 32,
            height: 32,
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            name,
            style: const TextStyle(
              color: MyColors.textBlackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
