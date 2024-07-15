import 'package:my_flutter_module/framework/repository/introduction/model/request_update_industry.dart';

abstract class IntroductionRepository {
  Future getCampaign();

  Future getIndustryList();

  Future getUpdateIndustry(RequestUpdateIndustry requestUpdateIndustry);
}
