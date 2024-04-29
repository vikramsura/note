import 'package:note/allPackageInp.dart';
import 'package:note/model/note.dart';
import 'package:note/unitData/dataBase.dart';
import 'package:note/unitData/snackMessage.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  RxList<NoteData> noteList = <NoteData>[].obs;
  RxInt count = 0.obs;

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return AppBodyColor.red;

      case 2:
        return AppBodyColor.blue;
      default:
        return AppBodyColor.blue;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return const Icon(Icons.list_alt);
      case 2:
        return const Icon(Icons.list);
      default:
        return const Icon(Icons.list);
    }
  }

  Future<void> delete(context, NoteData note) async {
    int? result =
        await DatabaseHelper().deleteNote(int.parse(note.id.toString()));
    if (result != 0) {
      showSnackMessage(context, "Note Deleted Successfully", no: 2);
      updateListView();
    } else {
      showSnackMessage(context, "Error Occurred while Deleting Note ");
    }
  }

  Future<void> updateListView() async {
    final Future<Database> dbFuture = DatabaseHelper().initializeDatabase();
    dbFuture.then(
      (value) {
        Future<List<NoteData>> noteListFuture = DatabaseHelper().getNoteList();
        noteListFuture.then((value) {
          noteList.value = value;
          count.value = value.length;
        });
      },
    );
  }

  @override
  void onInit() {
    updateListView();
    // TODO: implement onInit
    super.onInit();
  }
}
