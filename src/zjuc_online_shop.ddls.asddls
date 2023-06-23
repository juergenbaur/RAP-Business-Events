  @EndUserText.label: 'projection view for online shop'
  @AccessControl.authorizationCheck: #NOT_REQUIRED
  @AbapCatalog.viewEnhancementCategory: [#NONE]
  @Search.searchable: true
  @UI: { headerInfo: { typeName: 'Online Shop',
                     typeNamePlural: 'Online Shop',
                     title: { type: #STANDARD, label: 'Online Shop', value: 'order_id' } },

       presentationVariant: [{ sortOrder: [{ by: 'Creationdate',
                                             direction: #DESC }] }] }
  define root view entity ZJUC_ONLINE_SHOP
  as projection on ZJUI_ONLINE_SHOP
  {
      @UI.facet: [          { id:                  'Orders',
                                   purpose:         #STANDARD,
                                   type:            #IDENTIFICATION_REFERENCE,
                                   label:           'Order',
                                   position:        10 }      ]
  key Order_Uuid,

      @UI: { lineItem:       [ { position: 10,label: 'order id', importance: #HIGH } ],
               identification: [ { position: 10, label: 'order id' } ] }
      @Search.defaultSearchElement: true
      Order_Id,

      @UI: { lineItem:       [ { position: 20,label: 'Ordered item', importance: #HIGH } ],
              identification: [ { position: 20, label: 'Ordered item' } ] }
      @Search.defaultSearchElement: true
      Ordereditem,

      Deliverydate as Deliverydate,

      @UI: { lineItem:       [ { position: 50,label: 'Creation date', importance: #HIGH },
                               { type: #FOR_ACTION, dataAction: 'update_inforecord', label: 'Update IR' } ],
             identification: [ { position: 50, label: 'Creation date' } ] }
      Creationdate as Creationdate
  }
