import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class ProductsScreen extends StatelessWidget {
  final bool? isAppBar;
  const ProductsScreen({Key? key, required this.isAppBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductsBody(isAppBar: isAppBar);
  }
}
