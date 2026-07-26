import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/agent_controller.dart';
import '../repositories/language_list.dart';

class LanguagePickerPage extends StatefulWidget {
  const LanguagePickerPage({super.key});

  @override
  State<LanguagePickerPage> createState() =>
      _LanguagePickerPageState();
}

class _LanguagePickerPageState
    extends State<LanguagePickerPage> {
  final AgentController controller =
  Get.find<AgentController>();

  final TextEditingController searchController =
  TextEditingController();

  List<String> filtered = [];

  @override
  void initState() {
    super.initState();

    filtered = List.from(languages);
  }

  void search(String value) {
    setState(() {
      filtered = languages
          .where(
            (e) => e
            .toLowerCase()
            .contains(value.toLowerCase()),
      )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Languages"),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: search,
              decoration: const InputDecoration(
                hintText: "Search language",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) =>
              const Divider(height: 1),
              itemBuilder: (_, index) {
                final language = filtered[index];

                final selected =
                controller.selectedLanguages
                    .contains(language);

                return ListTile(
                  title: Text(language),

                  trailing: selected
                      ? const Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                      : null,

                  enabled: !selected,

                  onTap: selected
                      ? null
                      : () {
                    controller.addLanguage(
                      language,
                    );

                    Get.back();
                  },
                );
              },
            )
          ),

        ],
      ),
    );
  }
}