import 'package:intl/intl.dart';
import 'package:note/allPackageInp.dart';
import 'package:note/model/note.dart';
import 'package:note/uiScreen/homePage/controller.dart';
import 'package:note/unitData/dataBase.dart';
import 'package:note/unitData/snackMessage.dart';

class AddNoteController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final addDataController = Get.put(HomeController());

  late NoteData note;
  void add() {
    note = NoteData();
    updatePriorityAsInt(typesValue.value);
  }

  RxBool loading = false.obs;
  var types = ["High", "Low"].obs;
  RxString typesValue = "High".obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  FocusNode titleFocus = FocusNode();
  FocusNode desFocus = FocusNode();

  void dataClean() {
    loading.value = false;
    typesValue.value = "High";
    titleController.clear();
    desController.clear();
  }

  void initData({valueNote}) {
    note = valueNote;
    titleController.text = valueNote.title ?? "";
    desController.text = valueNote.description ?? "";
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.item = 1;
        break;
      case 'Low':
        note.item = 2;
        break;
    }
  }

  String getPriorityAsString(int value) {
    typesValue.value;
    switch (value) {
      case 1:
        typesValue.value = types[0];
        break;
      case 2:
        typesValue.value = types[1];
        break;
    }
    return typesValue.value;
  }

  Future<void> save(context) async {
    loading.value = true;
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int? result;
    if (note.id != null) {
      result = await DatabaseHelper().updateNote(note);
    } else {
      result = await DatabaseHelper().insertNote(note);
    }
    if (result != 0) {
      showSnackMessage(context, "Note Saved Successfully", no: 2);
      addDataController.updateListView();
      Get.back();
      dataClean();
    } else {
      showSnackMessage(context, "Problem Saving Note");
    }
  }
}
