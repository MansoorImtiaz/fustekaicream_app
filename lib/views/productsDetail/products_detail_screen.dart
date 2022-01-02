import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class ProductsDetailScreen extends StatelessWidget {
  final String productId;
  final String price;
  const ProductsDetailScreen({Key? key, required this.productId, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductsDetailBody(productId: productId, price: price);
  }
}
