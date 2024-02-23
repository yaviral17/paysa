import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Controllers/CreateGroupController.dart';
import 'package:paysa/Models/GroupModel.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  CreateGroupController controller = Get.put(CreateGroupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.createGroup(context);
        },
        label: Obx(
          () => controller.isLoading.value
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : const Text('Create Group'),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: TColors.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 72,
              ),
              // Group name
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.groupNameController,
                  decoration: const InputDecoration(
                    labelText: 'Group Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              // Group description
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.groupDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Group Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              // Group category
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.groupCategoryController,
                  decoration: const InputDecoration(
                    labelText: 'Group Category',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              Text(
                "Add Members",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: TColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              // Add members
              SizedBox(
                height: 56,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.addMember,
                        decoration: const InputDecoration(
                          labelText: 'Add Members',
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: TColors.primary,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () => controller.onPressAddButton(context),
                      style: ElevatedButton.styleFrom(
                        primary: TColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        side: const BorderSide(
                          color: TColors.primary,
                        ),
                        minimumSize: const Size(72, 48),
                      ),
                      child: const Text('Add'),
                    ),

                    // Add button
                  ],
                ),
              ),
              SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              Obx(
                () => Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  children: [
                    ...List.generate(
                      controller.members.length,
                      (index) => InkWell(
                        onLongPress: () {
                          controller.members.removeAt(index);
                        },
                        child: Chip(
                          label: Text(
                            controller.members[index].name,
                          ),
                          onDeleted: () {
                            controller.members.removeAt(index);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
