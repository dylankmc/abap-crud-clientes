PROGRAM SAPMZ_CLIENTE.
INCLUDE SAPMZ_CLIENTE_TOP.
INCLUDE SAPMZ_CLIENTE_FRM.
INCLUDE SAPMZ_CLIENTE_E01.
INCLUDE SAPMZ_CLIENTE_E02.
INCLUDE SAPMZ_CLIENTE_LOP.

----------------------------------------------------------

** INCLUDE SAPMZ_CLIENTE_TOP

DATA gs_cliente TYPE zclientes.
DATA gd_zclient TYPE ZCLIENT_E.
DATA gd_okcode  TYPE sy-ucomm.
DATA gd_field   TYPE char10.

----------------------------------------------------------

** INCLUDE SAPMZ_CLIENTE_FRM

FORM save.

  gs_cliente-data = sy-datum.
  gs_cliente-hora = sy-uzeit.

  INSERT zclientes FROM gs_cliente.

  IF sy-subrc = 0.
    MESSAGE 'Cliente cadastrado com sucesso' TYPE 'S'.
  ELSE.
    MESSAGE 'Cliente já existe'     TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.

FORM modificar_c .

  SELECT SINGLE *
    INTO gs_cliente
    FROM zclientes
    WHERE zclient = gd_zclient.

  IF sy-subrc <> 0.
    MESSAGE e001(zabap) WITH gd_zclient.
    EXIT.
  ENDIF.

  CALL SCREEN 1000.
ENDFORM.

FORM modificar.

  MODIFY zclientes FROM gs_cliente.

  IF sy-subrc = 0.
    MESSAGE 'Cliente atualizado com sucesso' TYPE 'S'.
  ELSE.
    MESSAGE 'Falha ao atualizar cliente'     TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.

FORM deletar_c .

  SELECT SINGLE *
    INTO gs_cliente
    FROM zclientes
    WHERE zclient = gd_zclient.

 IF sy-subrc <> 0.
   MESSAGE s002(zabap) WITH gd_zclient DISPLAY LIKE 'E'.
 ENDIF.

  DELETE FROM zclientes WHERE zclient = gd_zclient.

  IF sy-subrc = 0.
    MESSAGE 'Cliente excluído com sucesso' TYPE 'S'.
    LEAVE.
  ELSE.
    MESSAGE 'Falha ao excluir cliente'     TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.

----------------------------------------------------------

** INCLUDE SAPMZ_CLIENTE_E01

  MODULE pbo_1000 OUTPUT.

    CLEAR gd_okcode.

    SET PF-STATUS 'S1000'.

    IF sy-tcode = 'Z001'.
      SET TITLEBAR 'NEW'.
    ENDIF.

    IF sy-tcode = 'Z002'.
      SET TITLEBAR 'EDIT'.

      LOOP AT SCREEN.
        IF screen-name = 'GS_CLIENTE-ZCLIENT'.
           screen-input = 0.
          MODIFY SCREEN.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMODULE.

  MODULE pai_1000 INPUT.
    CASE gd_okcode.
      WHEN 'BACK'.
        LEAVE.
        LEAVE TO SCREEN 0.
      WHEN 'SAVE'.
       IF sy-tcode = 'Z001'.
         PERFORM save.
       ENDIF.
       IF sy-tcode = 'Z002'.
         PERFORM modificar.
       ENDIF.
  ENDCASE.
  ENDMODULE.

----------------------------------------------------------

** INCLUDE SAPMZ_CLIENTE_E02

MODULE pbo_1001 OUTPUT.

  CLEAR gd_okcode.

 SET PF-STATUS 'S1001'.

 IF sy-tcode = 'Z002'.
   SET TITLEBAR 'MOD'.
 ENDIF.

 IF sy-tcode = 'Z003'.
   SET TITLEBAR 'DEL'.

 ENDIF.

ENDMODULE.

MODULE pai_1001 INPUT.
  CASE gd_okcode.

    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'SAVE'.
    WHEN 'EXEC' OR ''.

      IF sy-tcode = 'Z002'.
        PERFORM modificar_c.
      ENDIF.

      IF sy-tcode = 'Z003'.
        PERFORM deletar_c.
      ENDIF.

  ENDCASE.
ENDMODULE.

----------------------------------------------------------

LOAD-OF-PROGRAM.
  gs_cliente-zstatus = 'A'.

  GET PARAMETER ID 'ZCLIENT' FIELD gd_field.

  gd_zclient = gd_field.
