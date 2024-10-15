import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/presentation/state_management/expense_provider.dart';
import 'package:personal_expense_tracker/presentation/widgets/category_element.dart';
import 'package:provider/provider.dart';

class CategorySelectWidgetContainer extends StatefulWidget {
  CategoryElement item;
  int index;
  CategorySelectWidgetContainer({
    super.key,
    required this.index,
    required this.item,
  });

  @override
  State<CategorySelectWidgetContainer> createState() =>
      _CategorySelectWidgetContainerState();
}

class _CategorySelectWidgetContainerState
    extends State<CategorySelectWidgetContainer> {
  @override
  Widget build(BuildContext context) {
    final selectedCategory =
        Provider.of<ExpenseProvider>(context, listen: true).selectedCategory;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Provider.of<ExpenseProvider>(context, listen: false)
              .selectCategory(widget.index);
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: selectedCategory == widget.index ? widget.item.color : null,
            border: Border.all(
                color: selectedCategory == widget.index
                    ? widget.item.color
                    : Colors.grey,
                width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.item.icon,
                    color:
                        selectedCategory == widget.index ? Colors.white : null),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.item.title,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: selectedCategory == widget.index
                          ? Colors.white
                          : null),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
