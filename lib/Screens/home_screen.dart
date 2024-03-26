import 'dart:convert';

import 'package:credit_flutter_task/Models/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List<CreditData> modelData = []; 

Future<void> parseJson() async {
  final data = await rootBundle.loadString('Assets/creditdata.json');
  final jsonData = jsonDecode(data); // No need to cast to List<dynamic>

  // Check if the JSON data is a map
  if (jsonData is Map<String, dynamic>) {
    // Parse a single CreditData object
    modelData.add(CreditData.fromJson(jsonData));
  } else if (jsonData is List<dynamic>) {
    // Parse a list of CreditData objects
    modelData = jsonData.map((e) => CreditData.fromJson(e)).toList();
  }
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    parseJson().then((value) {
      setState(() {
        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight* 0.1- 30 ,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello, Jasim 👋',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      child: Image.asset('Assets/ksa.jpg'),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Saudi Riyal Account',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              
              slivers: [
                SliverAppBar(
                
                  expandedHeight: 150 ,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      height: 190, 
                      width: 150, 
                      padding: const EdgeInsets.symmetric(horizontal: 20, ),
                      // color: Colors.amber,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: modelData.map((e) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(e.account.currency, style: const TextStyle(color: Colors.black, fontSize: 20),),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(e.account.balance.toString(),style: const TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold) ),
                                ],
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Container(
                                height: 44, 
                                width: screenWidth * 0.3,
                                decoration: BoxDecoration(
                                  color:  Colors.orange.shade500,
                                  borderRadius: BorderRadius.circular(25),
                                 
                                ),
                                child: const Center(child: Text('Add money', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                              ), 
                              const SizedBox(
                                width: 20,
                              ),
                              const Text('Transfer', style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),),
                              const Spacer(), 
                              const Icon(Icons.more_horiz)
                            ],
                          ), 
                           const SizedBox(
                                height: 30,
                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('Assets/gift.png', scale: 12.6,),
                               const SizedBox(
                                width: 20,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('New Edge Card', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                  Text('Enjoy 2% cashback offer', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),),
                                ],
                              ),
                               const Spacer(), 
                              Container(
                                height: 44, 
                                width: screenWidth * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(colors: [
                                    Colors.orange.withOpacity(0.2), 
                                    Colors.red.shade500, 
                                  ])
                                ),
                                child: const Center(child: Text('Get now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                              ), 
                             
                              
                             
                              
                            ],
                          ), 
                    
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(delegate: StickyHeaderDelegate(child: Container(
                    height: 60,
                    width: screenWidth,
                    color: Colors.white,
                    padding:  const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text('Transaction History', 
                    style: TextStyle(fontSize: 17,),)), ), pinned: true,),
                SliverPersistentHeader(delegate: StickyHeaderDelegate(child: Container(
                    height: 60,
                    width: screenWidth,
                    color: Colors.white,
                    padding:  const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text('Today', 
                    style: TextStyle(fontSize: 17,),)), ), pinned: true,),
                
                SliverList.builder(
                  itemCount: modelData.first.transactions.length,
                  itemBuilder: (_, index){
                    var d = modelData.first.transactions[index];
                    // if(index == 2){
                    //   return 
                    // }
                    // if(index == 2){
                    //   return StickyHeader(header: Text('Today'), content: Text('Today'));
                    // }
                   
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: screenHeight* 0.1+ 20, 
                        width: screenWidth, 
                        padding: const EdgeInsets.all(17),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade300, blurRadius: 10, offset: const Offset(0, 10))
                        ]
                      ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Image(
                            
                            image: NetworkImage(d.details.image ?? "Assets/no.png",  ), 
                          height: 80,
                          ), 
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(d.details.from, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, ),), 
                              Text(d.details.description, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal,)), 
                            ],
                          ), 
                          const Spacer(),
                            Text(d.amount.toString(), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, ),), 
                        ],),
                      ),
                    );
                })
                // SliverList(
                //   delegate: SliverChildBuilderDelegate(
                //     (context, index) {
                //       return Column(
                //         children: List.generate(modelData.first.transactions.length, 
                //         (indexx) {
                //           var d = modelData[indexx].transactions[indexx];
                //           return Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Container(
                //               height: screenHeight * 0.1, 
                //               width:  screenWidth,
                //               color: Colors.amber,
                //               child: Row(
                //                 children: [
                //                   Image.asset(d.details.image ?? "Assets/gift.png")
                //                 ],
                //               ),
                //             ),
                //           );
                //         })
                         
                //         ,
                //       );
                      
                //       // var d = modelData[index].transactions;
                //       // if(index < modelData.length){
                //       //  return  Column(
                //       //   children: d.map((e) => Text(e.amount.toString())).toList(),
                //       // );
                //       // } else {
                //       //   return  Center(child: CircularProgressIndicator(),); 
                //       // }
                //       // Build your scrollable content here
                      
                //     }
                //   ),
                // ),
              ],
            ),
          ),
          
        ],
      ), 
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, 
        selectedItemColor: Colors.orange,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), 
        BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analytics'), 
        BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Cards'), 
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'), 
        ]
        ),
    );
  }
}

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  StickyHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 45; // Change this to your desired max extent

  @override
  double get minExtent => 22; // Change this to your desired min extent

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}