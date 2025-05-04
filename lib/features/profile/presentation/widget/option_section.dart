import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_plate/core/constants/colors/my_colors.dart';

class OptionSection extends StatelessWidget {
  const OptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOption(
              context: context,
              leadingIconData: Icons.history,
              sectionText: "Accepted Donation History",
              route: Placeholder(),
            ),
            Divider(),
            _buildOption(
              context: context,
              leadingIconData: Icons.history_edu,
              sectionText: "Your Donation History",
              route: Placeholder(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required IconData leadingIconData,
    required String sectionText,
    required Widget route,
  }) {
    return ListTile(
      leading: Icon(
        leadingIconData,
        color: MyColors.urlColor,
      ),
      title: Text(
        sectionText,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 18.sp),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => route,
          ),
        );
      },
    );
  }
}
