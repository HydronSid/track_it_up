import 'package:track_it_up/Database/product_db_helper.dart';
import 'package:track_it_up/Screens/product_model.dart';

class CommonFunctions {
  List<Map<String, dynamic>> queryRows = [];
  Future<List<ProductModel>> getProductList() async {
    queryRows.toList().clear();
    queryRows = await getAllData();

    return queryRows
        .toList()
        .map(
          (e) => ProductModel.fromJson(e),
        )
        .toList();
  }
}
