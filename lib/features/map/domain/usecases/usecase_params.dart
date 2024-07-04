import 'package:petsguides/features/map/domain/usecases/map_search_places_usecase.dart'
    as search_places_params;
import 'package:petsguides/features/map/domain/usecases/map_select_from_search_list_usecase.dart'
    as select_from_search_list_params;

import 'package:petsguides/features/map/domain/usecases/map_get_directions_usecase.dart'
    as get_directions_params;

typedef SearchPlacesParams = search_places_params.Params;

typedef SelectFromSearchListParams = select_from_search_list_params.Params;

typedef GetDirectionsParams = get_directions_params.Params;
