import 'package:my_flutter_module/framework/provider/local_storage/hive/hive_provider.dart';
import 'package:my_flutter_module/framework/provider/local_storage/local_const.dart';

class UserExperior {
  static addEvent(String eventName, String data, String type) async {
    try {
      String aggId = await HiveProvider.get(LocalConst.agentID) ?? "110";
      if (aggId == "110") {
        print(".....TU..log");
      } else {
        // js.context.callMethod("experierCalled", [eventName, data, type]);
        ///todo userexperier functionality
      }
    } catch (e) {
      print("..error..at..UserExperior${e.toString()}");
    }
  }
}
