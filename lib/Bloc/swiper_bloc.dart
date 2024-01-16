import 'package:bloc/bloc.dart';
import 'package:next_food/Bloc/Events/swiper_events/swiper_events.dart';
import 'package:next_food/Bloc/States/swiper_states/swiper_states.dart';
import 'package:next_food/Data/data_manager.dart';

class SwiperBloc extends Bloc<SwiperEvents, SwiperStates>{
  SwiperBloc():super(InitStates()){
    // on<LikeEvents>((event, emit){
    //   emit(MatchIncrement());
    // });
    // on<DislikeEvents>((event, emit){
    //   emit(NotMatchIncrement());
    // });
    on<SwipeHalfEvent>((event, emit){
      emit(AddMoreCards());
    });
    on<AddFinishedEvent>((event, emit){
      emit(FinishAddCardState());
    });

  }


}