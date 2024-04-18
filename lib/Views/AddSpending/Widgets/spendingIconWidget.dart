import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Controllers/AddSpendingController.dart';
import 'package:paysa/Models/DailySpendingModel.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';

class SpendingsIconWidget extends StatelessWidget {
  const SpendingsIconWidget({
    super.key,
    required this.context,
    required this.addSpendingController,
  });

  final BuildContext context;
  final AddSpendingController addSpendingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: TColors.light.withOpacity(0.2),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Select Icon",
            style: TextStyle(
              color: TColors.textWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Column(
                    children: [
                      CircleAvatar(
                        radius: TSizes.displayWidth(context) * 0.1,
                        backgroundImage: AssetImage(
                            'assets/expanses_category_icons/ic_${addSpendingController.category.value}.png'),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        // duration: const Duration(milliseconds: 300),
                        // curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: TColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        child: Text(
                          addSpendingController.category.value.capitalize!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: TColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: TSizes.displayWidth(context) * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // height: 54,
                  width: TSizes.displayWidth(context) * 0.4,
                  height: TSizes.displayHeight(context) * 0.2,
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: TColors.light.withOpacity(0.1),
                      ),
                    ],
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: TColors.light.withOpacity(0.2),
                      ),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount:
                          DailySpendingModel.DailySpendingCategories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (TSizes.displayWidth(context) ~/ 90),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            addSpendingController.category.value =
                                DailySpendingModel
                                    .DailySpendingCategories[index];
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: TColors.primary.withOpacity(0.3),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundImage: AssetImage(
                                  'assets/expanses_category_icons/ic_${DailySpendingModel.DailySpendingCategories[index]}.png'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
