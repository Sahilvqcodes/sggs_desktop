import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurugranth_app/app/models/guru_granth_data.dart';
import 'package:gurugranth_app/app/screens/Drawer.dart';
import 'package:gurugranth_app/app/screens/multi_view_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:translator/translator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../models/books_model.dart';
import '../../widgets/multiselect_lang.dart';

// List<String> list = <String>['car', 'Train', 'Bus', 'Flight'];

class Books extends StatefulWidget {
  const Books({super.key});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // GoogleTranslator translator = GoogleTranslator();
  // LanguageModel? _choosenValue;
  // List<LanguageModel> _languages = List.empty(growable: true);

  // String dropdownValue = list.first;
  String dropdownValue = 'Translations';
  late bool isDrawer;
  bool? isMultiviewDrawer;
  bool value = false;
  bool buttonenabled = false;
  int i = 1;
  String? userId;
  List<Book> _frenchBookList = [
    Book(
      bookName: "Combined French Gutka",
      bookLink:
          "https://www.dropbox.com/s/6sagufcwlpwr4fl/Combined gutka french  v1.pdf?dl=0",
    ),
  ];
  List<Book> _arabicBookList = [
    Book(
      bookName: "Combined Arabic Gutka",
      bookLink:
          "https://www.dropbox.com/s/2umcind1fm9f3t2/combined gutka_arabic_v1.pdf?dl=0",
    ),
  ];
  List<Book> _hindiBookList = [
    Book(
      bookName: "Combined Hindi Gutka",
      bookLink:
          "https://www.dropbox.com/s/igano20s88o656r/combined gutka hindi v1.pdf?dl=0",
    ),
  ];
  List<Book> _persianBookList = [
    Book(
      bookName: "Combined Persian Gutka",
      bookLink:
          "https://www.dropbox.com/s/eqrip6ta8w6zway/combined gutka _persian_v1.pdf?dl=0",
    ),
  ];
  List<Book> _swahiliBookList = [
    Book(
      bookName: "Combined Swahili Gutka",
      bookLink:
          "https://www.dropbox.com/s/1iojzdp1ejdeipq/combined gutka_swahili _v1.pdf?dl=0",
    ),
  ];
  List<Book> _gujaratiBookList = [
    Book(
      bookName: "Combined Gujarati Gutka",
      bookLink:
          "https://www.dropbox.com/s/mk2b3lic0y5f1hx/combined gutka_gujarati_v1.pdf?dl=0",
    ),
  ];
  List<Book> _malaysianBookList = [
    Book(
      bookName: "Combined Malaysian Gutka",
      bookLink:
          "https://www.dropbox.com/s/qnv9wvwmfdsk0gi/combined gutka_malaysian_v1.pdf?dl=0",
    ),
  ];
  List<Book> _marathiBookList = [
    Book(
      bookName: "Combined Marathi Gutka",
      bookLink:
          "https://www.dropbox.com/s/zuangd8yvtu4ugi/combined gutka_marathi_v1.pdf?dl=0",
    ),
  ];
  List<Book> _bengaliBookList = [
    Book(
      bookName: "Combined Bengali Gutka",
      bookLink:
          "https://www.dropbox.com/s/miksl9t79ddmjgu/comined gutka_bengali_v1.pdf?dl=0",
    ),
  ];
  List<Book> _chineseBookList = [
    Book(
      bookName: "Combined Chinese Gutka",
      bookLink:
          "https://www.dropbox.com/s/w0rwrh68hrxxevm/combined gutka_chinese_v1.pdf?dl=0",
    ),
  ];
  List<Book> _odiaBookList = [
    Book(
      bookName: "Combined Odia Gutka",
      bookLink:
          "https://www.dropbox.com/s/2agemhpxzim5qfs/combined gutka_odiya_v1.pdf?dl=0",
    ),
  ];
  List<Book> _germanBookList = [
    Book(
      bookName: "Combined German Gutka",
      bookLink:
          "https://www.dropbox.com/s/c8rqlh5u19s77wu/combined gutka_german_v1.pdf?dl=0",
    ),
  ];
  List<Book> _punjabiBookList = [
    Book(
      bookName: "Combined Punjabi Gutka",
      bookLink:
          "https://www.dropbox.com/s/wa7gw888md6g3p6/combined gutka_punjabi_v1.pdf?dl=0",
    ),
  ];

  List<Book> _teluguBookList = [
    Book(
      bookName: "Combined Telugu Gutka",
      bookLink:
          "https://www.dropbox.com/s/vnww5msxy8qk43z/combined gutka_telugu_v1.pdf?dl=0",
    ),
    Book(
      bookName:
          "Bed Time stories 1 -Guru Gobind Singh ji by Santok Singh Jagdev",
      bookLink:
          "https://www.dropbox.com/s/f4zcl0fkxkgu5zi/(1) Bedtime_Stories_Part_1_Guru_Gobind_Singh_Ji_By_Santokh_Singh_Jagdev-1 (Telugu Translated).pdf?dl=0",
    ),
    Book(
      bookName: "Bed Time Stories 2- Guru Nanak dev ji",
      bookLink:
          "https://www.dropbox.com/s/u47x5fg714w8er6/(2) Bed-Time-Stories-2-Guru-Nanak-Dev-Ji-English (Telugu Translated).pdf?dl=0",
    ),
    Book(
      bookName: "Bed Time stories 3-Guru Arjan Dev ji",
      bookLink:
          "https://www.dropbox.com/s/ocs1rfuvxe25x5n/(3)Bed-Time-Stories-3-Guru-Arjan-Dev-English (Telugu Translated).pdf?dl=0",
    ),
    Book(
      bookName: "Bed Time Stories 4-Guru Teg Bahadur ji",
      bookLink:
          "https://www.dropbox.com/s/apu10jy82nm3ov5/(4) Bed-Time-Stories-4-Guru-Tegh-Bahadur-Ji-English (Telugu Translated).pdf?dl=0",
    ),
    Book(
      bookName:
          "Bed Time Stories 5- Guru Angad Dev ji, Guru Amardass Ji,Guru Ram Das ji",
      bookLink:
          "https://www.dropbox.com/s/bweoja7ubrt89y2/(5) Bed-Time-Stories-5-Guru-Angad-Dev-Guru-AmarDass-Guru-Ram-Dass-Ji.pdf?dl=0",
    ),
    Book(
      bookName: "Bed Time Stories 6- Guru Har gobind,Har rai,Har krishan ji",
      bookLink:
          "https://www.dropbox.com/s/54dp8kkvjivhp46/(6) Bed-Time-Stories-6-GuruHarGobind-HarRai-HarKrishan-English (Telugu Translated).pdf?dl=0",
    ),
    Book(
      bookName: "Bed Time Stories 7-Sikh martyrs by Santok singh jagdev",
      bookLink:
          "https://www.dropbox.com/s/0pb49l3wzflufa1/(7) Bedtime_Stories_7_Sikh_Martyrs_By_Santokh_Singh_Jagdev (Telugu Translated).pdf?dl=0",
    ),
    Book(
      bookName: "Bed Time Stories 8 - Khalsa raj by Santok singh jagdev",
      bookLink:
          "https://www.dropbox.com/s/ow2hnwr818w2q7g/(8) Bedtime_Stories_8_by_khalsa_raj (Telugu Translated).pdf?dl=0",
    ),
    Book(
      bookName: "Bed Time stories 9- Sikh Warriors",
      bookLink:
          "https://www.dropbox.com/s/85tk84vql8cvgiw/(9) Bedtime_Stories_9_by_Sikh_warriors (Telugu Translated).pdf?dl=0",
    ),
    Book(
      bookName: "Bed Time Stories 10 -Honoured Saints",
      bookLink:
          "https://www.dropbox.com/s/12srzm9pa4pcl6p/(10) Bed-Time-stories-10-by-Honoured-Saints (Telugu).pdf?dl=0",
    ),
    Book(
      bookName: "Life Stories of Sikh Guru’s by dr. Arjit singh Aulakh",
      bookLink:
          "https://www.dropbox.com/s/solhup5lm4j84j5/(12) Life-Stories-of-Sikh-Gurus-English-By-Dr-Ajit-Singh-Aulakh.pdf?dl=0",
    ),
    Book(
      bookName: "Supreme Sacrifice of young",
      bookLink:
          "https://www.dropbox.com/s/dlhe6yg5y3u4r4z/(13) Supreme-Sacrifice-Of-Young-English-By-Unknown.pdf?dl=0",
    ),
    Book(
      bookName: "The Greatest of all guru nanak dev ji",
      bookLink:
          "https://www.dropbox.com/s/e6v3j1ia4swkvxf/(11) The-Greatest-Of-All-Guru-Nanak-Dev-English-By-Unknown (Telugu).pdf?dl=0",
    ),
  ];

  List<Book> _englishBookList = [
    Book(
      bookName: "Combined English Gutka",
      bookLink:
          "https://www.dropbox.com/s/divkzwldq6ax8ca/combined%20gutka%20_english%20_v1.pdf?dl=0",
    ),
    Book(
      bookName: "Combined English Roman line Gutka",
      bookLink:
          "https://www.dropbox.com/s/m0nhe5kykalexn1/combined%20gutka_english%20roman%20line_v1.pdf?dl=0",
    ),
    Book(
      bookName:
          "Bed Time stories 1 -Guru Gobind Singh ji by Santok Singh Jagdev",
      bookLink:
          "https://www.dropbox.com/s/68c7kf2bn2qfubx/Bed-Time-Stories-1-Guru-Gobind-Singh-Ji-By-Santokh-Singh-Jagdev.pdf?dl=0",
    ),
    Book(
      bookName: "Bed Time Stories 2- Guru Nanak dev ji ",
      bookLink:
          "https://www.dropbox.com/s/ookz33d3djszmr0/Bed-Time-Stories-2-Guru-Nanak-Dev-Ji-English.pdf?dl=0",
    ),
    Book(
      bookName: "Bed Time stories 3-Guru Arjan Dev ji ",
      bookLink:
          "https://www.dropbox.com/s/365e8csrn2peqtg/Bed-Time-Stories-3-Guru-Arjan-Dev-English.pdf?dl=0",
    ),
    Book(
      bookName: "Bed Time Stories 4-Guru Teg Bahadur ji",
      bookLink:
          "https://www.dropbox.com/s/vdagqm1r8m8ykbc/Bed-Time-Stories-4-Guru-Tegh-Bahadur-Ji-English.pdf?dl=0",
    ),
    Book(
      bookName:
          "Bed Time Stories 5- Guru Angad Dev ji, Guru Amardass Ji,Guru Ram Das ji",
      bookLink:
          "https://www.dropbox.com/s/48t53d9jlsnrk50/Bed-Time-Stories-5-Guru-Angad-Dev-Guru-AmarDass-Guru-Ram-Dass-Ji.pdf?dl=0",
    ),
    Book(
      bookName: "Bed Time Stories 6- Guru Har gobind,Har rai,Har krishan ji",
      bookLink:
          "https://www.dropbox.com/s/bl0gk3146dcm1x3/Bed-Time-Stories-6-GuruHarGobind-HarRai-HarKrishan-English.pdf?dl=0",
    ),
    Book(
      bookName: "Bed Time Stories 7-Sikh martyrs by Santok singh jagdev",
      bookLink:
          "https://www.dropbox.com/s/p5ncignrjxjmqm7/Bed-Time-Stories-7-Sikh-Martyrs-By-Santokh-Singh-Jagdev.pdf?dl=0",
    ),
    Book(
      bookName: "Bed Time Stories 8 - Khalsa raj by Santok singh jagdev",
      bookLink:
          "https://www.dropbox.com/s/o3pgmhaest603pp/Bed-Time-Stories-8-Khalsa-Raj.pdf?dl=0",
    ),
    Book(
      bookName: "Bed Time stories 9- Sikh Warriors",
      bookLink:
          "https://www.dropbox.com/s/chs3j83bmmhunbg/Bed-Time-Stories-9-Sikh-Warriors.pdf?dl=0",
    ),
    Book(
      bookName: "Bed Time Stories 10 -Honoured Saints",
      bookLink:
          "https://www.dropbox.com/s/v0rbqfz77cb7ruo/Bed-Time-stories-10-Honoured-Saints.pdf?dl=0",
    ),
    Book(
      bookName: "Guru Nanak his life and teachings by Roopinder Singh",
      bookLink:
          "https://www.dropbox.com/s/g076xd3agijswo9/Guru_Nanak_His_Life_&&_Teachings_Roopinder_Singh_English.pdf?dl=0",
    ),
    Book(
      bookName: "Life Stories of Sikh Guru’s by dr. Arjit singh Aulakh",
      bookLink:
          "https://www.dropbox.com/s/ynxv8z6a025ktok/Life-Stories-of-Sikh-Gurus-English-By-Dr-Ajit-Singh-Aulakh.pdf?dl=0",
    ),
    Book(
      bookName: "Stories From Sikh History Book 1",
      bookLink:
          "https://www.dropbox.com/s/nxmmobruhlhlb2a/STORIES-FROM-SIKH-HISTORY-BOOK-1.pdf?dl=0",
    ),
    Book(
      bookName: "Stories From Sikh History Book 2",
      bookLink:
          "https://www.dropbox.com/s/ot0q2mo2wd0384c/STORIES-FROM-SIKH-HISTORY-BOOK-2.pdf?dl=0",
    ),
    Book(
      bookName: "Stories From Sikh History Book 3",
      bookLink:
          "https://www.dropbox.com/s/qpylbzpwsx3akxj/STORIES-FROM-SIKH-HISTORY-BOOK-3.pdf?dl=0",
    ),
    Book(
      bookName: "Stories From Sikh History Book 4",
      bookLink:
          "https://www.dropbox.com/s/s7hc0u21j8ivvkc/STORIES-FROM-SIKH-HISTORY-BOOK-4.pdf?dl=0",
    ),
    Book(
      bookName: "Stories From Sikh History Book 5",
      bookLink:
          "https://www.dropbox.com/s/b7etjtnnvgcazqf/STORIES-FROM-SIKH-HISTORY-BOOK-5.pdf?dl=0",
    ),
    Book(
      bookName: "Stories From Sikh History Book 6",
      bookLink:
          "https://www.dropbox.com/s/04m32c9lw8js2mk/STORIES-FROM-SIKH-HISTORY-BOOK-6.pdf?dl=0",
    ),
    Book(
      bookName: "Stories From Sikh History Book 7",
      bookLink:
          "https://www.dropbox.com/s/tmx87m6dmrbd1t5/STORIES-FROM-SIKH-HISTORY-BOOK-7.pdf?dl=0",
    ),
    Book(
      bookName: "Supreme Sacrifice of young",
      bookLink:
          "https://www.dropbox.com/s/kapcv57bn4uklwm/Supreme-Sacrifice-Of-Young-English-By-Unknown.pdf?dl=0",
    ),
    Book(
      bookName: "The Greatest of all guru nanak dev ji",
      bookLink:
          "https://www.dropbox.com/s/dk0dukj2kjri7xq/The-Greatest-Of-All-Guru-Nanak-Dev-English-By-Unknown.pdf?dl=0",
    ),
    Book(
      bookName: "Zafarnama guru gobind singh ji",
      bookLink:
          "https://www.dropbox.com/s/bpuo2ue8dbx06e3/ZAFARNAMA_GURU_GOBIND_SINGH.pdf?dl=0",
    ),
  ];
  void initState() {
    isDrawer = false;
    isMultiviewDrawer = false;
    super.initState();
    print(Get.arguments);
    // setState(() {
    i = Get.arguments ?? 1;
    // });
    //
    // _languages.add(LanguageModel(code: 'en', name: 'English'));
    // _languages.add(LanguageModel(code: 'hin', name: 'Hindi'));
    // _languages.add(LanguageModel(code: 'ar', name: 'Arabic'));
    // _languages.add(LanguageModel(code: 'gu', name: 'Gujarati'));

    // translations();
    // getUserId();
  }

  List<String> _selectedItems = [
    'English',
  ];

  // List selectedLanguage = [];
  void _showMultiSelect() async {
    // _selectedItems.add(LanguageModel(code: 'en', name: 'English'));
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> items = [
      'English',
      // 'Hindi',
      // 'Arabic',
      // 'Gujarati',
      // "Spanish"
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
          items: items,
          selectedItems: _selectedItems,
        );
      },
    );
    // final List<LanguageModel> nullResult = [];
    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
        print(_selectedItems);
        // _selectedItems.forEach((element) {
        //   print(element.name);
        //   selectedLanguage.add(element.name);
        // });
      });
    }
  }
  // getUserId() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   userId = sharedPreferences.getString("userId");
  // }

  String? bookName;
  // translations() async {
  //   await translator
  //       .translate("Sri Guru Granth Sahib Ji", to: "pa")
  //       .then((value) {
  //     setState(() {
  //       bookName = value.toString();
  //     });

  //     // print(bookName);
  //   });
  // }

  addPage(String gurugranth_id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    final http.Response res = await http.post(
      Uri.parse('http://143.244.139.23:94/api/multiview'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': userId ?? "",
        'gurugranth_id': gurugranth_id,
      }),
    );
    String json = res.body;
    Map<String, dynamic> body = jsonDecode(json);
    print("json ${body["success"]}");
    if (body["success"] == "SuccessFully Created") {
      print("MultiView Added Successsfully");
      CoolAlert.show(
          width: 50,
          context: context,
          type: CoolAlertType.success,
          text: "Added Successfully",
          confirmBtnColor: Theme.of(context).colorScheme.primary);
    } else {
      CoolAlert.show(
          width: 50,
          context: context,
          type: CoolAlertType.warning,
          text: "${body["success"]}",
          confirmBtnColor: Theme.of(context).colorScheme.primary);
    }
  }

  // var guruGranth;
  List<Lines>? guruGranthData;
  Future getAng(String id) async {
    String url = 'http://143.244.139.23:94/api/ang?id=$id';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    String json = response.body;
    var guruGranth = Gurugranth.fromJson(jsonDecode(response.body));
    guruGranthData = guruGranth.data;
    // print(guruGranthData);
    return guruGranth.data;
  }

  _launchURLBrowser(String? bookLink) async {
    var url = Uri.parse(bookLink!);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // List of items in our dropdown menu

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: isDrawer ? const MyDrawer() : const MultiviewDrawer(),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/background.png"),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.only(top: size.height * 0.08),
                width: size.width,
                height: 120,
                color: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(0xFF3D3D3D)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isDrawer = true;
                            });
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 45,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: size.width * 0.03),
                        height: 40,
                        width: size.width * 0.31,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.0),
                            color: Color(0xFF3D3D3D)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isDrawer = false;
                            });
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/multi_view.png",
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "Multi-View",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: 20),
                        height: 40,
                        width: size.width * 0.09,
                        decoration: const BoxDecoration(
                            // borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: InkWell(
                          onTap: () {
                            addPage(guruGranthData?[0].id.toString() ?? "");
                          },
                          child: Center(
                            child: const Icon(
                              Icons.add,
                              color: Color(0xFF3D3D3D),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: _showMultiSelect,
                        child: Container(
                            margin: EdgeInsets.only(left: size.width * 0.025),
                            height: 40,
                            width: size.width * 0.38,
                            decoration: const BoxDecoration(
                              color: Color(0xFF3D3D3D), //<-- SEE HERE
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Translation",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: const Color(0xFF3D3D3D)),
                    child: Image.asset("assets/icons/reading.png"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "List Of Books",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "English Language",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Container(
                    // height: 500,
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _englishBookList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _englishBookList[index].bookName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.01),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURLBrowser(
                                          _englishBookList[index].bookLink);
                                    },
                                    child: Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.8,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Telugu Language",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Container(
                    // height: 500,
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _teluguBookList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _teluguBookList[index].bookName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.01),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURLBrowser(
                                          _teluguBookList[index].bookLink);
                                    },
                                    child: Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.8,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "French Language",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Container(
                    // height: 100,
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _frenchBookList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _frenchBookList[index].bookName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.01),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURLBrowser(
                                          _frenchBookList[index].bookLink);
                                    },
                                    child: Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.8,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Arabic Language",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Container(
                    // height: 100,
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _arabicBookList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _arabicBookList[index].bookName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.01),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURLBrowser(
                                          _arabicBookList[index].bookLink);
                                    },
                                    child: Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.8,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Hindi Language",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Container(
                    // height: 100,
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _hindiBookList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _hindiBookList[index].bookName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.01),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURLBrowser(
                                          _hindiBookList[index].bookLink);
                                    },
                                    child: Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.8,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Persian Language",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Container(
                    // height: 100,
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _persianBookList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _persianBookList[index].bookName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.01),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURLBrowser(
                                          _persianBookList[index].bookLink);
                                    },
                                    child: Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.8,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Swahili Language",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Container(
                    // height: 100,
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _swahiliBookList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _swahiliBookList[index].bookName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.01),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURLBrowser(
                                          _swahiliBookList[index].bookLink);
                                    },
                                    child: Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.8,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Gujaratii Language",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Container(
                    // height: 100,
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _gujaratiBookList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _gujaratiBookList[index].bookName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.01),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURLBrowser(
                                          _gujaratiBookList[index].bookLink);
                                    },
                                    child: Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.8,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Malaysian Language",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Container(
                    // height: 100,
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _malaysianBookList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _malaysianBookList[index].bookName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.01),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURLBrowser(
                                          _malaysianBookList[index].bookLink);
                                    },
                                    child: Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.8,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Marathi Language",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Container(
                    // height: 100,
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _marathiBookList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _marathiBookList[index].bookName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.01),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURLBrowser(
                                          _marathiBookList[index].bookLink);
                                    },
                                    child: Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.8,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Bengali Language",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Container(
                    // height: 100,
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _bengaliBookList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _bengaliBookList[index].bookName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.01),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURLBrowser(
                                          _bengaliBookList[index].bookLink);
                                    },
                                    child: Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.8,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Chinese Language",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Container(
                    // height: 100,
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _chineseBookList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _chineseBookList[index].bookName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.01),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURLBrowser(
                                          _chineseBookList[index].bookLink);
                                    },
                                    child: Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.8,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Odia Language",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Container(
                    // height: 100,
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _odiaBookList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _odiaBookList[index].bookName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.01),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURLBrowser(
                                          _odiaBookList[index].bookLink);
                                    },
                                    child: Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.8,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "German Language",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Container(
                    // height: 100,
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _germanBookList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _germanBookList[index].bookName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.01),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURLBrowser(
                                          _germanBookList[index].bookLink);
                                    },
                                    child: Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.8,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Punjabi Language",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Container(
                    // height: 100,
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _punjabiBookList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _punjabiBookList[index].bookName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.01),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURLBrowser(
                                          _punjabiBookList[index].bookLink);
                                    },
                                    child: Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.8,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
