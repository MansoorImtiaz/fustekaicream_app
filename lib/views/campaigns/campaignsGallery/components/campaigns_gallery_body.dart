import 'package:fusteka_icecreem/core/hooks/hooks.dart';
import 'package:fusteka_icecreem/views/campaigns/campaignsGallery/components/campaigns_gallery_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class CampaignGalleryLocal {
  const CampaignGalleryLocal({this.image, this.name});
  final String? image;
  final String? name;
}

class CampaignsGalleryBody extends StatefulWidget {
  const CampaignsGalleryBody({Key? key}) : super(key: key);

  @override
  _CampaignsGalleryBodyState createState() => _CampaignsGalleryBodyState();
}

class _CampaignsGalleryBodyState extends State<CampaignsGalleryBody> {
  bool _connectionStatus = false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final AppFunctions _appFunctions = AppFunctions();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  List<GalleryUserRecord> userRecordList = [];
  int currentPage = 1;
  late int totalPages;
  bool? result = false;
  String noDataMsg = 'plz_wait_tr';

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }


  Future<bool>? callGalleryApi({bool isRefresh = false}) async{
    bool isRecord = false;
        // _appFunctions.startLoading();
        if(isRefresh){
          currentPage = 1;
        }else{
          if(currentPage >= totalPages){
            refreshController.loadNoData();
            isRecord = false;
          }
        }

        final service = ApiServices();
        await service.fetchMekanoGalleryAPI(
            currentPage
        ).then((value) {
          if(value != null){
            if(value.success == true) {
              if(isRefresh){
                userRecordList = List.from(value.userList!);
              }else{
                userRecordList.addAll(List.from(value.userList!));
              }
              if (userRecordList.isNotEmpty) {
                currentPage++;
                totalPages = getTotalPages(value.totalCount!);
                setState(() {});
                isRecord = true;
              } else {
                setState(() {});
                isRecord = false;
              }
            }else{
              isRecord = false;
            }
          }else {
            _appFunctions.errorMsg(('no_record_found_tr').tr());
            isRecord = false;
          }
        });
        return isRecord;
  }

  int getTotalPages(int totalRecords){
    var pages = (totalRecords*15)/100;
    return pages.ceil();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true, //for add/remove back arrow
          title: Center(child: const Text('gallery_tr', textAlign: TextAlign.center).tr()),
          backgroundColor: AppColors.appColor,
          foregroundColor: AppColors.white,
          actions: const [
            Text('00', style: TextStyle(color: AppColors.appColor, fontSize: 25.0)),
          ],
        ),
        body: SafeArea(
            child: _connectionStatus
                ? Center(
                  child: SmartRefresher(
                    enablePullUp: true,
                    controller: refreshController,
                    onRefresh: () async {
                      result = await callGalleryApi(isRefresh: true);
                      print(result);
                      if (result!) {
                        refreshController.refreshCompleted();
                      } else {
                        refreshController.refreshFailed();
                        noDataMsg = 'no_record_found_tr';
                        print(noDataMsg);
                      }
                    },
                    onLoading: () async {
                      result = await callGalleryApi();
                      print(result);
                      if (result!) {
                        refreshController.loadComplete();
                      } else {
                        refreshController.loadFailed();
                        noDataMsg = 'no_record_found_tr';
                        print(noDataMsg);
                      }
                    },
                    child: userRecordList.isNotEmpty
                    ?ListView.builder(
                        itemCount: userRecordList.length,
                        shrinkWrap: true, // Use  children total size
                        itemBuilder: (context, index) {
                          print('Data Size== '+userRecordList.length.toString());
                          var userData = userRecordList[index];
                          return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.03),
                              child: CampaignsGalleryCard(
                                image: userData.image,
                                name: userData.user!.firstName,
                                onTap: () {},
                              ));
                        })
                    :Center(child: Text(noDataMsg).tr())
                  ))
                : Center(child: const Text('no_internet_tr').tr())
        )
    );
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        setState(() => _connectionStatus = true);
        break;
      case ConnectivityResult.none:
        setState(() => _connectionStatus = false);
        break;
      default:
        setState(() => _connectionStatus = false);
        break;
    }
  }
}


/*
* body: SafeArea(
            child: _connectionStatus
                ? Center(
                    child: ListView.builder(
                      itemCount : AppConstants.galleryList.length,
                      shrinkWrap: true, // Use  children total size
                      itemBuilder : (context, index){
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                          child: CampaignsGalleryCard(
                            image: AppConstants.galleryList[index].image,
                            name: AppConstants.galleryList[index].name,
                            onTap: () {  },
                          )
                        );
                      }
                  )
                )
                : Center(child: const Text('no_internet_tr').tr())
        )
* */

/*
* child: LayoutBuilder(builder: (context, constraints){
                      if(items.isNotEmpty){
                        return Stack(
                          children: [
                            ListView.separated(
                                controller: _scrollController,
                                itemBuilder: (context, index){
                                  if(index < items.length){
                                    return ListTile(
                                      title: Text(items[index]),
                                    );
                                  }else{
                                    return SizedBox(
                                      height: size.height * 0.05,
                                      width: size.width,
                                      child: const Center(
                                        child: Text('Nothing more to load!'),
                                      ),
                                    );
                                  }
                                },
                                separatorBuilder: (context, index){
                                  return Divider(
                                    height: size.height * 0.01,
                                  );
                                },
                                itemCount: items.length + (allLoading?1:0)
                            ),
                            if(loading)...[
                              Positioned(
                                  left: 0,
                                  bottom: 0,
                                  child: SizedBox(
                                    height: size.height * 0.1,
                                    width: size.width,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                              )
                            ]
                          ],
                        );
                      }else{
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },),
* */