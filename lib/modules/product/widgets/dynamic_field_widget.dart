import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../category/models/category_field_model.dart';
import '../controllers/product_controller.dart';

class DynamicFieldWidget extends GetView<ProductController> {
  final CategoryFieldModel field;

  const DynamicFieldWidget({
    super.key,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    switch (field.type) {
      case "text":
        return _textField();

      case "textarea":
        return _textArea();

      case "number":
        return _numberField();

      case "dropdown":
        return _dropdownField();

      case "checkbox":
        return _checkboxField();

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _textField() {
    return TextFormField(
      initialValue: controller.getAttribute(field.key),
      decoration: _decoration(),
      validator: (value) {
        if (field.isRequired &&
            (value == null || value.trim().isEmpty)) {
          return "${field.label} is required";
        }
        return null;
      },
      onChanged: (value) {
        controller.setAttribute(field.key, value);
      },
    );
  }

  Widget _textArea() {
    return TextFormField(
      initialValue: controller.getAttribute(field.key),
      maxLines: 4,
      decoration: _decoration(),
      validator: (value) {
        if (field.isRequired &&
            (value == null || value.trim().isEmpty)) {
          return "${field.label} is required";
        }
        return null;
      },
      onChanged: (value) {
        controller.setAttribute(field.key, value);
      },
    );
  }

  Widget _numberField() {
    return TextFormField(
      initialValue: controller.getAttribute(field.key)?.toString(),
      keyboardType: TextInputType.number,
      decoration: _decoration(),
      validator: (value) {
        if (field.isRequired &&
            (value == null || value.trim().isEmpty)) {
          return "${field.label} is required";
        }
        return null;
      },
      onChanged: (value) {
        controller.setAttribute(field.key, value);
      },
    );
  }

  Widget _dropdownField() {
    return Obx(() {
      return DropdownButtonFormField<String>(
        value: controller.getAttribute(field.key),
        decoration: _decoration(),
        items: field.options
            .map(
              (item) => DropdownMenuItem(
            value: item,
            child: Text(item),
          ),
        )
            .toList(),
        validator: (value) {
          if (field.isRequired && value == null) {
            return "${field.label} is required";
          }
          return null;
        },
        onChanged: (value) {
          controller.setAttribute(field.key, value);
        },
      );
    });
  }

  Widget _checkboxField() {
    return Obx(() {
      return CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(field.label),
        value: controller.getAttribute(field.key) ?? false,
        onChanged: (value) {
          controller.setAttribute(field.key, value);
        },
      );
    });
  }

  InputDecoration _decoration() {
    return InputDecoration(
      labelText: field.label,
      hintText: field.hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}