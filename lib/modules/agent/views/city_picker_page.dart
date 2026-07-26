import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../location/models/city_model.dart';
import '../controllers/agent_controller.dart';
import '../models/agent_location_model.dart';

class CityPickerPage extends StatefulWidget {
  final AgentLocationModel area;

  const CityPickerPage({
    super.key,
    required this.area,
  });

  @override
  State<CityPickerPage> createState() =>
      _CityPickerPageState();
}

class _CityPickerPageState
    extends State<CityPickerPage> {
  final AgentController controller =
  Get.find<AgentController>();

  final TextEditingController searchController =
  TextEditingController();

  List<CityModel> filteredCities = [];

  @override
  void initState() {
    super.initState();

    _load();
  }

  Future<void> _load() async {
    await controller.loadCities(
      widget.area.state.name,
    );

    filteredCities =
        List.from(controller.cities);

    if (mounted) {
      setState(() {});
    }
  }

  void _search(String value) {
    final keyword =
    value.trim().toLowerCase();

    setState(() {
      filteredCities = controller.cities
          .where(
            (e) => e.name
            .toLowerCase()
            .contains(keyword),
      )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(widget.area.state.name),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),

      body: Obx(() {
        if (controller.loadingCities.value) {
          return const Center(
            child:
            CircularProgressIndicator(),
          );
        }

        return Column(
          children: [

            Padding(
              padding:
              const EdgeInsets.all(16),
              child: TextField(
                controller:
                searchController,
                onChanged: _search,
                decoration:
                const InputDecoration(
                  hintText:
                  "Search city",
                  prefixIcon:
                  Icon(Icons.search),
                ),
              ),
            ),

            Expanded(
              child: ListView.separated(
                itemCount:
                filteredCities.length,
                separatorBuilder:
                    (_, __) =>
                const Divider(
                  height: 1,
                ),
                itemBuilder:
                    (_, index) {

                  final city =
                  filteredCities[index];

                  final selected =
                  widget.area.cities.any(
                        (e) =>
                    e.id ==
                        city.id,
                  );

                  return ListTile(
                    title:
                    Text(city.name),

                    trailing: selected
                        ? const Icon(
                      Icons.check,
                      color:
                      Colors.green,
                    )
                        : null,

                    enabled:
                    !selected,

                    onTap: selected
                        ? null
                        : () {
                      Get.back(
                        result: city,
                      );
                    },
                  );
                },
              ),
            ),

          ],
        );
      }),
    );
  }
}