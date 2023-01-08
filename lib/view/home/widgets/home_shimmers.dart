import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thence_task/helpers/app_colors.dart';

import '../../../helpers/app_spacing.dart';

class HomeShimmers extends StatelessWidget {
  const HomeShimmers({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.04,
          child: Shimmer.fromColors(
            baseColor: AppColors.shimmer,
            highlightColor: AppColors.shimmerHighlight,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    height: size.height * 0.03,
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10)),
                  );
                },
                separatorBuilder: (context, index) {
                  return AppSpacing.sboxW20;
                },
                itemCount: 4),
          ),
        ),
        SizedBox(height: size.height * 0.03),
        Shimmer.fromColors(
            baseColor: AppColors.shimmer,
            highlightColor: AppColors.shimmerHighlight,
            child: Container(
              height: size.height * 0.02,
              width: size.width * 0.2,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10)),
            )),
        SizedBox(height: size.height * 0.03),
        Expanded(
          child: Shimmer.fromColors(
              baseColor: AppColors.shimmer,
              highlightColor: AppColors.shimmerHighlight,
              child: ListView.separated(
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: size.height * 0.1,
                        width: size.width * 0.32,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      AppSpacing.sboxW10,
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          height: size.height * 0.08,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: size.height * 0.02,
                                width: size.width * 0.2,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              Container(
                                height: size.height * 0.02,
                                width: size.width * 0.2,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              Container(
                                height: size.height * 0.02,
                                width: size.width * 0.2,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: size.height * 0.05);
                },
              )),
        ),
      ],
    );
  }
}
