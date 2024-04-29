import 'package:note/allPackageInp.dart';

bool isSnackBarVisible = false;

void showSnackMessage(BuildContext context, String msg, {int no = 1}) {
  if (!isSnackBarVisible) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.only(
          left: 20.w,
          bottom: 10.w,
          top: 10.w,
        ),
        duration: const Duration(seconds: 2),
        content: Text(msg,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.w,
                fontWeight: FontWeight.w500)),
        backgroundColor: no == 1 ? Colors.red : Colors.green,
      ),
    );
    isSnackBarVisible = true;
    Future.delayed(const Duration(seconds: 3), () {
      isSnackBarVisible = false;
    });
  }
}
