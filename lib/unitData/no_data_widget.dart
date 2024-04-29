import 'package:animate_do/animate_do.dart';
import 'package:note/allPackageInp.dart';

class NoDataWidget extends StatelessWidget {
  final String? message;
  const NoDataWidget({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      animate: true,
      duration: const Duration(seconds: 2),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Text(
          message ?? "Not Data Found",
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
      )),
    );
  }
}
