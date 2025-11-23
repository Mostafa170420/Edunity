import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/auth/presentation/page/signup/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RoleSelectionToggle extends StatefulWidget {
  final UserRole initialRole;
  final ValueChanged<UserRole> onRoleChanged;

  const RoleSelectionToggle({
    super.key,
    required this.onRoleChanged,
    this.initialRole = UserRole.student,
  });

  @override
  State<RoleSelectionToggle> createState() => _RoleSelectionToggleState();
}

class _RoleSelectionToggleState extends State<RoleSelectionToggle> {
  late UserRole _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialRole;
  }

  void _selectRole(UserRole role) {
    setState(() {
      _selectedRole = role;
    });
    widget.onRoleChanged(role);
  }

  Widget _buildRoleChip(UserRole role, String label) {
    final isSelected = _selectedRole == role;
    return ChoiceChip(
      // elevation: 1.0,
      selectedShadowColor: AppColors.primaryDarkColor.withAlpha(150),
      selectedColor: AppColors.backgroundColor,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          width: 1.0,
          color: isSelected ? AppColors.primaryDarkColor : Colors.black12,
        ),
      ),

      label: SizedBox(width: double.infinity, child: Text(label)),
      selected: isSelected,
      disabledColor: Colors.grey.shade200,
      backgroundColor: Colors.white,
      color: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.backgroundColor;
        }
        return Colors.white;
      }),
      labelStyle: TextStyles.getSmall(
        color: isSelected ? AppColors.primaryDarkColor : Colors.black87,
        fontWeight: FontWeight.w600,
      ),
      // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      // visualDensity: VisualDensity.compact,

      checkmarkColor: AppColors.primaryDarkColor,
      // showCheckmark: false,

      onSelected: (_) => _selectRole(role),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'I am a',
          style: TextStyles.getSmall(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const Gap(8),
        Row(
          children: [
            Expanded(child: _buildRoleChip(UserRole.student, 'Student')),
            const Gap(16),
            Expanded(child: _buildRoleChip(UserRole.teacher, 'Teacher')),
          ],
        ),
      ],
    );
  }
}
