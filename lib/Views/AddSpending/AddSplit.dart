import 'package:flutter/material.dart';
import 'package:paysa/Views/AddSpending/DraggableHome.dart';
import 'package:paysa/Views/AddSpending/Widgets/AmountInput.dart';

class AddSplit extends StatefulWidget {
  const AddSplit({super.key});

  @override
  State<AddSplit> createState() => _AddSplitState();
}

class _AddSplitState extends State<AddSplit> {
  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      headerExpandedHeight: 0.28,
      curvedBodyRadius: 0,
      stretchTriggerOffset: 100,
      appBarColor: Theme.of(context).colorScheme.primaryContainer,
      alwaysShowTitle: true,
      centerTitle: false,
      alwaysShowLeadingAndAction: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.info,
            color: Theme.of(context).iconTheme.color,
            size: 28,
          ),
          style: Theme.of(context).iconButtonTheme.style,
        ),
      ],
      title: Text(
        'Split bill',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.w500),
      ),
      headerWidget: AmountInput(),
      body: [
        // create a search bar text field with curveborders and hieght 50
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for people',
              hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.grey,
                  ),
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).iconTheme.color,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
        // recent people list
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Recent',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ),
        ),
        SizedBox(height: 10),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                ...List.generate(
                  10,
                  (index) => Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      child: Text('A'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Add new group',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.grey,
                    )),
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: [
            ...List.generate(
              20,
              (index) => ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: Text('A'),
                ),
                title: Text('Name'),
                subtitle: Text('email'),
                trailing: Icon(
                  Icons.add,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
