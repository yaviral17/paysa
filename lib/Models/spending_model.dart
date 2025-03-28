import 'package:paysa/Models/shopping_model.dart';
import 'package:paysa/Models/split_spending_model.dart';
import 'package:paysa/Models/transfer_spending_model.dart';
import 'package:paysa/Utils/constants/custom_enums.dart';

class SpendingModel {
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;
  final String billImage;
  final SpendingType spendingType;
  final ShoppingModel? shoppingModel;
  final SplitSpendingModel? splitSpendingModel;
  final TransferSpendingModel? transferSpendingModel;
  final List<String> users;

  SpendingModel({
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.billImage,
    required this.spendingType,
    this.shoppingModel,
    this.splitSpendingModel,
    this.transferSpendingModel,
    required this.users,
  });

  factory SpendingModel.fromJson(Map<String, dynamic> map) {
    return SpendingModel(
      id: map['id'],
      createdBy: map['createdBy'],
      updatedBy: map['updatedBy'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      billImage: map['billImage'] ?? '',
      spendingType: SpendingTypeExtension.fromString(map['spendingType']),
      shoppingModel: map['shoppingModel'] != null
          ? ShoppingModel.fromJson(map['shoppingModel'])
          : null,
      splitSpendingModel: map['splitSpendingModel'] != null
          ? SplitSpendingModel.fromJson(map['splitSpendingModel'])
          : null,
      transferSpendingModel: map['transferSpendingModel'] != null
          ? TransferSpendingModel.fromJson(map['transferSpendingModel'])
          : null,
      users: List<String>.from(map['users'].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'billImage': billImage,
      'spendingType': spendingType.value,
      'shoppingModel': shoppingModel?.toJson(),
      'splitSpendingModel': splitSpendingModel?.toJson(),
      'transferSpendingModel': transferSpendingModel?.toJson(),
      'users': users,
      'summary-for-llm': spendingType == SpendingType.shopping
          ? '''
This user has spent ${shoppingModel!.amount} on shopping on $createdAt 
it's discritpion is ${shoppingModel!.message} 
'''
          : spendingType == SpendingType.split
              ? '''
This user has created a split of ${splitSpendingModel!.totalAmount} with ${splitSpendingModel!.userSplit
.map((user) => user.uid).join(', ').replaceFirstMapped(RegExp(r', (?=[^,]*$)'), (match) => ' and ')} on $createdAt 
it's discritpion is ${splitSpendingModel!.message} 
'''
              : ''' This user has transfer ${transferSpendingModel!.amount} to ${transferSpendingModel!.transferdToUser!.uid} on $createdAt 
it's discritpion is ${transferSpendingModel!.message} '''
    };
  }
}
