import 'package:get/get.dart';
import 'package:xuriti/models/core/reward_model.dart';
import 'package:xuriti/models/services/dio_service.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import '../../util/common/endPoints_constant.dart';

class RewardManager extends GetxController {
  Rx<RewardModel?> rewardsDataResponse = RxNullable<RewardModel?>().setNull();

  getRewards() async {
    String url = getRewardUrl;

    dynamic responseData = await DioClient().get(url);
    if (responseData == null) {
      return [];
    }

    if (responseData == null) {
      return [];
    }

    rewardsDataResponse.value = RewardModel.fromJson(responseData);

    return rewardsDataResponse.value;
  }
}
