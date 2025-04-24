import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';
import 'package:green_plate/core/widgets/common_app_bar.dart';
import 'package:green_plate/features/ai_recipe/presentation/widget/empty_list_text.dart';
import 'package:green_plate/features/ai_recipe/presentation/widget/input_section.dart';

class AiRecipePage extends StatefulWidget {
  const AiRecipePage({super.key});

  @override
  State<AiRecipePage> createState() => _AiRecipePageState();
}

class _AiRecipePageState extends State<AiRecipePage> {
  final _listController = TextEditingController();
  final List<Map<String, dynamic>> _ingredients = [];
  final FocusNode _focusNode = FocusNode();


  @override
  void dispose() {
    _listController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Color _getRandomColor() {
    final random = DateTime.now().millisecond % MyColors.aiListRandomColors.length;
    return MyColors.aiListRandomColors[random];
  }

  void _addIngredient() {
    final text = _listController.text.trim();
    if (text.isNotEmpty && !_ingredients.any((item) => item['name'] == text)) {
      setState(() {
        _ingredients.add({
          'name': text,
          'color': _getRandomColor(),
        });
        _listController.clear();
      });
      _focusNode.requestFocus();
    }
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ingredient removed'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Create Recipe"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            if (_ingredients.isNotEmpty)
              Expanded(
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: _ingredients.map((ingredient) {
                      return Chip(
                        backgroundColor: ingredient['color'],
                        label: Text(ingredient['name']),
                        deleteIcon: Icon(Icons.close, size: 16.sp),
                        onDeleted: () {
                          _removeIngredient(_ingredients.indexOf(ingredient));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 14.sp,
                          color: MyColors.blackColor
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            else
              EmptyListText(),
            InputSection(
              controller: _listController,
              focusNode: _focusNode,
              onPressed: _addIngredient,
            ),
          ],
        ),
      ),
    );
  }
}
