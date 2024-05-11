import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/util/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:dinosaur/app/src/moudle/test/pages/mine/mine_controller.dart';

class MinePage extends BaseEmptyPage<MineController> {
  const MinePage({super.key});
  @override
  bool get canPopBack => false;
  @override
  Color get background => MyColors.pageBgColor;

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.pageBgColor,
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
                bottom: MediaQuery.of(context).size.width/3 * 2,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      MyColors.bgLinearShapeColor1,
                      MyColors.bgLinearShapeColor2,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        ResName.mineBg,
                      ),
                    ),
                  ),
                  child: Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      actions: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child:  Row(
                            children: [
                              InkWell(
                                onTap: (){controller.onEditInfoClicked();},
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap: (){controller.onSettingClicked();},
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: const Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    backgroundColor: Colors.transparent,
                    body: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 14),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: loadImageProvider(User.getUserAvator()),
                                  radius: 28,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      User.getUserNickName(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                     User.getUserId(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                             Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      User.getUserFansCount().toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Text(
                                      '粉丝',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 45,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      User.getUserFavorCount().toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Text(
                                      '关注',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 45,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      User.getUserLikeCount().toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Text(
                                      '获赞',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top:  MediaQuery.of(context).size.width/3 * 2,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: controller
                              .buildTitleItem()
                              .asMap()
                              .entries
                              .map<Widget>((e) => _buildTitleBar(
                                  e.value.name, e.value.assetName, e.key))
                              .toList(),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return _buildContentItem(
                                  controller.buildLineItem()[index].name,
                                  controller.buildLineItem()[index].assetName,
                                  index);
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

  _buildContentItem(String name, String assetName, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: () {
          controller.onContentItemClicked(index);
        },
        child: Row(
          children: [
            Image.asset(
              assetName,
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(child: Text(name)),
            const Icon(Icons.arrow_forward_ios_rounded, size: 20,color: MyColors.textGreyColor,),
          ],
        ),
      ),
    );
  }

  _buildTitleBar(String name, String assetName, int index) {
    return InkWell(
      onTap: () {
        controller.onLineItemClicked(index);
      },
      child: Column(
        children: [
          Image.asset(
            assetName,
            width: 32,
            height: 32,
          ),
          const SizedBox(
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
