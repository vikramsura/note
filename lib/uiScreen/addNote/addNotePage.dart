import 'package:note/allPackageInp.dart';
import 'package:note/uiScreen/addNote/controller.dart';
import 'package:note/unitData/containerButtton.dart';
import 'package:note/unitData/textfield.dart';

class AddNote extends StatelessWidget {
  bool isChange = true;
  AddNote({super.key, required this.isChange});
  final dataController = Get.put(AddNoteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isChange ? "Add Note" : "Edit Note"),
        centerTitle: true,
      ),
      body: PopScope(
        onPopInvoked: (didPop) {
          dataController.dataClean();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(right: 22.w, top: 22.h, left: 22.w),
            child: Obx(() => Form(
                  key: dataController.formKey,
                  child: Column(
                    children: [
                      ListTile(
                        title: DropdownButton(
                          items: dataController.types.map((String item) {
                            return DropdownMenuItem<String>(
                                value: item, child: Text(item));
                          }).toList(),
                          value: isChange
                              ? dataController.typesValue.value
                              : dataController.getPriorityAsString(
                                  dataController.note.item),
                          onChanged: (value) {
                            dataController.typesValue.value = value!;
                            dataController.updatePriorityAsInt(
                                dataController.typesValue.value);
                          },
                        ),
                      ),
                      buildTextField(
                        context,
                        labelText: "Title",
                        controllerData: dataController.titleController,
                        focusNode: dataController.titleFocus,
                        onChanged: (p0) {
                          dataController.note.title =
                              dataController.titleController.text.trim();
                        },
                        validator: (p0) {
                          if (p0!.trim().isEmpty) {
                            return "Title is required";
                          }
                          return null;
                        },
                      ),
                      buildTextField(
                        context,
                        labelText: "Description",
                        controllerData: dataController.desController,
                        focusNode: dataController.desFocus,
                        maxLength:
                            dataController.typesValue.value == "Low" ? 50 : 250,
                        maxLines:
                            dataController.typesValue.value == "Low" ? 3 : 10,
                        onChanged: (p0) {
                          dataController.note.description =
                              dataController.desController.text.trim();
                        },
                        validator: (p0) {
                          if (p0!.trim().isEmpty) {
                            return "Description is required";
                          }
                          if (dataController.typesValue.value == "Low") {
                            if (p0.trim().length < 20) {
                              return "Description length should be 20 characters";
                            }
                          } else {
                            if (p0.trim().length < 50) {
                              return "Description length should be 50 characters";
                            }
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
          onTap: () {
            if (dataController.formKey.currentState!.validate()) {}
            if (dataController.titleController.text.trim().isEmpty) {
              dataController.titleFocus.requestFocus();
            } else if (dataController.desController.text.trim().isEmpty ||
                    dataController.typesValue.value == "Low"
                ? dataController.desController.text.trim().length < 20
                : dataController.desController.text.trim().length < 50) {
              dataController.desFocus.requestFocus();
            } else {
              dataController.save(context);
            }
          },
          child: buildConButton(
              text: "Save", loading: dataController.loading.value)),
    );
  }
}
