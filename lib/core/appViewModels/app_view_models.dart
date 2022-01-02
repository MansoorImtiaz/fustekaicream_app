import 'package:fusteka_icecreem/core/hooks/hooks.dart';
import 'package:fusteka_icecreem/core/models/all_products_model.dart';
import 'package:fusteka_icecreem/core/models/app_models.dart';
import 'package:fusteka_icecreem/core/models/categories_model.dart';
import 'package:fusteka_icecreem/core/models/sub_categories_model.dart';

class AppViewModels{
  List<CitiesViewModel>? cities;
  List<CategoriesViewModel>? categories;
  List<SubCategoriesViewModel>? subCategories;
  List<AllMekanosImagesViewModel>? allMekanosImages;
  List<WinnerMekanosViewModel>? winnerMekanos;
  List<WinnerLotteriesViewModel>? winnerLotteries;
  List<WinnerInstantGiftsViewModel>? winnerInstantGifts;
  List<ProductsViewModel>? products;
  SingleProduct? singleProduct;
  final SharedPref _sharedPref =  SharedPref();

  Future<void> fetchCities() async{
    final apiResult = await ApiServices().fetchCitiesAPI1();
    cities = apiResult?.map((e) => CitiesViewModel(e)).toList();
  }

  Future<void> fetchCategories() async{
    final apiResult = await ApiServices().fetchCategoriesAPI();
    categories = apiResult?.map((e) => CategoriesViewModel(e)).toList();
  }

  Future<void> fetchAllMekanosImages(BuildContext context, String userId) async{
    final apiResult = await ApiServices().fetchAllMekanosImagesAPI(context, userId);
    allMekanosImages = apiResult?.map((e) => AllMekanosImagesViewModel(e)).toList();
  }

  Future<void> fetchWinnerMekanos(BuildContext context, String userId) async{
    final apiResult = await ApiServices().fetchWinnerMekanosAPI(context, userId);
    winnerMekanos = apiResult?.map((e) => WinnerMekanosViewModel(e)).toList();
  }

  Future<void> fetchWinnerLotteries(BuildContext context, String userId) async{
    final apiResult = await ApiServices().fetchWinnerLotteriesAPI(context, userId);
    winnerLotteries = apiResult?.map((e) => WinnerLotteriesViewModel(e)).toList();
  }

  Future<void> fetchWinnerInstantGifts(BuildContext context, String userId) async{
    final apiResult = await ApiServices().fetchWinnerInstantGiftAPI(context, userId);
    winnerInstantGifts = apiResult?.map((e) => WinnerInstantGiftsViewModel(e)).toList();
  }

  Future<void> fetchOfferedProducts() async{
    final apiResult = await ApiServices().fetchOfferedProductsAPI()??[];
    products = apiResult.map((e) => ProductsViewModel(e)).toList();
  }

  Future<void> fetchAllProducts() async{
    final apiResult = await ApiServices().fetchAllProductsAPI()??[];
    products = apiResult.map((e) => ProductsViewModel(e)).toList();
  }

  Future<void> fetchSingleProduct(String id) async{
     singleProduct = await ApiServices().fetchSingleProductAPI(id);
  }

}

class CitiesViewModel {
  final Cities? citiesModel;
  CitiesViewModel(this.citiesModel);
}

class CategoriesViewModel {
  final Categories? categories;
  CategoriesViewModel(this.categories);
}

class SubCategoriesViewModel {
  final SubCategories? subCategories;
  SubCategoriesViewModel(this.subCategories);
}

class ProductsViewModel {
  final AllProducts? list;
  ProductsViewModel(this.list);
}

class SingleProductViewModel {
  final SingleProduct? singleProduct;
  SingleProductViewModel(this.singleProduct);
}

class AllMekanosImagesViewModel {
  final WinnerMekano? allMekanosImages;
  AllMekanosImagesViewModel(this.allMekanosImages);
}

class WinnerMekanosViewModel {
  final WinnerMekano? winnerMekanos;
  WinnerMekanosViewModel(this.winnerMekanos);
}

class WinnerLotteriesViewModel {
  final LotteriesOrInstant? winnerLotteries;
  WinnerLotteriesViewModel(this.winnerLotteries);
}

class WinnerInstantGiftsViewModel {
  final LotteriesOrInstant? winnerInstantGifts;
  WinnerInstantGiftsViewModel(this.winnerInstantGifts);
}