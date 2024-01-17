#Include "TOTVS.ch"


User Function CRMA980()
    Local aArea := FWGetArea()
    Local aParam := PARAMIXB 
    Local xRet := .T.
    Local oObj := Nil
    Local cIdPonto := ""
    Local cIdModel := ""
      
    If aParam != Nil
          
        oObj := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]
              
        If cIdPonto == "MODELCOMMITTTS"
            nOper := oObj:nOperation
  
            If nOper == 3
                u_M030INC()
            Endif

       Endif     
    Endif

    FWRestArea(aArea)
Return xRet


User Function M030INC()
    Local aArea  := GetArea()
    Local lRet   := .T.
     
    DbSelectarea("CTD")
    CTD->(DbSetOrder(1))
     
    If ! CTD->(DbSeek(FWxFilial("CTD") + 'C' + SA1->A1_COD ))
         
        RecLock("CTD", .T.)
        CTD->CTD_FILIAL := XFILIAL("CTD")
        CTD->CTD_ITEM   := 'C' + SA1->A1_COD
        CTD->CTD_DESC01 := SA1->A1_NOME
        CTD->CTD_CLASSE := "2"
        CTD->CTD_NORMAL := "0"
        CTD->CTD_BLOQ   := "2"
        CTD->CTD_DTEXIS := CTOD("01/01/1980")
        CTD->CTD_ITLP   := 'C' + SA1->A1_COD
        CTD->CTD_CLOBRG := "2"
        CTD->CTD_ACCLVL := "1"
        CTD->(MsUnLock())
         
    Endif
     
    RestArea(aArea)

Return lRet
