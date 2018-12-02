import 'package:shared_preferences/shared_preferences.dart';

class SpUtils {
  final WAREHOUSE_ID_KEY = "WAREHOUSE_ID_KEY";

  factory SpUtils() => _getInstance();

  static SpUtils get instance => _getInstance();

  static SpUtils _instance;

  SharedPreferences sp;

  SpUtils._internal() {
    sp = SharedPreferences.getInstance() as SharedPreferences;
  }

  static SpUtils _getInstance() {
    if (_instance == null) {
      _instance = SpUtils._internal();
    }
    return _instance;
  }

  /*
   *设置仓库id
   */
  int getWarehouseId() {
    return sp.getInt(WAREHOUSE_ID_KEY);
  }

  setWareHouseId(int warehouseId) {
    sp.setInt(WAREHOUSE_ID_KEY, warehouseId);
  }
}
