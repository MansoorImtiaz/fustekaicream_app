import 'package:fusteka_icecreem/core/hooks/hooks.dart';

class ContestAndCampaignsScreen extends StatelessWidget {
  final bool? isAppBar;
  const ContestAndCampaignsScreen({Key? key, required this.isAppBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContestAndCampaignBody(isAppBar: isAppBar);
  }
}
