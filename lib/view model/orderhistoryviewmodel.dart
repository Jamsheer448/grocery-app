import 'package:main_project/model/orderhistorymodel.dart';

class OrderHistoryViewModel {
  final Order order;

  OrderHistoryViewModel({required this.order});

  String get orderId {
    return this.order.id;
  }

  String get orderDate {
    return this.order.orderDate;
  }

  String get deliverydate {
    return this.order.deliveryDate;
  }

  String get totalAmount {
    return this.order.totalAmount;
  }

  String get quantityy {
    return this.order.quantity;
  }

  String get status {
    return this.order.status;
  }

  List<Product> get products {
    return this.order.products;
  }
}
