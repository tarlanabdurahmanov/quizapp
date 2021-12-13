import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../constants/size.dart';
import '../constants/strings.dart';
import '../controllers/leaderboard_controller.dart';
import 'package:lottie/lottie.dart';

class LeaderBoardScreen extends StatelessWidget {
  final _leaderBoardController = Get.put(LeaderboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        centerTitle: false,
        title: Text(
          "Liderlər lövhəsi",
          style: defaultTextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          _backgroundGradient(),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double textFontSize = 14;
              double xpFontSize = 12;
              double borderRadius = 27;
              // double leftPadding = 70;
              if (constraints.maxWidth > 375) {
                textFontSize = 16;
                xpFontSize = 13;
                borderRadius = 27;
                // leftPadding = 80;
              }
              return Obx(
                () => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _leaderBoardController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(color: Colors.white))
                      : (_leaderBoardController.ratings.length > 0
                          ? ListView.builder(
                              itemCount: _leaderBoardController.ratings.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Obx(
                                        () => AvatarView(
                                          radius: borderRadius,
                                          borderWidth: 1,
                                          borderColor: context
                                              .theme.colorScheme.background
                                              .withOpacity(0.1),
                                          avatarType: AvatarType.CIRCLE,
                                          backgroundColor: Colors.red,
                                          imagePath: _leaderBoardController
                                                      .ratings[index]
                                                      .profileImage !=
                                                  null
                                              ? "${_leaderBoardController.ratings[index].profileImage}"
                                              : userDefaultPath,
                                          placeHolder:
                                              Image.asset(userDefaultPath),
                                          errorWidget: Container(
                                            child: Icon(
                                              Icons.error,
                                              size: 20,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      sizedBoxWidth(),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _leaderBoardController
                                                  .ratings[index].username!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: textFontSize,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "${_leaderBoardController.ratings[index].score!.toInt() * 10} XP",
                                              style: defaultTextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: xpFontSize,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      _leaderIcon(index: index + 1)
                                    ],
                                  ),
                                );
                              },
                            )
                          : Center(child: Lottie.asset(noDataLottiePath))),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Container _backgroundGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primaryColor,
            primarySecondColor,
          ],
        ),
      ),
    );
  }

  SizedBox _leaderIcon({required int index}) {
    return SizedBox(
      width: 50,
      height: 60,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            left: 5,
            bottom: 5,
            child: Transform.rotate(
              angle: 0.5,
              child: Icon(
                index <= 3 ? Icons.bookmark : Icons.bookmark_outline,
                color: index == 1
                    ? Colors.blue
                    : (index == 2
                        ? Colors.red
                        : (index == 3 ? Colors.green : Colors.blue)),
              ),
            ),
          ),
          Positioned(
            right: 5,
            bottom: 5,
            child: Transform.rotate(
              angle: -0.5,
              child: Icon(
                index <= 3 ? Icons.bookmark : Icons.bookmark_outline,
                color: index == 1
                    ? Colors.blue
                    : (index == 2
                        ? Colors.red
                        : (index == 3 ? Colors.green : Colors.blue)),
              ),
            ),
          ),
          Container(
            height: 38,
            decoration: BoxDecoration(
              color: index == 1
                  ? Colors.blue
                  : (index == 2
                      ? Colors.red
                      : (index == 3 ? Colors.green : Colors.white)),
              border: Border.all(
                  color: index == 1
                      ? Colors.blue
                      : (index == 2
                          ? Colors.red
                          : (index == 3 ? Colors.green : Colors.blue)),
                  width: 2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "$index",
                style: propmtTextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: index <= 3 ? Colors.white : Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
