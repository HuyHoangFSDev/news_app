import 'package:bao_moi/screens/detailed_news/detailed_news.dart';
import 'package:bao_moi/screens/home/home.dart';
import 'package:bao_moi/screens/loading.dart';
import 'package:flutter/material.dart';

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//
//                -ooOoo-                       NAM MÔ A DI ĐÀ PHẬT !
//               o8888888o
//               88" . "88      Thí chủ con tên là Nguyễn Thế Huy Hoàng, dương lịch hai sáu tháng mười một năm 2002
//               (| -_- |)      Ngụ tại Xóm 3 Đồng Nhân, Hà Nội, Việt Nam
//                O\ = /O
//             ___/`---'\___            Con lạy chín phương trời, con lạy mười phương đất
//            .' \\| |// `.             Chư Phật mười phương, mười phương chư Phật
//          / \\||| : |||// \           Con ơn nhờ Trời đất chổ che, Thánh Thần cứu độ
//         / _||||| -:- |||||-\         Xin nhất tâm kính lễ Hoàng thiên Hậu thổ, Tiên Phật Thánh Thần
//           | | \\\ - /// | |          Giúp đỡ con code sạch ít bug
//         | \_| ''\---/'' | |          Đồng nghiệp vui vẻ, sếp quý tăng lương
//         \ .-\__ '-' ___/-. /         Sức khoẻ dồi dào, tiền vào như nước
//       ___. .' /--.--\ . . __
//   ."" '< `.___\_<|>_/___.' >'"".     NAM MÔ VIÊN THÔNG GIÁO CHỦ ĐẠI TỪ ĐẠI BI TẦM THANH CỨU KHỔ CỨU NẠN
//    | | : - \.;`\ _ /`;.`/ - ` : | |  QUẢNG ĐẠI LINH CẢM QUÁN THẾ ÂM BỒ TÁT
//     \ \ -. \_ __\ /__ _/ .- / /
//======`-.____-.___\_____/___.-____.-'======
//                `=---='
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (setting) {
        if (setting.name == '/detailnews') {
          final args = setting.arguments as DetailNews;
          return MaterialPageRoute(
              builder: (context) => const DetailNews(),
              settings: RouteSettings(
                arguments: args,
              ));
        }
        return null;
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const Loading(),
        '/home': (context) => const Home(),
        '/detailnews': (context) => const DetailNews()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: const IconThemeData(color: Colors.blueAccent),
      ),
    );
  }
}

