import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class CustomShimmerLoading extends StatelessWidget {
  const CustomShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, i) {
        final delay = (i * 200);
        return Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            children: [
              FadeShimmer.round(
                size: 60,
                millisecondsDelay: delay,
                baseColor:
                    context.theme.colorScheme.onSecondary.withOpacity(.3),
                highlightColor:
                    context.theme.colorScheme.onSecondary.withOpacity(.1),
              ),
              SizedBox(width: 10),
              Flexible(
                child: Container(
                  child: SizedBox(
                    width: context.mediaQuery.size.width * 0.75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FadeShimmer(
                          height: 20,
                          width: context.mediaQuery.size.width * 0.4,
                          radius: 5,
                          millisecondsDelay: delay,
                          baseColor: context.theme.colorScheme.onSecondary
                              .withOpacity(.3),
                          highlightColor: context.theme.colorScheme.onSecondary
                              .withOpacity(.1),
                        ),
                        FadeShimmer(
                          height: 30,
                          width: 30,
                          radius: 100,
                          millisecondsDelay: delay,
                          baseColor: context.theme.colorScheme.onSecondary
                              .withOpacity(.3),
                          highlightColor: context.theme.colorScheme.onSecondary
                              .withOpacity(.1),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
      itemCount: 15,
      separatorBuilder: (_, __) => SizedBox(
        height: 16,
      ),
    );
  }
}
