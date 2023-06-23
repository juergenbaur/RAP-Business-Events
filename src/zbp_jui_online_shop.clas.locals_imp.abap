CLASS lsc_zjui_online_shop DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zjui_online_shop IMPLEMENTATION.

  METHOD save_modified.

    IF create-online_shop IS NOT INITIAL.
      RAISE ENTITY EVENT zjui_online_shop~ItemIsOrdered
         FROM VALUE #( FOR online_shop IN create-online_shop ( %key              = online_shop-%key
                                                               %param-ItemName   = online_shop-Ordereditem ) ).
    ENDIF.
  ENDMETHOD.


ENDCLASS.

CLASS lhc_Online_Shop DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Online_Shop RESULT result.

    METHODS calculate_order_id FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Online_Shop~calculate_order_id.

ENDCLASS.

CLASS lhc_Online_Shop IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD calculate_order_id.

    DATA:
      online_shops TYPE TABLE FOR UPDATE zjui_online_shop,
      online_shop  TYPE STRUCTURE FOR UPDATE zjui_online_shop.
* delete from zonlineshop_#### UP TO 15 ROWS.
    SELECT MAX( order_id ) FROM zju_onlineshop INTO @DATA(max_order_id).
    READ ENTITIES OF zjui_online_shop IN LOCAL MODE
    ENTITY Online_Shop
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_online_shop_result)
    FAILED DATA(lt_failed)
    REPORTED DATA(lt_reported).

    DATA(today) = cl_abap_context_info=>get_system_date( ).
    LOOP AT lt_online_shop_result INTO DATA(online_shop_read).
      max_order_id += 1.
      online_shop = CORRESPONDING #( online_shop_read ).
      online_shop-order_id = max_order_id.
      online_shop-Creationdate = today.
      online_shop-Deliverydate = today + 10.
      APPEND online_shop TO online_shops.
    ENDLOOP.

    MODIFY ENTITIES OF zjui_online_shop IN LOCAL MODE
    ENTITY Online_Shop UPDATE SET FIELDS WITH online_shops
    MAPPED DATA(ls_mapped_modify)
    FAILED DATA(lt_failed_modify)
    REPORTED DATA(lt_reported_modify).

  ENDMETHOD.

ENDCLASS.
