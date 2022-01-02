import 'package:fusteka_icecreem/core/hooks/hooks.dart';
import 'package:fusteka_icecreem/views/subCategories/sub_categories_body.dart';

class AppConstants{

  static const List<ProductsLocal> categoriesList = <ProductsLocal>[
    ProductsLocal(title: 'Cat One', icon: AppAssets.wrap_1, quantity: '150ML'),
    ProductsLocal(title: 'Cat Two', icon: AppAssets.wrap_2, quantity: '130ML'),
    ProductsLocal(title: 'Cat Three', icon: AppAssets.wrap_3, quantity: '140ML'),
    ProductsLocal(title: 'Cat Four', icon: AppAssets.wrap_4, quantity: '160ML'),
    ProductsLocal(title: 'Cat Three', icon: AppAssets.wrap_3, quantity: '140ML'),
    ProductsLocal(title: 'Cat One', icon: AppAssets.wrap_1, quantity: '150ML'),
  ];

  static const List<SubCategoriesLocal> selectedCategories = <SubCategoriesLocal>[
    SubCategoriesLocal(id: '1', title: 'One'),
    SubCategoriesLocal(id: '2', title: 'Two'),
    SubCategoriesLocal(id: '3', title: 'Three'),
  ];

  static const List<ContestCampaignsModel> contestCampaignsList = <ContestCampaignsModel>[
    ContestCampaignsModel(circle: AppAssets.circleDarkPurple,  icon: AppAssets.campaignsInstantGift, title: 'instant_gift_tr', content: 'participate_and_win_tr'),
    ContestCampaignsModel(circle: AppAssets.circleRed,  icon: AppAssets.campaignsLottery, title: 'lottery_tr', content: 'participate_and_win_tr'),
    ContestCampaignsModel(circle: AppAssets.circleYellow,  icon: AppAssets.campaignsMekano, title: 'mekano_tr', content: 'participate_and_win_tr'),

  ];

  static const List<ProductsLocal> productsList = <ProductsLocal>[
    ProductsLocal(title: 'Ice-Cream One', icon: AppAssets.wrap_1, quantity: '150ML'),
    ProductsLocal(title: 'Ice-Cream Two', icon: AppAssets.wrap_2, quantity: '130ML'),
    ProductsLocal(title: 'Ice-Cream Three', icon: AppAssets.wrap_3, quantity: '140ML'),
    ProductsLocal(title: 'Ice-Cream Four', icon: AppAssets.wrap_4, quantity: '160ML'),
    ProductsLocal(title: 'Ice-Cream Three', icon: AppAssets.wrap_3, quantity: '140ML'),
    ProductsLocal(title: 'Ice-Cream One', icon: AppAssets.wrap_1, quantity: '150ML'),
  ];

  static const List<CampaignGalleryLocal> galleryList = <CampaignGalleryLocal>[
    CampaignGalleryLocal(name: 'Hina Shabir', image: AppAssets.slide3),
    CampaignGalleryLocal(name: 'Ahmad hassan', image: AppAssets.slide2),
    CampaignGalleryLocal(name: 'Ali Ghafour', image: AppAssets.slide1),
  ];

  static List<RangeModel> rangeList =  <RangeModel>[
    RangeModel(range: '5-15'),
    RangeModel(range: '16-24'),
    RangeModel(range: '25+'),
  ];

  static String currentScreen = 'login';
  static const String login = 'login';
  static const String signup = 'signup';
  static const String categories = 'categories';
  static const String subCategories = 'subCategories';
  static const String products = 'products';
  static const String campaigns = 'campaigns';
  static const String me = 'me';

  static const double btnTextSize = 0.02;
  static const double btnVerPadding = 0.014;
  static const double smallTextSize = 0.014;
  static const double textFieldVerPadding = 0.014;
  static const double textFieldHorPadding = 0.02;
  static const double screenTopHeading = 0.026;
  static const double screenTopHeadingContent = 0.018;
  static const double textFieldTitle = 0.02;
  static const double lonGapBWWidgets = 0.06;
  static const double passEyeSize = 0.025;
  static const double screenVerPadding = 0.02;
  static const double screenHorPadding = 0.06;
  /*
  * AppConstants.screenVerPadding
  * */
}