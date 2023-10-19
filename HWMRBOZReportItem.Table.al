/// <summary>
/// Component:  RBO Z-Reports
/// </summary>
table 50507 "HWM RBO Z-Report Item"
{
    Caption = 'HWM RBO Z-Report Header';
    DataClassification = CustomerContent;
    DataCaptionFields = "Z-Report No.", Description;
    LookupPageId = "HWM RBO Z-Report Header List";
    DrillDownPageId = "HWM RBO Z-Report Header List";

    fields
    {
        field(1; "Z-Report No."; Code[10])
        {
            Caption = 'Z-Report No.';
            TableRelation = "HWM RBO Z-Report Header"."No.";
        }
        field(2; "Z-Report Line No."; Code[50])
        {
            Caption = 'Line No.';
        }
        field(3; Description; text[100])
        {
            Caption = 'Description';
        }
        field(4; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series"."Code";
            ValidateTableRelation = true;
        }
        field(5; Status; enum "HWM CTR Status")
        {
            Caption = 'Status';
        }
        field(6; "Processing Status"; Enum "HWM CTR Process Status")
        {
            Caption = 'Processing Status';
            Editable = false;
        }
    }

    keys
    {
        key(hwmPK; "Z-Report No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Z-Report No.", "Z-Report Line No.", Description, Status)
        {
        }
    }

    var
        mZReportHeader: Codeunit "HWM RBO Z-Report Management";

    trigger OnInsert()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnInsertZReportItem(Rec, IsHandled);
        if not IsHandled then
            mZReportHeader.ValidateTblZReportItemOnInsert(Rec, xRec);
        OnAfterOnInsertZReportItem(Rec, IsHandled);
    end;

    trigger OnModify()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnModifyZReportItem(Rec, IsHandled);
        if not IsHandled then
            mZReportHeader.ValidateTblZReportItemOnModify(Rec);
        OnAfterOnModifyZReportItem(Rec, IsHandled);
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnDeleteZReportItem(Rec, IsHandled);
        if not IsHandled then
            mZReportHeader.ValidateTblZReportItemOnDelete(Rec);
        OnAfterOnDeleteZReportItem(Rec, IsHandled);
    end;

    trigger OnRename()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnRenameZReportItem(Rec, IsHandled);
        if not IsHandled then
            mZReportHeader.ValidateTblZReportItemOnRename(Rec);
        OnAfterOnRenameZReportItem(Rec, IsHandled);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsertZReportItem(var ZReportHeader: Record "HWM RBO Z-Report Item"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnInsertZReportItem(var ZReportHeader: Record "HWM RBO Z-Report Item"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnModifyZReportItem(var ZReportHeader: Record "HWM RBO Z-Report Item"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnModifyZReportItem(var ZReportHeader: Record "HWM RBO Z-Report Item"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnRenameZReportItem(var ZReportHeader: Record "HWM RBO Z-Report Item"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnRenameZReportItem(var ZReportHeader: Record "HWM RBO Z-Report Item"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDeleteZReportItem(var ZReportHeader: Record "HWM RBO Z-Report Item"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOnDeleteZReportItem(var ZReportHeader: Record "HWM RBO Z-Report Item"; var IsHandled: Boolean)
    begin
    end;


}
