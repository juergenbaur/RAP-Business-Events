@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'data model for online shop'
@Metadata.allowExtensions: true
@ObjectModel.usageType: {
serviceQuality: #X,
sizeCategory: #S,
dataClass: #MIXED
}
define root view entity ZJUI_ONLINE_SHOP
  as select from zju_onlineshop

{
  key order_uuid   as Order_Uuid,
      order_id     as Order_Id,
      ordereditem  as Ordereditem,
      deliverydate as Deliverydate,
      creationdate as Creationdate
}
