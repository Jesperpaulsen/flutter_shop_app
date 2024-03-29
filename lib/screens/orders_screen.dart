import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
//    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: Center(
          child: FutureBuilder(
              future: Provider.of<Orders>(context, listen: false)
                  .fetchAndSetOrders(),
              builder: (ctx, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  if (dataSnapshot.error != null) {
                    //error handling
                  } else {
                    return Consumer<Orders>(
                        builder: (ctx, orderData, child) => ListView.builder(
                              itemCount: orderData.orders.length,
                              itemBuilder: (ctx, i) =>
                                  OrderItem(orderData.orders[i]),
                            ));
                  }
                }
                return CircularProgressIndicator();
              })),
    );
  }
}
