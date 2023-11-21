import 'package:animate_do/animate_do.dart';
import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/screen/ai_bot/src/services/open_api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/pallete.dart';

class AIHomePage extends StatefulWidget {
  const AIHomePage({super.key});

  @override
  State<AIHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<AIHomePage> {
  bool loading = false;
  int i = 1;
  String? chatgptcontent;

  String lastWords = '';

  TextEditingController searchController = TextEditingController();

  final AIServices openAIServices = AIServices();

  Map<String, String>? message;
  @override
  void initState() {
    super.initState();
    message = {'response0':'Greetings, Provide your symptoms?','prompt0':''}; // Initialize the map here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white54,
        centerTitle: true,
        title: BounceInDown(
          child: const Text(
            'Dr. Bot',
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor),
          ),
        ),
        leading: const Icon(
          Icons.menu,
          color: textColor,
        ),
      ),
      body: Column(children: [
        Container(
          height: 80.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/image/virtualAssistant.png'),
            ),
          ),
        ),
       
        Expanded(
          child: ListView.builder(
            itemCount: (message!.length / 2).ceil(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  index!=0?Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 280.w,
                      child: Container(
                        
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 8.h,
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 212, 224, 249),
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20.r).copyWith(
                            topRight: const Radius.circular(0.0),
                          ),
                        ),
                        child: Text(message!['prompt$index']!,
                            style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.5.sp,
                            )),
                      ),
                    ),
                  ):Container(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: message!['response$index'] == "waiting"
                        ? Container(
                            height: 50.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 8.h,
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 208, 248, 211),
                              border: Border.all(),
                              borderRadius:
                                  BorderRadius.circular(20.r).copyWith(
                                topLeft: const Radius.circular(0.0),
                              ),
                            ),
                            child: CircularProgressIndicator(
                                color: primary, strokeWidth: 3.sp),
                          )
                        : SizedBox(
                          width: 280.w,
                          child: Container(
                              
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 8.h,
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 14.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 208, 248, 211),
                                border: Border.all(),
                                borderRadius:
                                    BorderRadius.circular(20.r).copyWith(
                                  topLeft: const Radius.circular(0.0),
                                ),
                              ),
                              child: Text(
                                message!['response$index']!,
                                style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                        ),
                  ),
                ],
              );
            },
          ),
        ),
        loading
            ? Container()
            : Container(
                height: 50,
                width: double.infinity,
                margin: EdgeInsets.all(15.sp),
                child: TextField(
                  style: TextStyle(color: textColor),
                  maxLines: 1,
                  controller: searchController,
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(top: 6.h, bottom: 5.h, left: 12.w),
                    suffixIcon: InkWell(
                      onTap: () async {
                        print(message);
                        setState(() {
                          message!['prompt${i.toString()}'] =
                              searchController.text.toString();
                          message!['response${i.toString()}'] = "waiting";
                          loading = true;
                        });

                        print(searchController.text.toString());

                        final speech = await openAIServices
                            .chatGPT(searchController.text.toString());
                        print(message);
                        setState(() {
                          message!['response${i.toString()}'] =
                              speech.toString();
                          i = i + 1;
                          searchController.text = "";
                          loading = false;
                        });
                      },
                      child: const Icon(
                        Icons.send_sharp,
                        color: primary,
                      ),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 212, 224, 249),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                    hintText: 'Send a message...',
                  ),
                ),
              )
      ]),
    );
  }
}
