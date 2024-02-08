import 'package:flutter/material.dart';

class JHTableActions extends StatelessWidget {
  const JHTableActions({
    super.key,
    this.onDelete,
    this.onEdit,
    this.canShow = false,
    this.onShow,
    this.canEdit = true,
  });
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onShow;
  final bool canShow;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (canShow)
          IconButton(
            onPressed: onShow,
            icon: const Icon(
              Icons.remove_red_eye,
              color: Colors.green,
            ),
          ),
        if (canEdit)
          IconButton(
            onPressed: onEdit,
            icon: Icon(
              Icons.edit,
              color: Colors.blue.shade800,
            ),
          ),
        IconButton(
          onPressed: onDelete,
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
