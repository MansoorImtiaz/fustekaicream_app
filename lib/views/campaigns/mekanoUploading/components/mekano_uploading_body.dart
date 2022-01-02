import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fusteka_icecreem/core/hooks/hooks.dart';
import 'package:image_picker/image_picker.dart';

class RangeModel{
  RangeModel({this.range});
  final String? range;
}


class MekanoUploadingBody extends StatefulWidget {
  const MekanoUploadingBody({Key? key}) : super(key: key);

  @override
  _MekanoUploadingBodyState createState() => _MekanoUploadingBodyState();
}

class _MekanoUploadingBodyState extends State<MekanoUploadingBody> {

  int selectedCat = 0;
  int selectedSticksNo = 15;
  int topSelectedCat = 0;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  final AppFunctions _appFunctions = AppFunctions();

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: StreamBuilder<Object>(
              stream: null,
              builder: (context, snapshot) {
                return Wrap(
                  children: <Widget>[
                    ListTile(
                        leading: const Icon(Icons.photo_library),
                        title: const Text('photo_library_tr').tr(),
                        onTap: () {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                    ListTile(
                      leading: const Icon(Icons.photo_camera),
                      title: const Text('camera_tr').tr(),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
            ),
          );
        }
    );
  }

  _imgFromCamera() async {
    final XFile?  image = await _picker.pickImage(
      source: ImageSource.camera ,imageQuality: 70,
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    final  XFile? image = await  _picker.pickImage(
      source: ImageSource.gallery ,imageQuality: 70,
    );

    setState(() {
       _image = image;

       // UploadFileInfo(_image, basename(_image.path))
    });
  }

  callUploadingApi() async{
    _appFunctions.startLoading();
    final service = ApiServices();
    await service.apiUploadCampaignImage(
        context,
        selectedSticksNo,
        File(_image!.path)
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true, //for add/remove back arrow
        title: Center(child: const Text('mekano_campaign_tr', textAlign: TextAlign.center).tr()),
        backgroundColor: AppColors.appColor,
        foregroundColor: AppColors.white,
        actions: const [
          Text('00', style: TextStyle(color: AppColors.appColor, fontSize: 25.0)),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppAssets.mekanoUploadTopLeft,
                fit: BoxFit.none,
                alignment: Alignment.topLeft,
                height: size.height * 0.035,
                width: size.width * 0.01,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02,horizontal: size.width * 0.02,),
              child: Column(
                children: [
                  Text('select_icecream_tr', style: TextStyle(fontSize: size.height * 0.025), textAlign: TextAlign.start,).tr(),
                  SizedBox(height: size.height * 0.04,),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: size.height * 0.10,
                          width: size.width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.025),
                            child: ListView.builder(
                              itemCount: AppConstants.rangeList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder:
                                  (BuildContext context, int index) =>
                                  GestureDetector(
                                    child: Container(
                                      width: size.width * 0.25,
                                      margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.005,
                                          horizontal: size.width * 0.04),
                                      decoration: selectedCat == index
                                          ? const BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                      )
                                          : BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        const BorderRadius.all(
                                            Radius.circular(30.0)),
                                        border: Border.all(
                                            width: size.width * 0.004,
                                            color: Colors.black54),
                                      ),
                                      child: Center(
                                          child: Text(
                                            AppConstants.rangeList[index].range!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: selectedCat == index
                                                    ? Colors.white
                                                    : Colors.black54),
                                          ).tr()),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        switch(index){
                                          case 0:
                                            selectedSticksNo = 15;
                                            break;
                                          case 1:
                                            selectedSticksNo = 24;
                                            break;
                                          case 2:
                                            selectedSticksNo = 25;
                                            break;
                                        }
                                        selectedCat = index;
                                      });
                                    },
                                  ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // SizedBox(height: size.height * 0.01,),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.02),
                        child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppAssets.mekanoUploadBG),
                                fit: BoxFit.contain,
                              ),
                            ),
                            width: size.width * 0.75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: size.height * 0.01,),
                                SizedBox(
                                  child: _image != null
                                      ?Image.file(File(_image!.path))
                                      :Image.asset(AppAssets.mekanoImageIcon),
                                  height: size.height * 0.15,
                                  width: size.width * 0.15,
                                ),
                                SizedBox(height: size.height * 0.01,),
                                Text('press_btn_to_upload_tr', style: TextStyle(fontSize: size.height * 0.02)).tr(),
                                SizedBox(height: size.height * 0.02,),
                                SizedBox(
                                  width: size.width * 0.4,
                                  child: CustomElevationBtn(
                                    title: tr('upload_image_tr'),
                                    bgColor: AppColors.appColor,
                                    textColor: Colors.white,
                                    textSize: size.height * 0.02,
                                    onTap: (){
                                      _showPicker(context);
                                    },
                                  ),
                                ),
                                SizedBox(height: size.height * 0.02,),
                                Text('max_img_size_tr', style: TextStyle(fontSize: size.height * 0.014)).tr(),
                              ],
                            )
                        ),
                      )
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    child: CustomElevationBtn(
                      title: tr('submit_tr'),
                      bgColor: AppColors.appColor,
                      textColor: Colors.white,
                      textSize: size.height * 0.02,
                      onTap: (){
                        print(_image);
                        if(_image == null){
                          _appFunctions.showToast('toast_load_image_tr');
                        }else{
                          callUploadingApi();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
