import 'dart:convert';
import 'package:e_com/models/model_class.dart';
import 'package:e_com/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_com/constants/constants.dart';
import 'package:vrouter/vrouter.dart';

import 'profile/profile_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Future<String> loadNoteAsset() async {
    return await rootBundle.loadString('assets/data/data.json');
  }

  void parsePost() async {
    String source = await loadNoteAsset();
    final parsed = jsonDecode(source);
    for (var item in parsed) {
      data.add(ModelClass.fromJson(item));
    }
    setState(() {
      data = data;
    });
    print(data);
  }

  @override
  void initState() {
    if (data.isEmpty) {
      parsePost();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(250),
          ),
          child: SizedBox(
            width: 250,
            child: Drawer(
              child: new ListView(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    currentAccountPicture: Hero(
                      tag: 'profile',
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://thispersondoesnotexist.com/image',
                        ),
                      ),
                    ),
                    //Color(0xff4367b1)
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                    ),
                    accountName: new Text(
                      'Rohit ranjan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        //color: Colors.grey[300],
                        color: Colors.black,
                      ),
                    ),
                    accountEmail: new Text(
                      'ranjanrohit812@gmail.com',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Your Account',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()),
                      );
                    },
                    leading: new Icon(
                      Icons.person_outlined,
                      size: 26.0,
                      color: Colors.black,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      context.vRouter.to('/pastOrders');
                    },
                    leading: new Icon(
                      Icons.notifications_outlined,
                      size: 26.0,
                      color: Colors.black,
                    ),
                  ),
                  new ListTile(
                    title: new Text(
                      'My Cart',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      context.vRouter.to('/cart');
                    },
                    leading: new Icon(
                      Icons.shopping_cart_outlined,
                      size: 26.0,
                      color: Colors.black,
                    ),
                  ),
                  new ListTile(
                    title: new Text(
                      'Offers',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {},
                    leading: new Icon(
                      Icons.local_offer_outlined,
                      size: 26.0,
                      color: Colors.black,
                    ),
                  ),
                  new Divider(
                    color: Colors.black38,
                  ),
                  new ListTile(
                    title: new Text(
                      'Log-Out',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      context.vRouter.to('/logIn');
                    },
                    leading: Icon(
                      Icons.close,
                      size: 26.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(top: 20.0.sp, bottom: 20.sp),
          child: Text(
            'Buy Materials',
            style: GoogleFonts.fredokaOne(
              fontSize: 30.sp,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 10.0.sp, bottom: 10.sp),
            child: Stack(
              children: [
                Text(
                  '${cart.length}',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    context.vRouter.to('/cart');
                  },
                  icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SearchBox(),
            Image.asset('assets/images/offer.jpg'),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cement',
                    style: GoogleFonts.alfaSlabOne(fontSize: 20.sp),
                  ),
                  TextButton(
                    onPressed: () {
                      context.vRouter.toNamed('items',
                          pathParameters: {'category': 'Cement'});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.1),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-6.0, -6.0),
                            blurRadius: 16.0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 16.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'See More',
                          style: GoogleFonts.alfaSlabOne(
                              fontSize: 10.sp, color: Colors.grey.shade600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: SizedBox(
                height: 200.h,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 3,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (data[index].category == 'Cement') {
                      return itemBuilder(context, index);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Steel',
                    style: GoogleFonts.alfaSlabOne(fontSize: 20.sp),
                  ),
                  TextButton(
                    onPressed: () {
                      context.vRouter.toNamed('items',
                          pathParameters: {'category': 'Steel'});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.1),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-6.0, -6.0),
                            blurRadius: 16.0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 16.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'See More',
                          style: GoogleFonts.alfaSlabOne(
                              fontSize: 10.sp, color: Colors.grey.shade600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: SizedBox(
                height: 200.h,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: data.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (data[index].category == 'Steel') {
                      return itemBuilder(context, index);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Wood',
                    style: GoogleFonts.alfaSlabOne(fontSize: 20.sp),
                  ),
                  TextButton(
                    onPressed: () {
                      context.vRouter.toNamed('items',
                          pathParameters: {'category': 'Wood'});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.1),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-6.0, -6.0),
                            blurRadius: 16.0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 16.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'See More',
                          style: GoogleFonts.alfaSlabOne(
                              fontSize: 10.sp, color: Colors.grey.shade600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: SizedBox(
                height: 200.h,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: data.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (data[index].category == 'Wood') {
                      return itemBuilder(context, index);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding itemBuilder(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: SizedBox(
        width: 115.h,
        child: GestureDetector(
          onTap: () {
            context.vRouter.toNamed('details',
                pathParameters: {'index': '$index', 'fromItem': 'false'});
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 0.9,
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.1),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.8),
                        offset: Offset(-6.0, -6.0),
                        blurRadius: 16.0,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(6.0, 6.0),
                        blurRadius: 16.0,
                      ),
                    ],
                  ),
                  child: Hero(
                    tag: data[index].name!,
                    child: Image.network(data[index].imag!),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                data[index].name!,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₹${data[index].price!}",
                    style: TextStyle(
                      fontSize: 15.w,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      setState(() {
                        cart.add(data[index]);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(5.w),
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-6.0, -6.0),
                            blurRadius: 16.0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 16.0,
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        "assets/svg/plus.svg",
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
