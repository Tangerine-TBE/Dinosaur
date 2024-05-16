import 'dart:io';

import 'package:app_base/mvvm/repository/edit_info_repo.dart';
import 'package:app_base/mvvm/repository/upload_repo.dart';
import 'package:flutter_oss_aliyun/flutter_oss_aliyun.dart';
import 'package:uuid/uuid.dart';

import '../../config/user.dart';
import '../../mvvm/model/home_bean.dart';
import '../../mvvm/model/oss_auth_bean.dart';
import '../../util/image.dart';

class UploadUtils {
  static upLoadFile(UpLoadRepo upLoadRepo, String fileType, String path,
      Function(String path) thenTodo) {
    upLoadRepo.getUploadAuth().then(
      (response2) async {
        if (response2.isSuccess) {
          if (response2.data?.data != null) {
            OssAuthBean ossAuthBean = response2.data!.data!;
            final auth = Auth(
              accessKey: ossAuthBean.accessKeyId,
              accessSecret: ossAuthBean.accessKeySecret,
              secureToken: ossAuthBean.securityToken,
              expire: ossAuthBean.expiration,
            );
            Client.init(
              ossEndpoint: "oss-cn-hangzhou.aliyuncs.com",
              bucketName: "cxw-user",
              authGetter: () => auth,
            );
            final bytes = await File(path).readAsBytes();
            final udid = const Uuid().v4();
            final targetPath = "src/pet/${udid.replaceAll("-", "")}";
            await Client().putObject(
              bytes,
              targetPath,
              option: PutRequestOption(
                onSendProgress: (count, total) {},
                override: true,
                aclModel: AclMode.inherited,
                storageType: StorageType.ia,
                headers: {"cache-control": "no-cache"},
              ),
            );
            thenTodo.call('https://cxw-user.oss-cn-hangzhou.aliyuncs.com/$targetPath');
          }
        }
      },
    );
  }
}
