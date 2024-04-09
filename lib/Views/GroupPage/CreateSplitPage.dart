import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Controllers/CreateSplitController.dart';
import 'package:paysa/Models/GroupModel.dart';
import 'package:paysa/utils/appbar/appbar.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:pull_down_button/pull_down_button.dart';

// ignore: must_be_immutable
class CreateSplitScreen extends StatefulWidget {
  final Group group;
  CreateSplitScreen({super.key, required this.group});

  @override
  State<CreateSplitScreen> createState() => _CreateSplitScreenState();
}

class _CreateSplitScreenState extends State<CreateSplitScreen> {
  CreateSplitController controller = Get.put(CreateSplitController());

  @override
  void initState() {
    // TODO: implement initState
    controller.fetchMemberModelList(widget.group);
    super.initState();
  }

  splitEqually() {
    double total = double.parse(controller.amountController.text.length > 0
        ? controller.amountController.text
        : '0');
    controller.splitAmount.value.clear();
    for (var memeber in controller.splitWith) {
      controller.splitAmount.value[memeber] =
          double.parse(controller.amountController.text) /
              controller.splitWith.length;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Create Split'),
        showBackArrow: true,
      ),
      body: Obx(
        () => SafeArea(
          child: controller.memberFetch.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text('Split Name'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                controller: controller.splitNameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter Split Name',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text('Amount'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                controller: controller.amountController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  if (double.parse(value) < 0) {
                                    controller.amountController.text = '0';
                                  }
                                  if (double.parse(value) > 1000000) {
                                    controller.amountController.text =
                                        '1000000';
                                  }

                                  // split equally
                                  splitEqually();
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter Amount',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text('Description'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                controller: controller.descriptionController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter Description',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Text('Paid by:'),
                            SizedBox(
                              width: 10,
                            ),
                            PullDownButton(itemBuilder: (context) {
                              return List.generate(
                                controller.members.length,
                                (index) => PullDownMenuItem(
                                    onTap: () {
                                      controller.paidBy.value =
                                          controller.members[index];
                                    },
                                    title: controller.members[index].name),
                              );
                            }, buttonBuilder: (context, open) {
                              return ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      TColors.primary),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  open();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: controller.paidBy.value == null
                                      ? Text(
                                          'Select',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: Colors.white),
                                        )
                                      : Text(
                                          controller.paidBy.value!.uid ==
                                                  FirebaseAuth
                                                      .instance.currentUser!.uid
                                              ? 'You'
                                              : controller.paidBy.value!.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: Colors.white),
                                        ),
                                ),
                              );
                            }),
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            Text('Split between:'),
                            Spacer(),
                            // Split Equally
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(
                                  TColors.white,
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(TColors.primary),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                splitEqually();
                              },
                              child: Text(
                                'Equally',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(
                                  TColors.white,
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(TColors.primary),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (controller.splitWith.length ==
                                    controller.members.length) {
                                  controller.splitWith.clear();
                                  // controller.splitWith
                                  //     .add(controller.members[0]);
                                } else {
                                  controller.splitWith.clear();
                                  controller.splitWith
                                      .addAll(controller.members);
                                }
                                splitEqually();
                              },
                              child: Text(
                                'All',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ...List.generate(
                          controller.members.length,
                          (index) => ListTile(
                            onTap: () {
                              double total = double.parse(
                                  controller.amountController.text);
                              double amount = controller.splitAmount
                                      .value[controller.members[index]] ??
                                  0.0;

                              if (!controller.splitWith
                                  .contains(controller.members[index])) {
                                controller.splitWith
                                    .add(controller.members[index]);

                                splitEqually();
                                return;
                              }
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Enter Amount'),
                                  content: TextField(
                                    controller: TextEditingController(
                                        text: amount.toString()),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (double.parse(value) > total) {
                                        value = total.toString();
                                      }

                                      controller.splitAmount.value[
                                              controller.members[index]] =
                                          double.parse(value);
                                      // now we have to update the amount for rest of the members

                                      double remainingAmount =
                                          total - double.parse(value);
                                      double splitAmount = remainingAmount /
                                          (controller.splitWith.length - 1);
                                      for (var member in controller.splitWith) {
                                        if (member !=
                                            controller.members[index]) {
                                          controller.splitAmount.value[member] =
                                              splitAmount;
                                        }
                                      }
                                      setState(() {});
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // double total = double.parse(
                                        //     controller.amountController.text);
                                        //     controller.splitAmount.value[controller.members[index]] = amount;
                                        if (controller.splitAmount.value[
                                                controller.members[index]] ==
                                            0.0) {
                                          controller.splitAmount.value.remove(
                                              controller.members[index]);
                                          controller.splitWith.remove(
                                              controller.members[index]);
                                        }

                                        Navigator.pop(context);
                                      },
                                      child: Text('Ok'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            title: Text(controller.members[index].name),
                            subtitle: Obx(
                              () => Text(controller.splitAmount.value
                                      .containsKey(controller.members[index])
                                  ? controller.splitAmount
                                          .value[controller.members[index]]
                                          .toString() ??
                                      "0.0"
                                  : "0.0"),
                            ),
                            trailing: Checkbox(
                              value: controller.splitWith
                                  .contains(controller.members[index]),
                              onChanged: (value) {
                                if (value!) {
                                  controller.splitWith
                                      .add(controller.members[index]);
                                } else {
                                  controller.splitWith
                                      .remove(controller.members[index]);
                                }
                                splitEqually();
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () => Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == 0,
          child: ElevatedButton(
            onPressed: () {
              controller.createSplit(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(TColors.primary),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(TSizes.displayWidth(context) * 0.8, 48),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: controller.isLoading.value
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Create Split',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
