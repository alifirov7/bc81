/// <summary>
/// Component:   RBO Z-Reports
/// </summary>
codeunit 50505 "HWM RBO Z-Report Management"
{
    Description = 'RBO Z-Report Management';
    Subtype = Normal;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        sSetup: Codeunit "HWM RBO Setup Service";
        sCommon: Codeunit "HWM CTR Common Service";
        GlobalZReportHeader: Record "HWM RBO Z-Report Header";

    /// <summary>
    /// ValidateTblZReportHeaderOnInsert.
    /// </summary>
    /// <param name="ZReportHeader">VAR Record "HWM HWM RBO Z-Report Header".</param>
    /// <param name="xZReportHeader">Record "HWM HWM RBO Z-Report Header".</param>
    procedure ValidateTblZReportHeaderOnInsert(var ZReportHeader: Record "HWM RBO Z-Report Header"; xZReportHeader: Record "HWM RBO Z-Report Header")
    begin
        if ZReportHeader."No." = '' then
            NoSeriesMgt.InitSeries(sSetup.GetPosZReportNos(true), xZReportHeader."No. Series", 0D, ZReportHeader."No.", ZReportHeader."No. Series");
    end;
    /// <summary>
    /// ValidateTblZReportHeaderOnModify.
    /// </summary>
    /// <param name="ZReportHeader">VAR Record "HWM RBO Z-Report Header".</param>
    procedure ValidateTblZReportHeaderOnModify(var ZReportHeader: Record "HWM RBO Z-Report Header")
    begin
    end;

    /// <summary>
    /// ValidateTblZReportHeaderOnDelete.
    /// </summary>
    /// <param name="ZReportHeader">VAR Record "HWM RBO Z-Report Header".</param>
    procedure ValidateTblZReportHeaderOnDelete(var ZReportHeader: Record "HWM RBO Z-Report Header")
    begin
    end;

    /// <summary>
    /// ValidateTblZReportHeaderOnRename.
    /// </summary>
    /// <param name="ZReportHeader">VAR Record "HWM RBO Z-Report Header".</param>
    procedure ValidateTblZReportHeaderOnRename(var ZReportHeader: Record "HWM RBO Z-Report Header")
    begin
    end;

    /// <summary>
    /// ValidateFldZReportHeaderOnNo.
    /// </summary>
    /// <param name="ZReportHeader">VAR Record "HWM RBO Z-Report Header".</param>
    /// <param name="xZReportHeader">Record "HWM RBO Z-Report Header".</param>
    procedure ValidateFldZReportHeaderOnNo(var ZReportHeader: Record "HWM RBO Z-Report Header"; xZReportHeader: Record "HWM RBO Z-Report Header")
    begin
        if ZReportHeader."No." = xZReportHeader."No." then
            exit;
        NoSeriesMgt.TestManual(sSetup.GetPosZReportNos(false));
        ZReportHeader."No. Series" := '';
    end;

    /// <summary>
    /// CreateOrModifyZReportHeaderList.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM RBO Z-Report Header".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return variable NoList of type List of [Code[10]].</returns>
    procedure CreateOrModifyZReportHeaderList(var RecBuffer: Record "HWM RBO Z-Report Header"; RunTrigger: Boolean) NoList: List of [Code[10]]
    var
        No: Code[10];
    begin
        TestCreateOrModifyBufferForZReportHeader(RecBuffer, false);
        RecBuffer.Reset();
        GlobalZReportHeader.LockTable();

        if RecBuffer.FindSet(false) then
            repeat
                No := CreateOrModifyZReportHeader(RecBuffer, RunTrigger);
                NoList.Add(No);
            until RecBuffer.Next() = 0;
    end;

    /// <summary>
    /// CreateOrModifySingleZReportHeader.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM RBO Z-Report Header".</param>
    /// <param name="RunTrigger">Boolean.</param>
    /// <returns>Return value of type Code[10].</returns>
    procedure CreateOrModifySingleZReportHeader(var RecBuffer: Record "HWM RBO Z-Report Header"; RunTrigger: Boolean): Code[10]
    begin
        TestCreateOrModifyBufferForZReportHeader(RecBuffer, true);
        GlobalZReportHeader.LockTable();

        if RecBuffer.FindFirst() then
            exit(CreateOrModifyZReportHeader(RecBuffer, RunTrigger));
    end;

    local procedure CreateOrModifyZReportHeader(RecBuffer: Record "HWM RBO Z-Report Header"; RunTrigger: Boolean) RecordNo: Code[10]
    var
        ZReportHeader: Record "HWM RBO Z-Report Header";
        Create: Boolean;
    begin
        if not ZReportHeader.Get(RecBuffer."No.") then
            Create := true;

        If Create then begin
            ZReportHeader.Init();
            ZReportHeader.TransferFields(RecBuffer, true);
            ZReportHeader.Insert(RunTrigger);
            RecordNo := ZReportHeader."No.";
        end else begin
            ZReportHeader.TransferFields(RecBuffer, false);
            ZReportHeader.Modify(RunTrigger);
            RecordNo := ZReportHeader."No.";
        end;
    end;

    /// <summary>
    /// TestCreateOrModifyBufferForZReportHeader.
    /// </summary>
    /// <param name="RecBuffer">VAR Record "HWM RBO Z-Report Header".</param>
    /// <param name="OneRecordOnly">Boolean.</param>
    procedure TestCreateOrModifyBufferForZReportHeader(var RecBuffer: Record "HWM RBO Z-Report Header"; OneRecordOnly: Boolean)
    begin
        sCommon.TestTemporaryRecord(RecBuffer, 'RecBuffer');

        if OneRecordOnly then
            sCommon.TestOneRecordOnly(RecBuffer, 'RecBuffer');

        if RecBuffer.FindSet(false) then
            repeat
                RecBuffer.TestField("No.");
            until RecBuffer.Next() = 0;
    end;

    /// <summary>
    /// DeleteSingleZReportHeader.
    /// </summary>
    /// <param name="No">Code[10].</param>
    /// <param name="SuppressDialog">Boolean.</param>
    /// <param name="RunTrigger">Boolean.</param>
    procedure DeleteSingleZReportHeader(No: Code[10]; SuppressDialog: Boolean; RunTrigger: Boolean)
    var
        DeleteQst: Label 'Are you sure to delete ZReportHeader: %1 ?';
    begin
        if (not SuppressDialog) then
            if (not Confirm(StrSubstNo(DeleteQst, No), true)) then
                exit;
        TestDeleteZReportHeader(No);
        GlobalZReportHeader.Get(No);
        GlobalZReportHeader.Delete(RunTrigger);
    end;

    /// <summary>
    /// TestDeleteZReportHeader.
    /// </summary>
    /// <param name="No">Code[10].</param>
    procedure TestDeleteZReportHeader(No: Code[10])
    var
        ErrorCannotDeleteZReportHeader: Label 'ZReportHeader cannot be deleted.';
    begin
    end;

    /// <summary>
    /// ValidateTblZReportItemOnInsert.
    /// </summary>
    /// <param name="ZReportItem">VAR Record "HWM RBO Z-Report Item".</param>
    /// <param name="xZReportItem">Record "HWM RBO Z-Report Item".</param>
    procedure ValidateTblZReportItemOnInsert(var ZReportItem: Record "HWM RBO Z-Report Item"; xZReportItem: Record "HWM RBO Z-Report Item")
    begin
        if ZReportItem."Z-Report No." = '' then
            NoSeriesMgt.InitSeries(sSetup.GetPosZReportNos(true), xZReportItem."No. Series", 0D, ZReportItem."Z-Report No.", ZReportItem."No. Series");
    end;


    /// <summary>
    /// ValidateTblZReportItemOnModify.
    /// </summary>
    /// <param name="ZReportItem">VAR Record "HWM RBO Z-Report Item".</param>
    procedure ValidateTblZReportItemOnModify(var ZReportItem: Record "HWM RBO Z-Report Item")
    begin

    end;
    /// <summary>
    /// ValidateTblZReportItemOnDelete.
    /// </summary>
    /// <param name="ZReportItem">VAR Record "HWM RBO Z-Report Item".</param>
    procedure ValidateTblZReportItemOnDelete(var ZReportItem: Record "HWM RBO Z-Report Item")
    begin

    end;
    /// <summary>
    /// ValidateTblZReportItemOnRename.
    /// </summary>
    /// <param name="vZReportItem">VAR Record "HWM RBO Z-Report Item".</param>
    procedure ValidateTblZReportItemOnRename(var vZReportItem: Record "HWM RBO Z-Report Item")
    begin

    end;



    local procedure CreateOrModifyZReportItem(RecBuffer: Record "HWM RBO Z-Report Item"; RunTrigger: Boolean) RecordNo: Code[10]
    var
        ZReportItem: Record "HWM RBO Z-Report Item";
        Create: Boolean;
    begin
        if not ZReportItem.Get(RecBuffer."Z-Report No.", RecBuffer."Z-Report No.") then
            Create := true;

        If Create then begin
            ZReportItem.Init();
            ZReportItem.TransferFields(RecBuffer, true);
            ZReportItem.Insert(RunTrigger);
            RecordNo := ZReportItem."Z-Report No.";
        end else begin
            ZReportItem.TransferFields(RecBuffer, false);
            ZReportItem.Modify(RunTrigger);
            RecordNo := ZReportItem."Z-Report No.";
        end;
    end;
}