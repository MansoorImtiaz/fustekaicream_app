import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class CategoryScreen extends StatelessWidget {
  final bool? isAppBar;
  const CategoryScreen({Key? key, required this.isAppBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoryBody(isAppBar: isAppBar);
  }
}
