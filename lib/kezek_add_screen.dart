import 'package:ala_web/constants/app_styles.dart';
import 'package:ala_web/service/network_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class KezekCarAddScreen extends StatefulWidget {
  final int count;

  const KezekCarAddScreen({super.key, required this.count});

  @override
  State<KezekCarAddScreen> createState() => _KezekCarAddScreenState();
}

class _KezekCarAddScreenState extends State<KezekCarAddScreen> {
  final TextEditingController equipmentController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  final apiService = ApiService();

  String? selectedMark;
  final TextEditingController searchMarkController = TextEditingController();
  List<String> marksList = [];
  List<String> marksId = [];
  int totalPrice = 0;

  String? selectedModel;
  final TextEditingController searchModelController = TextEditingController();
  List<String> modelsList = [];

  Future<void> getAutoMarks() async {
    apiService.getMarks().then((marksData) {
      // print('Марки автомобилей:');
      marksList.clear();
      marksId.clear();
      for (int i = 0; i < marksData.length; i++) {
        marksList.add(marksData[i]['name']);
        marksId.add(marksData[i]['id']);
      }
      setState(() {});
    }).catchError((error) {
      print('Ошибка при загрузке марок: $error');
    });
  }

  Future<void> getAutoModels(String selectedMarkId) async {
    // print(selectedMark);
    apiService.getModels(selectedMarkId).then((modelsData) {
      // print(modelsData);
      // print('Модели автомобилей:');
      modelsList.clear();
      for (int i = 0; i < modelsData.length; i++) {
        modelsList.add(modelsData[i]['name']);
      }
      setState(() {});
    }).catchError((error) {
      print('Ошибка при загрузке моделей: $error');
    });
  }

  Future<void> addKezek() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }

      CollectionReference users =
          FirebaseFirestore.instance.collection('kezek');

      final customDocumentName = (widget.count + 1).toString();

      await users.doc(customDocumentName).set({
        'equipment': equipmentController.text,
        'year': yearController.text,
        'tel': telController.text,
        'comment': commentController.text,
      });

      clearTextControllers();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Кезекке қосылды'),
        ),
      );

      // print("Tovar Added");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Кезекке қосылмады: $e'),
        ),
      );
      // print("Failed to add tovar: $e");
    }
  }

  void clearTextControllers() {
    equipmentController.clear();
    yearController.clear();
    telController.clear();
    commentController.clear();
  }

  List<String> uslugiName = [];
  List<int> uslugiPrise = [];
  List<int> uslugiTime = [];
  List<String> selectedUslugi = [];

  Future<void> readUslugi() async {
    uslugiName.clear();
    uslugiPrise.clear();
    uslugiTime.clear();
    selectedUslugi.clear();
    CollectionReference collectionName =
        FirebaseFirestore.instance.collection('uslugi');

    try {
      QuerySnapshot<Object?> querySnapshot = await collectionName.get();
      // print('querySnapshot: ${querySnapshot.docs.length}');

      for (QueryDocumentSnapshot<Object?> document in querySnapshot.docs) {
        if (document.exists) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          // print('uslugiName: ${uslugiName[indx]}');
          uslugiName.add(data['name']);
          uslugiPrise.add(data['price']);
          uslugiTime.add(data['time']);
        }
      }

      setState(() {});
    } catch (e) {
      print('Something went wrong: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getAutoMarks();
    readUslugi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text('Кезекке тұру'),
      //   backgroundColor: AppStyles.primaryColor,
      //   iconTheme: const IconThemeData(color: Colors.black),
      // ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/logo.png',
                width: 200,
              ),
              if (uslugiName.isNotEmpty) uslugiWidget(),
              if (selectedUslugi.isNotEmpty) markWidget(),
              if (selectedMark != null && selectedUslugi.isNotEmpty)
                modelWidget(),
              if (selectedModel != null &&
                  selectedUslugi.isNotEmpty &&
                  selectedMark != null)
                Column(
                  children: [
                    buildTextFormField(
                      equipmentController,
                      'Комплектация',
                      TextInputType.name,
                    ),
                    buildTextFormField(
                      yearController,
                      'Жылы',
                      TextInputType.number,
                    ),
                    buildTextFormField(
                      commentController,
                      'Комментарий',
                      TextInputType.multiline,
                    ),
                    buildTextFormField(
                      telController,
                      'Телефон',
                      TextInputType.phone,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: AppStyles.kaspiButton,
                        onPressed: () async {
                          // addKezek();
                          String url =
                              'https://kaspi.kz/transfers/categories/kaspi-client?destCardNumber=4400430185221758&requisiteinputMethod=scan-card-camera';
                          if (!await launchUrl(Uri.parse(url))) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: Text(
                          "Аванс төлеу: $totalPrice",
                          style: CustomTextStyles.s16w400cw,
                        ),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget uslugiWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: AppStyles.primaryColor)),
      child: Column(
        children: [
          Text(
            'Қызмет түрі',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).hintColor,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: uslugiName.map((item) {
              final isSelected = selectedUslugi.contains(item);

              return InkWell(
                onTap: () {
                  isSelected
                      ? selectedUslugi.remove(item)
                      : selectedUslugi.add(item);
                  setState(() {});
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: Row(
                    children: [
                      isSelected
                          ? const Icon(Icons.check_box_outlined)
                          : const Icon(Icons.check_box_outline_blank),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget modelWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: AppStyles.primaryColor)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Модель',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: modelsList
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedModel,
          onChanged: (value) {
            setState(() {
              selectedModel = value;
            });
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            // width: 200,
          ),
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 500,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
          dropdownSearchData: DropdownSearchData(
            searchController: searchModelController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: searchModelController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Іздеу',
                  hintStyle: const TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return item.value.toString().contains(searchValue);
            },
          ),
          //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              searchMarkController.clear();
            }
          },
        ),
      ),
    );
  }

  Widget markWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: AppStyles.primaryColor)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'Марка',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: marksList
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedMark,
          onChanged: (value) {
            setState(() {
              selectedMark = value;
              selectedModel = null;
              modelsList.clear;
              getAutoModels(marksId[marksList.indexOf(selectedMark!)]);
            });
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            // width: 200,
          ),
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 500,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
          dropdownSearchData: DropdownSearchData(
            searchController: searchMarkController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: searchMarkController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Іздеу',
                  hintStyle: const TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return item.value.toString().contains(searchValue);
            },
          ),
          //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              searchMarkController.clear();
            }
          },
        ),
      ),
    );
  }

  Widget buildTextFormField(TextEditingController controller, String labelText,
      TextInputType keyboardType) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: labelText,
            fillColor: Colors.white,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 2,
                color: AppStyles.primaryColor,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Толық емес';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
