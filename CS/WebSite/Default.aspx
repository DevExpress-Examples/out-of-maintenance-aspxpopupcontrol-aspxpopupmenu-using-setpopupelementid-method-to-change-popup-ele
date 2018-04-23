<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="SwitchPopupElement._Default" %>

<%@ Register Assembly="DevExpress.Web.v10.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v10.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>SwitchPopupElement</title>
    <script type = "text/javascript">
 var currentRowKey = 0;
function OnMouseOver(element, keyValue) {
    currentRowKey = keyValue;
    element.id = "popupElement" + keyValue;
    ClientPopupMenu.SetPopupElementID(element.id);
    ClientPopupMenu.Show();
}
function EditCurrentRow() {
    ClientGridView.StartEditRowByKey(currentRowKey);
}
function SelectCurrentRow() {
    ClientGridView.SelectRowsByKey(currentRowKey, true);
}
function UnselectCurrentRow() {
    ClientGridView.SelectRowsByKey(currentRowKey, false);
}
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxPopupMenu ID = "ASPxPopupMenu" runat = "server" ClientInstanceName = "ClientPopupMenu"
                          PopupAction = "LeftMouseClick" CloseAction = "MouseOut" 
                          PopupHorizontalAlign = "OutsideRight" PopupVerticalAlign = "TopSides">
            <Items>
                <dx:MenuItem Text="Edit" Name="editMenuItem"/>
                <dx:MenuItem Text="Select" Name="selectMenuItem"/>
                <dx:MenuItem Text="Unselect" Name="unselectMenuItem"/>
            </Items>
            <ClientSideEvents ItemClick="function(s, e) { 
             if(e.item.name == 'editMenuItem') 
                 EditCurrentRow();
             else if (e.item.name == 'selectMenuItem')
                 SelectCurrentRow();
             else if (e.item.name == 'unselectMenuItem')
                 UnselectCurrentRow();
             }"  />
        </dx:ASPxPopupMenu>
        
        <div style ="width:100%" >
            <dx:ASPxGridView ID="ASPxGridView" ClientInstanceName="ClientGridView" runat="server" 
                             DataSourceID="AccessDataSource" KeyFieldName="CustomerID" Width="50%" >
                <Columns>
                    <dx:GridViewDataColumn FieldName="ContactName" VisibleIndex="1"/>
                    <dx:GridViewDataColumn FieldName="CompanyName" VisibleIndex="2"/>
                    <dx:GridViewDataColumn FieldName="City" VisibleIndex="3"/>
                    <dx:GridViewDataColumn FieldName="Region" VisibleIndex="4"/>
                    <dx:GridViewDataColumn FieldName="Country" VisibleIndex="5"/>
                    <dx:GridViewDataColumn Caption="" VisibleIndex="6" CellStyle-HorizontalAlign = "Center">
                        <DataItemTemplate>
                                <img src = "img/arrow.png" style="cursor:pointer;" alt = "" 
                                     onmouseover = "OnMouseOver(this, '<%# Container.KeyValue %>')"/>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                </Columns>
                <SettingsPager Mode="ShowPager" PageSize = "10"/>
                <SettingsBehavior AllowMultiSelection="true" />
            </dx:ASPxGridView>
        </div>

        <asp:AccessDataSource ID="AccessDataSource" runat="server" DataFile="~/App_Data/nwind.mdb"
                              SelectCommand="SELECT * FROM [Customers]"/>
    </form>
</body>
</html>
