import 'package:e_commerce/models/crud_model.dart';
import 'package:e_commerce/services/api_products.dart';
import 'package:get_it/get_it.dart';


 GetIt locator = GetIt.instance;
 
void setupLocator() {
 
  locator.registerLazySingleton(() => Api('products'));
  locator.registerLazySingleton(() => CRUDModel()) ;
 // locator.registerLazySingleton(() => Api('favorites'));
}