import '../../product/models/product_model.dart';
import 'agent_listing_model.dart';

class AgentProductListingModel {
  final AgentListingModel listing;
  final ProductModel product;

  const AgentProductListingModel({
    required this.listing,
    required this.product,
  });
}