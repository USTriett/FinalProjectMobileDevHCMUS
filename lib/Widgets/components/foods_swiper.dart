
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_food/Bloc/Events/swiper_events/swiper_events.dart';
import 'package:next_food/Bloc/States/swiper_states/swiper_states.dart';
import 'package:next_food/Bloc/swiper_bloc.dart';
import 'package:next_food/Data/data_manager.dart';
import 'package:swipe_cards/swipe_cards.dart';


import 'food_card.dart';



class FoodSwiper extends StatefulWidget{
  List<FoodCard> foodCards;
  Function? like = (){};
  Function? dislike = (){};

  FoodSwiper({super.key, required this.foodCards, required this.context, this.like, this.dislike});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final BuildContext context;
  @override
  State<StatefulWidget> createState() => _FoodSwiperState();
}

class _FoodSwiperState extends State<FoodSwiper> {
  List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;
  List<SwipeItem> _newItems = [];
  int count = 0;

  @override
  void initState() {

    // TODO: implement initState
    List<FoodCard> foodCards = widget.foodCards;
    for (var item in foodCards){
      _swipeItems.add(
          SwipeItem(
            content: item,
            likeAction: widget.like,
            nopeAction: widget.dislike,
          )
      );
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final SwiperBloc swiperBloc = BlocProvider.of<SwiperBloc>(context);
    int n = _newItems.length;
    for(int i = 0; i < n; i ++){
      // SwipeItem newItem = SwipeItem(
      //   content: _swipeItems[i].content,
      //   likeAction: (){
      //     // swiperBloc.add(LikeEvents());
      //     _swipeItems.removeAt(i);
      //   },
      //   nopeAction: (){
      //     // swiperBloc.add(DislikeEvents());
      //     _swipeItems.removeAt(i);
      //   }
      // );
      // _swipeItems.removeAt(i);
      // _swipeItems.insert(i, newItem);
      _swipeItems.add(_newItems[i]);
    }
    _newItems.clear();

    return Scaffold(
        key: widget._scaffoldKey,
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                // height: MediaQuery.of(context).size.height/1.5,
                // width: MediaQuery.of(context).size.width/1.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  // color: Colors.green
                ),
                child:
                BlocBuilder<SwiperBloc, SwiperStates>(
                  builder: (context, state) {
                    if (state is AddMoreCards) {
                      addItemData(swiperBloc);
                    }

                    return SwipeCards(
                      matchEngine: _matchEngine,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: _swipeItems[index].content,
                        );
                      },
                      onStackFinished: () {
                        // Xử lý khi stack đã hoàn thành
                      },
                      itemChanged: (SwipeItem item, int index) {
                        count += 1;
                        count %= 3;

                        if(count == 2){
                          swiperBloc.add(SwipeHalfEvent());
                        }
                      },
                      leftSwipeAllowed: true,
                      rightSwipeAllowed: true,
                      upSwipeAllowed: false,
                      fillSpace: false,
                    );
                  }

                )
              ),
            ),
            // _rowUtilButton(),

          ],
        )
    );
  }
  // Widget _rowUtilButton(){
  //   return Align(
  //     alignment: Alignment.bottomCenter,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         ElevatedButton(
  //             onPressed: () {
  //               _matchEngine!.currentItem?.nope();
  //             },
  //             child: Text("Nope")),
  //
  //         ElevatedButton(
  //             onPressed: () {
  //               _matchEngine!.currentItem?.like();
  //             },
  //             child: Text("Like"))
  //       ],
  //     ),
  //   );
  // }

  Future<void> addItemData(SwiperBloc bloc) async{
    List<FoodCard> newItems = DataManager.getCards(0);
    Future.delayed(const Duration(seconds: 1));
    for (var item in newItems){
      _swipeItems.add(
        SwipeItem(
          content: item,
          likeAction: widget.like,
          nopeAction: widget.dislike,
        )
      );
    }

    bloc.add(AddFinishedEvent());
  }

}
