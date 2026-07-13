import 'package:flutter/material.dart';

import '../../category/models/category_field_model.dart';
import 'dynamic_field_widget.dart';

class DynamicFieldsCard extends StatelessWidget {
  final List<CategoryFieldModel> fields;

  const DynamicFieldsCard({
    super.key,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    if (fields.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Product Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              "Provide additional information",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: fields.length,
              separatorBuilder: (_, __) =>
              const SizedBox(height: 18),
              itemBuilder: (_, index) {
                return DynamicFieldWidget(
                  field: fields[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}