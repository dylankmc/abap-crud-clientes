REPORT  ZCRUD_CLIENTE.
INCLUDE ZCRUD_CLIENTE_TOP.
INCLUDE ZCRUD_CLIENTE_FRM.
INCLUDE ZCRUD_CLIENTE_SOS.

----------------------------------------------------------

** INCLUDE ZCRUD_CLIENTE_TOP

DATA: gt_client TYPE STANDARD TABLE OF zclientes,
      gs_client TYPE zclientes.

PARAMETERS p_row TYPE int4.

  SELECT-OPTIONS: s_client  FOR gs_client-zclient,
                  s_erdat   FOR gs_client-data,
                  s_erzet   FOR gs_client-hora,
                  s_nome    FOR gs_client-znome,
                  s_email   FOR gs_client-zemail,
                  s_credit  FOR gs_client-zcredito,
                  s_status  FOR gs_client-zstatus.

----------------------------------------------------------

** INCLUDE ZCRUD_CLIENTE_FRM.

FORM  read.

  SELECT *
    INTO TABLE gt_client
    FROM zclientes UP TO p_row ROWS
    WHERE zclient     IN s_client[]
      AND data        IN s_erdat[]
      AND hora        IN s_erzet[]
      AND znome       IN s_nome[]
      AND zemail      IN s_email[]
      AND zcredito    IN s_credit[]
      AND zstatus     IN s_status[].

ENDFORM.

FORM alv.

  DATA: ls_fieldcat TYPE slis_fieldcat_alv,
        lt_fieldcat TYPE slis_t_fieldcat_alv.

  CLEAR lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'ZCLIENT'.
  ls_fieldcat-seltext_m = 'Cód. Cliente'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'DATA'.
  ls_fieldcat-seltext_m = 'Data de Criação'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'HORA'.
  ls_fieldcat-seltext_m = 'Hora de Criação'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'ZNOME'.
  ls_fieldcat-seltext_m = 'Nome'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'ZEMAIL'.
  ls_fieldcat-seltext_m = 'E-mail'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'ZCREDITO'.
  ls_fieldcat-seltext_m = 'Limite de Crédito'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'ZSTATUS'.
  ls_fieldcat-seltext_m = 'Status'.
  APPEND ls_fieldcat TO lt_fieldcat.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      i_grid_title             = 'Relatório de Clientes'
      it_fieldcat              = lt_fieldcat
      i_save                   = 'X'
      i_callback_user_command  = 'HANDLE_ALV_EVENT'
      I_CALLBACK_PF_STATUS_SET = 'SET_PF_STATUS'
    TABLES
      t_outtab                 = gt_client
    EXCEPTIONS
      program_error            = 1
      others                   = 2.

  IF sy-subrc <> 0.
    MESSAGE e003(zabap).
  ENDIF.
ENDFORM.

FORM SET_PF_STATUS USING RT_EXTAB TYPE SLIS_T_EXTAB.
  SET PF-STATUS 'STANDARD'.
ENDFORM.

FORM HANDLE_ALV_EVENT

  USING ucomm    TYPE sy-ucomm
        selfield TYPE slis_selfield.

  DATA ld_field  TYPE char10.

  READ TABLE gt_client INTO gs_client INDEX selfield-tabindex.
  ld_field = gs_client-zclient.
  CONDENSE ld_field NO-GAPS.

  SET PARAMETER ID 'ZCLIENT' FIELD ld_field.

  CASE ucomm.
    WHEN 'CRIAR'.
      CALL TRANSACTION 'Z001'.
    WHEN 'EDIT'.
      CALL TRANSACTION 'Z002' AND SKIP FIRST SCREEN.
    WHEN 'DELETE'.
      CALL TRANSACTION 'Z003' AND SKIP FIRST SCREEN.
  ENDCASE.

PERFORM read.
selfield-refresh = 'X'.

ENDFORM.

----------------------------------------------------------

** INCLUDE ZCRUD_CLIENTE_SOS

START-OF-SELECTION.
  PERFORM read.
  PERFORM alv.
