import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:profile/remote_service.dart';
import 'package:sliver_tools/sliver_tools.dart';
import './profile.dart';


class Prof extends StatefulWidget {
  const Prof({Key? key}) : super(key: key);

  @override
  State<Prof> createState() => _ProfState();
}

class _ProfState extends State<Prof> {
  List<Profile>? profiles;
  var isLoaded = false;
  int index = 0;
  ScrollController controller= ScrollController();
  bool closeTop=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    getData();

    controller.addListener(() {
      setState((){
        closeTop = controller.offset>50;
      });
    });
  }

  getData() async {
    profiles = await RemoteService().getProfiles();

    if (profiles != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height =MediaQuery.of(context).size.height*0.45;
    return Scaffold(
      backgroundColor: Colors.white10,
      body: CustomScrollView(
       // physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: true,
            floating: true,
            title: Text(profiles![index].username),
            centerTitle: true,

          ),
          // SliverList(
          //   // itemExtent: 400,
          //
          //
          //   delegate:
          SliverToBoxAdapter(
            child: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 300,),
              width:double.infinity,
              transformAlignment: Alignment.center,


              alignment: Alignment.center,
              height: closeTop?0:height,

              child: FittedBox(
                fit: BoxFit.fill,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 50,
                      child: Container(
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.7),
                            spreadRadius: 5,
                            blurRadius: 2,
                          ),
                        ]),
                        // padding: const EdgeInsets.all(3.0),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            profiles![index].profilePic,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 130,
                      //  clipBehavior: Clip.hardEdge,
                      width: 250,
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        profiles![index].description,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white60),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text('${profiles![index].likesCount}',
                                style: TextStyle(color: Colors.white)),
                            Text('Likes', style: TextStyle(color: Colors.white60))
                          ],
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        Column(
                          children: [
                            Text('${profiles![index].followers}',
                                style: const TextStyle(color: Colors.white)),
                            const Text('Followers',
                                style: TextStyle(color: Colors.white60))
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text('${profiles![index].following}',
                                style: const TextStyle(color: Colors.white)),
                            const Text('Following',
                                style: TextStyle(color: Colors.white60))
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                        height: 35,
                        width: 130,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(4)),
                        child: FlatButton(
                          onPressed: () {},
                          color: Colors.black,
                          child: const Text(
                            'Edit profile',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
              child: Container(
            height: MediaQuery.of(context).size.height*0.9,
            width: double.infinity,
            child: ContainedTabBarView(
              tabs: const [
                Icon(
                  Icons.add_box_sharp,
                ),
                Icon(Icons.favorite),
              ],
              tabBarProperties: TabBarProperties(
                indicator: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                        color: Colors.grey,
                        style: BorderStyle.solid), // for right side
                  ),
                ),
                width: double.infinity,
                height: 50,
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    border: Border(bottom: BorderSide(color: Colors.white)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 0.5,
                        blurRadius: 2,
                        offset: Offset(1, -1),
                      ),
                    ],
                  ),
                ),
                position: TabBarPosition.top,
                alignment: TabBarAlignment.center,
                indicatorColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[500],
              ),
              views:  [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: GridView.builder(
                      controller: controller,
                      physics: BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 7.0,
                          mainAxisSpacing: 7.0,
                          childAspectRatio: 0.8),
                      // shrinkWrap: true,
                      itemCount: 23,
                      itemBuilder: (context, index) {
                        return Cards();
                      }),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: GridView.builder(
                      controller: controller,
                      physics: BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 7.0,
                          mainAxisSpacing: 7.0,
                          childAspectRatio: 0.8),
                      // shrinkWrap: true,
                      itemCount: 23,
                      itemBuilder: (context, index) {
                        return Cards();
                      }),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

Widget Cards() {
  return Container(
    clipBehavior: Clip.hardEdge,
    // width: 100,
    // height: 250,
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Colors.black87,
          offset: Offset(0.0, 1.0),
          blurRadius: 6.0,
        ),
      ],

      borderRadius: BorderRadius.circular(10),
      // border: Border.all(color: Colors.black),
      image: const DecorationImage(
          image: NetworkImage(
              "https://images.pexels.com/photos/12842811/pexels-photo-12842811.jpeg"),
          fit: BoxFit.cover),
    ),

    child: Stack(
      fit: StackFit.loose,
      alignment: Alignment.topCenter,
      children: [
        Row(
          children: const [
            Icon(
              Icons.play_arrow,
              color: Colors.black,
            ),
            Text(
              '41',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ],
    ),
  );
}

class All extends StatelessWidget {
  const All({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: GridView.builder(

          physics: BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 7.0,
              mainAxisSpacing: 7.0,
              childAspectRatio: 0.8),
          // shrinkWrap: true,
          itemCount: 23,
          itemBuilder: (context, index) {
            return Cards();
          }),
    );
  }
}

class Fav extends StatelessWidget {
  const Fav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: GridView.builder(
          // shrinkWrap: true,

          physics: BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 7.0,
              mainAxisSpacing: 7.0,
              childAspectRatio: 0.68),
          // shrinkWrap: true,
          itemCount: 18,
          itemBuilder: (context, index) {
            return Cards();
          }),
    );
  }
}
