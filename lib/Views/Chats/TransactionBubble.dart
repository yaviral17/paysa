import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paysa/Views/Transactions/Transactions.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

class TransactionBubble extends StatelessWidget {
  const TransactionBubble({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final isYou =
        transaction.createdBy == FirebaseAuth.instance.currentUser!.uid;

    return Row(
      mainAxisAlignment:
          isYou ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isYou) showTimeStamp(isYou),
        Container(
          width: MediaQuery.of(context).size.width * 0.54,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          decoration: BoxDecoration(
            color: isYou ? TColors.primary : TColors.darkerGrey,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 2,
              style: BorderStyle.solid,
              strokeAlign: 1,
              color: TColors.white,
            ),
            image: const DecorationImage(
              image: AssetImage('assets/images/money_bg.jpg'),
              fit: BoxFit.cover,
              opacity: 0.06,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   transaction.createdByUserName,
              //   style: TextStyle(
              //     fontSize: 12,
              //     color: isYou
              //         ? TColors.white.withOpacity(0.6)
              //         : TColors.grey.withOpacity(0.6),
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // const SizedBox(height: 4),
              // Split Name
              Text(transaction.splitName,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                      )),
              const SizedBox(height: 4),
              // Amount
              Row(
                children: [
                  const Text(
                    "Total : ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '₹ ${transaction.amount}',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: TColors.primaryBackground,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Description
              Text(
                transaction.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              ...List.generate(
                transaction.members.length,
                (index) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: TColors.white.withOpacity(0.3),
                      ),
                      bottom: BorderSide(
                        color: TColors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        transaction.members[index]['name'].split(' ').first,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        ' : ₹ ${transaction.members[index]['amount']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        transaction.members[index]['paid']
                            ? 'Paid ✔'
                            : 'Not Paid ❌',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: transaction.members[index]['paid']
                              ? TColors.lightContainer
                              : Colors.red.shade400,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),

              Visibility(
                visible: transaction.paidBy ==
                    FirebaseAuth.instance.currentUser!.uid,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(TColors.primary),
                            backgroundColor: MaterialStateProperty.all(
                              TColors.white,
                            ),
                            minimumSize:
                                MaterialStateProperty.all(const Size(100, 38)),
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => SettleUpScreen(
                            //       transaction: transaction,
                            //     ),
                            //   ),
                            // );
                          },
                          child: Text(
                            "Settle Up",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 12,
                                ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(TColors.primary),
                              backgroundColor: MaterialStateProperty.all(
                                TColors.lightDarkBackground,
                              ),
                              // minimumSize: MaterialStateProperty.all(Size(60, 38)),
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => EditTransactionScreen(
                              //       transaction: transaction,
                              //     ),
                              //   ),
                              // );
                            },
                            child: Text("Edit",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: TColors.white,
                                      fontSize: 12,
                                    )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text("Created By : ${transaction.createdByUserName}"),
              const SizedBox(height: 4),
            ],
          ),
        ),
        if (!isYou) showTimeStamp(isYou),
      ],
    );
  }

  showTimeStamp(bool isYou) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 8),
        Text(
          THelperFunctions.getDateDifference(transaction.timestamp),
          style: TextStyle(
            fontSize: 10,
            color: isYou ? TColors.primary : TColors.grey.withOpacity(0.6),
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
