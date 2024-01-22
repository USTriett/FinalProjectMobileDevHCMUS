import 'package:bloc/bloc.dart';
import 'package:next_food/Widgets/pages/NavBar.dart';

import 'Events/navbar_events/navbar_events.dart';
import 'States/navbar_states/navbar_states.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState>{
  NavBarBloc():super(HomeState()){
    on<NavBarEvent>((event, emit){
      if (event.TabId == NavBarComponent.RANDOM_PAGE_TAB)
        emit((FindFoodState()));
    });
  }

}