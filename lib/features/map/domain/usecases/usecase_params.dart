import 'package:petsguides/features/map/domain/usecases/map_search_places_usecase.dart'
    as search_places_params;
import 'package:petsguides/features/map/domain/usecases/map_select_from_search_list_usecase.dart'
    as select_from_search_list_params;
import 'package:petsguides/features/map/domain/usecases/map_get_directions_usecase.dart'
    as get_directions_params;

import 'package:petsguides/features/map/domain/usecases/map_search_in_radius_usecase.dart'
    as search_in_radius_params;

import 'package:petsguides/features/map/domain/usecases/map_tap_on_carousel_card_usecase.dart'
    as tap_on_carousel_card_params;

typedef SearchPlacesParams = search_places_params.Params;

typedef SelectFromSearchListParams = select_from_search_list_params.Params;

typedef GetDirectionsParams = get_directions_params.Params;

typedef SearchInRadiusParams = search_in_radius_params.Params;

typedef TapOnCarouselCardParams = tap_on_carousel_card_params.Params;
