import 'package:note/allPackageInp.dart';
import 'package:note/uiScreen/addNote/addNotePage.dart';
import 'package:note/uiScreen/addNote/controller.dart';
import 'package:note/uiScreen/homePage/controller.dart';
import 'package:note/unitData/no_data_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // final dataController = Get.put(HomeController());

  final addDataController = Get.put(AddNoteController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (dataController) {
      return RefreshIndicator(
        onRefresh: () {
          return dataController.updateListView();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Note"),
            centerTitle: true,
          ),
          body: Obx(() => dataController.noteList.isEmpty
              ? const NoDataWidget()
              : Padding(
                  padding: EdgeInsets.only(right: 16.w, top: 22.h, left: 16.w),
                  child: ListView.builder(
                    itemCount: dataController.noteList.length,
                    itemBuilder: (context, index) {
                      var data = dataController.noteList[index];
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          onTap: () {
                            addDataController.initData(valueNote: data);
                            Get.to(AddNote(
                              isChange: false,
                            ));
                          },
                          title: Text(data.title),
                          subtitle: Text(data.date),
                          leading: CircleAvatar(
                            backgroundColor:
                                dataController.getPriorityColor(data.item),
                            child: dataController.getPriorityIcon(data.item),
                          ),
                          trailing: GestureDetector(
                              onTap: () {
                                dataController.delete(
                                    context, dataController.noteList[index]);
                              },
                              child: const Icon(Icons.delete)),
                        ),
                      );
                    },
                  ),
                )),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppBodyColor.blue,
            onPressed: () {
              addDataController.add();
              Get.to(AddNote(
                isChange: true,
              ));
            },
            child: const Icon(Icons.add),
          ),
        ),
      );
    });
  }
}
