import 'package:bizda_bor/fuatures/auth/data/models/user_model.dart';
import 'package:bizda_bor/fuatures/profile/data/models/order_model.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class OrdersRemoteDataSource {
  Future getOrders();
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  Dio dio;

  OrdersRemoteDataSourceImpl({required this.dio});

  @override
  Future getOrders() async {
    try {
      final box = Hive.box(UserData.boxKey);
      UserData? user = box.get(UserData.boxKey);
      final responce = await dio.request(
        '/orders/android/?user_id=${user?.user?.id}',
        options: Options(method: 'GET', headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Token ${user?.token}'
        }),
      );
      if (responce.statusCode == 200) {
        List<OrderModel> data = [];
        for (int i = 0; i < (responce.data as List).length; i++) {
          data.add(OrderModel.fromJson(responce.data[i]));
        }
        print(data);
        return data;
      }
    } catch (e) {
      print(e);
      return [];
    }
    return [];
  }
}
