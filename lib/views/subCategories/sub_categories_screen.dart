import 'package:fusteka_icecreem/core/hooks/hooks.dart';
import 'package:fusteka_icecreem/views/subCategories/sub_categories_body.dart';

class SubCategoriesScreen extends StatelessWidget {
  final String catId;
  final String title;
  const SubCategoriesScreen({Key? key, required this.catId, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubCategoriesBody(catId: catId, title: title);
  }
}
