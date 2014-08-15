/*
   ExpressWeb Framework by Developer Express
   ExpressWebGrid

   Copyright (c) 2000-2004 Developer Express Inc.
   ALL RIGHTS RESERVED

   The entire contents of this file is protected by U.S. and
   International Copyright Laws. Unauthorized reproduction,
   reverse-engineering, and distribution of all or any portion of
   the code contained in this file is strictly prohibited and may
   result in severe civil and criminal penalties and will be
   prosecuted to the maximum extent possible under the law.
*/

function dx_GridPainter(AGrid)
{
  this.Grid = AGrid;
  this.DataControl = AGrid.DataControl;
  this.DataController = AGrid.DataController;

  this.Update = function() {
        if(!Exists(this.DataController)) return;
        var MoveInFrame = this.MoveInFrame();
        this.Grid.UpdateFirstVisibleRow();
        this.RestoreSelection();
        if(this.DataController.LoadAllRecords && !MoveInFrame) {
                this.RestructureFrame(this.NeedRestructure());
                if(this.DataController.ActionName == "UNDEFINED") {
                        this.FormGroupingPanel();
                        this.FormHeaderPanel();
                }
                if(this.DataController.ActionName == "SORT") {
                        if(this.DataController.GetGroupingItemCount() != 0) this.FormHeaderPanel();
                        this.SetSortingImages();
                }
                if(this.DataController.ActionName == "GROUP" || this.DataController.ActionName == "UNGROUP") {
                        this.FormGroupingPanel();
                        this.FormHeaderPanel();
                }
                if(this.DataController.ActionName == "EXPAND") {
                        this.FormHeaderPanel();
                }
                if(this.DataController.ActionName == "STARTEDIT") {
                        var EditModeInput = document.getElementById(this.Grid.Name + "EditMode");
                        if(EditModeInput != null) EditModeInput.value = "true";
                        this.FormHeaderPanel();
                }
                if(this.DataController.ActionName == "CANCELEDIT") {
                        var EditModeInput = document.getElementById(this.Grid.Name + "EditMode");
                        if(EditModeInput != null) EditModeInput.value = "false";
                        this.FormHeaderPanel();
                }
                if(this.DataController.ActionName == "MOVETO" || this.DataController.ActionName == "MOVEBY") {
                        this.FormHeaderPanel();
                }
                this.SetStatusPanelText();
                this.AdjustGridWidth();
        }
        this.SetSelection();
  }
  this.MoveInFrame = function() {
        if(Exists(this.DataController)) {
                return (((this.DataController.ActionName == "MOVETO") ||
                  (this.DataController.ActionName == "MOVEBY")) &&
                  ((this.DataController.FocusedRow >= this.Grid.SavedFirstVisibleRow) &&
                  (this.DataController.FocusedRow < this.Grid.SavedFirstVisibleRow + this.Grid.PageSize)));
        }
        else return true;
  }
  this.NeedRestructure = function() {
        if(Exists(this.DataController)) {
                return ((this.DataController.GetGroupingItemCount() != 0) ||
                  (this.DataController.ActionName == "UNGROUP") ||
                  (this.DataController.ActionName == "STARTEDIT") ||
                  (this.DataController.ActionName == "CANCELEDIT") ||
                  (this.DataController.ActionName == "UNDEFINED"));
        }
        else return false;
  }
  this.RestructureFrame = function(structureChanged) {
        if(structureChanged) {
                for(var i = 0; i < this.Grid.ColumnCount; i ++) {
                        this.Grid.Columns[i].Finalize();
                }
                var table = this.Grid.GetDataTable();
                if(!Exists(table)) return;

                var tbody = table.lastChild;
                table.removeChild(tbody);
                var tBody = document.createElement("TBODY");
                table.appendChild(tBody);
                for(var nodeIndex = this.Grid.FirstVisibleRow; nodeIndex < this.Grid.FirstVisibleRow + this.Grid.PageSize; nodeIndex ++) {
                        if(!this.DataController.Rows[nodeIndex]) continue;
                        if(this.DataController.Rows[nodeIndex].level == this.DataController.GetGroupingItemCount())
                                this.FormNode(nodeIndex);
                        else
                                this.FormGroupNode(nodeIndex);
                }
        }
        else this.UpdateFrameData();
  }
  this.UpdateFrameData = function() {
        for(var i = 0; i < this.Grid.ColumnCount; i ++) {
                this.Grid.Columns[i].Finalize();
        }
        var table = this.Grid.GetDataTable();
        if(!Exists(table)) return;

        var tbody = table.lastChild;
        var nodeIndex = this.Grid.FirstVisibleRow;
        var images = new Array();
        var buttons = new Array();
        var btnID;
        if(this.Grid.LBCursorStyle) btnID = scxNodeBtnID
        else btnID = scxDeleteBtnID;
        for(var i = 0; i < tbody.childNodes.length; i ++) {
                var row = tbody.childNodes[i];
                if(!row || !row.id || (row.id.indexOf(scxNodeID) == -1)) continue;

                var oldIndex = row.id.substr(row.id.indexOf(scxNodeID) + scxNodeID.length);
                var nodeImg = document.getElementById(this.Grid.Name + scxNodeImgID + oldIndex);
                if(nodeImg) images[images.length] = nodeImg;
                var nodeBtn = document.getElementById(this.Grid.Name + btnID + oldIndex);
                if(nodeBtn) buttons[buttons.length] = nodeBtn;
                row.id = this.Grid.Name + scxNodeID + nodeIndex;

                for(var j = 0; j < this.Grid.ColumnCount; j ++) {
                        var cell = dxGrid.Obj.GetChildById(row, this.Grid.Name + scxCellID + oldIndex + "_" + j);
                        if (Exists(cell)) {
                                while(cell.hasChildNodes()) cell.removeChild(cell.lastChild);

                                var isEditing = ((nodeIndex == this.DataController.FocusedRow) &&
                                        (this.Grid.EditMode()) && !this.Grid.Columns[j].ReadOnly)
                                        this.FormCellContent(cell, nodeIndex, j, isEditing);
                                cell.id = this.Grid.Name + scxCellID + nodeIndex + "_" + j;
                         }
                }
                nodeIndex ++;
        }
        for(var i = 0; i < images.length; i ++)
                images[i].id = this.Grid.Name + scxNodeImgID + eval(this.Grid.FirstVisibleRow + i);
        for(var i = 0; i < buttons.length; i ++)
                buttons[i].id = this.Grid.Name + btnID + eval(this.Grid.FirstVisibleRow + i);
  }

  this.FormCellContent = function(ParentEl, nodeIndex, itemIndex, isEditing) {
        this.Grid.Columns[itemIndex].FormCellContent(ParentEl, nodeIndex, isEditing);
  }
  this.FormControlCell = function(parentTR, nodeIndex) {
        if(!this.Grid.ShowIndicator) return;

        var divId, divCl, imgSrc;
        if(this.Grid.LBCursorStyle)
        {
                if(nodeIndex != this.DataController.FocusedRow) {
                        divId = this.Grid.Name + scxNodeBtnID + nodeIndex;
                        divCl = scxNodeBtnHandler;
                        imgSrc = GridButtonsImages[0];
                } else {
                        if(this.Grid.EditMode()) {
                                divId = this.Grid.Name + scxPostBtnID;
                                divCl = scxPostBtnHandler;
                                imgSrc = GridButtonsImages[3];
                        } else {
                                divId = this.Grid.Name + scxNodeBtnID + nodeIndex;
                                divCl = scxNodeBtnHandler;
                                imgSrc = GridButtonsImages[5];
                        }
                }
        } else {
                if(this.DataController.Rows[nodeIndex].level != this.DataController.GetGroupingItemCount()) {
                        divId = this.Grid.Name + scxNodeBtnID + nodeIndex;
                        divCl = scxNodeBtnHandler;
                        imgSrc = GridButtonsImages[0];
                } else {
                        if(nodeIndex == this.DataController.FocusedRow && this.Grid.EditMode()) {
                                divId = this.Grid.Name + scxPostBtnID;
                                divCl = scxPostBtnHandler;
                                imgSrc = GridButtonsImages[3];
                        } else {
                                divId = this.Grid.Name + scxDeleteBtnID + nodeIndex;
                                divCl = scxDeleteBtnHandler;
                                imgSrc = GridButtonsImages[1];
                        }
                }
        }

        var ctd = document.createElement("TD");
        parentTR.appendChild(ctd);
        ctd.height = this.Grid.RowHeight;
        ctd.width = this.Grid.ControlColumnWidth;
        ctd.align = "center";
        ctd.valign = "center";
        ctd.style.backgroundColor = "#D4D0C8";
        ctd.style.borderWidth = 0;

        this.FormButton(ctd, nodeIndex, divId, divCl, -1,
            this.Grid.ControlColumnWidth, this.Grid.Name + scxNodeImgID + nodeIndex,
            imgSrc, this.Grid.IndicatorStyle)
  }
  this.FormButton = function(parentEl, nodeIndex, id, handler, height, width, imgId, imgSrc, className) {
        width = width - BorderCorrect;
        height = height - BorderCorrect;

        var cdiv = document.createElement("DIV");
        parentEl.appendChild(cdiv);
        cdiv.id = id;
        cdiv.className = className;
        cdiv.align = "center"
        if(document.all) cdiv.onclick = eval(handler);
        if (height < 0)
          cdiv.style.height = "100%";
        else
          cdiv.style.height = height;
        if (width < 0)
          cdiv.style.width = "100%";
        else
          cdiv.style.width = width;

        var cctable = document.createElement("TABLE");
        cdiv.appendChild(cctable);
        cctable.height = "100%";
        cctable.width = "100%";
        cctable.cellSpacing = "0px";
        cctable.cellPadding = "0px";
        cctable.border = 0;

        var cctbody = document.createElement("TBODY");
        cctable.appendChild(cctbody);

        var cctr = document.createElement("TR");
        cctbody.appendChild(cctr);

        var cctd = document.createElement("TD");
        cctr.appendChild(cctd);
        cctd.align = "center";
        cctd.valign = "center";

        var ccimg = document.createElement("IMG");
        cctd.appendChild(ccimg);
        ccimg.align = "top";
        ccimg.border = 0;
        ccimg.id = imgId;
        ccimg.src = imgSrc;
  }
  this.FormCell = function(parentTR, nodeIndex, itemIndex, isEditing) {
        var td = document.createElement("TD");
        parentTR.appendChild(td);
        td.id = this.Grid.Name + scxCellID + nodeIndex + "_" + itemIndex;
        td.className = this.Grid.Columns[itemIndex].GetDefaultStyle(nodeIndex);
        if(this.Grid.ShowGrid) {
                td.style.borderColor = "#000000";
                td.style.borderStyle = "solid";
                td.style.borderLeftWidth = 0;
                td.style.borderTopWidth = 0;
                if(itemIndex == this.Grid.ColumnCount - 1) td.style.borderRightWidth = 0;
        }
        else td.style.borderWidth = 0;
        td.height = this.Grid.RowHeight;
        td.width = this.Grid.Columns[itemIndex].Width - BorderCorrect
        this.FormCellContent(td, nodeIndex, itemIndex, isEditing);
  }
  this.FormNode = function(nodeIndex) {
        var table = this.Grid.GetDataTable();
        if(!Exists(table)) return;

        var tbody = table.lastChild;
        var tr = document.createElement("TR");
        tbody.appendChild(tr);
        tr.id = this.Grid.Name + "_TR_" + nodeIndex;
        tr.height = this.Grid.RowHeight;
        tr.style.cursor = "default";
        if(dxGrid.Inf.ie) tr.onclick = OnTRCl;

        this.FormControlCell(tr, nodeIndex);

        var nextRowLevel;
        var rowLevel = this.DataController.Rows[nodeIndex].level;
        if((nodeIndex + 1) < this.DataController.RowCount)
                nextRowLevel = this.DataController.Rows[nodeIndex + 1].level;
        else
                nextRowLevel = -1;

        for(var i = 0; i < this.DataController.GetGroupingItemCount(); i ++) {
                var eetd = document.createElement("TD");
                tr.appendChild(eetd);
                eetd.className = this.Grid.GroupNodesStyle;
                eetd.width = this.Grid.ControlColumnWidth;
                eetd.align = "center";
                eetd.valign = "center";
                if(this.Grid.ShowGrid) {
                        eetd.style.borderStyle = "solid";
                        eetd.style.borderColor = "#000000";
                        eetd.style.borderTopWidth = 0;
                        eetd.style.borderLeftWidth = 0;
                        if(nextRowLevel > i) eetd.style.borderBottomWidth = 0;
                }
                else eetd.style.borderWidth = 0;
                eetd.innerHTML = "&nbsp;";
        }

        for(var itemIndex = 0; itemIndex < this.Grid.ColumnCount; itemIndex ++) {
                if(!this.Grid.IsVisibleColumn(itemIndex)) continue;
                var isEditing = ((nodeIndex == this.DataController.FocusedRow) &&
                    (this.Grid.EditMode()) && !this.Grid.Columns[itemIndex].ReadOnly)
                this.FormCell(tr, nodeIndex, itemIndex, isEditing);
        }
  }
  this.FormExpandingCells = function(parentTR, nodeIndex) {
        var divId, divCl, imgSrc;
        divId = this.Grid.Name + scxExpandBtnID + nodeIndex;
        if(this.DataController.Rows[nodeIndex].expanded == true)
                imgSrc = GridButtonsImages[7];
        else
                imgSrc = GridButtonsImages[6];
        if(this.DataController.AllowExpanding)
                divCl = scxExpandBtnHandler;
        else
                divCl = null;

        var nextRowLevel;
        var rowLevel = this.DataController.Rows[nodeIndex].level;
        if((nodeIndex + 1) < this.DataController.RowCount)
                nextRowLevel = this.DataController.Rows[nodeIndex + 1].level;
        else
                nextRowLevel = -1;


        for(var i = 0; i <= this.DataController.Rows[nodeIndex].level; i ++) {
                var eetd = document.createElement("TD");
                parentTR.appendChild(eetd);
                eetd.width = this.Grid.ControlColumnWidth;
                eetd.align = "center";
                eetd.valign = "center";
                if(this.Grid.ShowGrid) {
                        eetd.style.borderStyle = "solid";
                        eetd.style.borderColor = "#000000";
                        eetd.style.borderTopWidth = 0;
                        eetd.style.borderLeftWidth = 0;
                        if(nextRowLevel > i) eetd.style.borderBottomWidth = 0;
                        eetd.style.borderRightWidth = 1;
                }
                else eetd.style.borderWidth = 0;
                eetd.className = this.Grid.GroupNodesStyle;

                if(i == this.DataController.Rows[nodeIndex].level) {
                        eetd.style.borderRightWidth = 0;
                        this.FormButton(eetd, nodeIndex, divId, divCl, WebGridExpandBitmapHeight + 2,
                            WebGridExpandBitmapWidth + 2, this.Grid.Name + "_EXPANDIMG_" + nodeIndex,
                            imgSrc, this.Grid.IndicatorStyle)
                } else {
                        eetd.innerHTML = "&nbsp;";
                }
        }
  }
  this.FormGroupingCell = function(parentTR, nodeIndex) {
        var groupingLevel = this.DataController.Rows[nodeIndex].level;
        var recordIndex = this.DataController.Rows[nodeIndex].recordIndex;
        var itemIndex = this.DataController.GetGroupingItemIndex(groupingLevel);

        var td = document.createElement("TD");
        parentTR.appendChild(td);
        td.id = this.Grid.Name + scxCellID + nodeIndex;

        var nodeWidth = this.Grid.Width - 2 * this.Grid.BorderWidth - this.Grid.ControlColumnWidth * (1 + groupingLevel);
        if(this.Grid.ShowIndicator) nodeWidth -= this.Grid.ControlColumnWidth;
        var nodeColSpan = this.DataController.GetGroupingItemCount() - groupingLevel - 1;
        for(var i = 0; i < this.Grid.ColumnCount; i ++) {
                if(!this.Grid.IsVisibleColumn(i))
                        nodeWidth -= this.Grid.Columns[i].Width;
                else
                        nodeColSpan ++;
        }

        td.colSpan = nodeColSpan;
        td.height = this.Grid.RowHeight;
		if(nodeWidth > 0)
			td.width = nodeWidth;
        td.align = "left";
        td.valign = "center";
        if(this.Grid.ShowGrid) {
                td.style.borderTopWidth = 0;
                td.style.borderLeftWidth = 0;
                td.style.borderRightWidth = 0;
                td.style.borderColor = "#000000";
                td.style.borderStyle = "solid";
        }
        else td.style.borderWidth = 0;
        td.className = this.Grid.GroupNodesStyle;
        var columnIndex = this.Grid.GetColumnIndexByFieldIndex(itemIndex);
        td.innerHTML = "&nbsp;" + this.Grid.Columns[columnIndex].Title + " : " + this.DataController.GetRowDisplayText(nodeIndex, itemIndex);
  }
  this.FormGroupNode = function(nodeIndex) {
        var table = this.Grid.GetDataTable();
        if(!Exists(table)) return;

        var tbody = table.lastChild;
        var tr = document.createElement("TR");
        tbody.appendChild(tr);

        tr.id = this.Grid.Name + "_GTR_" + nodeIndex;
        tr.height = this.Grid.RowHeight;
        tr.style.cursor = "default";
        if(dxGrid.Inf.ie) tr.onclick = OnGTRCl;

        this.FormControlCell(tr, nodeIndex);
        this.FormExpandingCells(tr, nodeIndex)
        this.FormGroupingCell(tr, nodeIndex)
  }
  this.DeselectNode = function(oldNode) {
        if(!Exists(oldNode)) return;
        for(var i = 0; i < oldNode.cells.length; i ++) {
                var oldtd = oldNode.cells[i];
                if(!oldtd || !oldtd.id || (oldtd.id.indexOf(scxCellID) == -1)) continue;
                oldtd.style.color = this.Grid.SavedForeColors[i];
                for(var j = 0; j < oldtd.all.length; j ++) {
                        if(oldtd.all[j].tagName != "INPUT" && oldtd.all[j].tagName != "SELECT" &&
                            oldtd.all[j].tagName != "OPTION")
                                oldtd.all[j].style.color = this.Grid.SavedForeColors[i];
                }
                oldtd.style.backgroundColor = this.Grid.SavedBackColors[i];
                for(var j = 0; j < oldtd.all.length; j ++) {
                        if(oldtd.all[j].tagName != "INPUT" && oldtd.all[j].tagName != "SELECT" &&
                            oldtd.all[j].tagName != "OPTION")
                                oldtd.all[j].style.backgroundColor = this.Grid.SavedBackColors[i];
                }
        }
  }
  this.SelectNode = function(newNode) {
        if(!Exists(newNode)) return;
        for(var i = 0; i < newNode.cells.length; i ++) {
                var td = newNode.cells[i];
                if(!td || !td.id || (td.id.indexOf(scxCellID) == -1)) continue;
                this.Grid.SavedForeColors[i] = td.style.color;
                this.Grid.SavedBackColors[i] = td.style.backgroundColor;
                td.style.color = this.Grid.SelectedForeColor;
                for(var j = 0; j < td.all.length; j ++) {
                        if(td.all[j].tagName != "INPUT" && td.all[j].tagName != "SELECT" &&
                            td.all[j].tagName != "OPTION")
                                td.all[j].style.color = this.Grid.SelectedForeColor;
                }
                td.style.backgroundColor = this.Grid.SelectedBackColor;
                for(var j = 0; j < td.all.length; j ++) {
                        if(td.all[j].tagName != "INPUT" && td.all[j].tagName != "SELECT" &&
                            td.all[j].tagName != "OPTION")
                                td.all[j].style.backgroundColor = this.Grid.SelectedBackColor;
                }
        }
  }
  this.SetLeftButtonImage = function(nodeIndex, imgSrc) {
        var Img = dxGrid.Obj.GetElementById(this.Grid.Name + scxNodeImgID + nodeIndex);
        if(Exists(Img)) Img.src = imgSrc;
  }
  this.RestoreSelection = function() {
        var SavedSelection = this.Grid.SavedFocusedRow - this.Grid.SavedFirstVisibleRow;
        var table = this.Grid.GetDataTable();
        if(Exists(table)) {
                var oldselected = table.rows[SavedSelection];
                this.DeselectNode(oldselected);
                if(this.Grid.LBCursorStyle && !this.Grid.EditMode()) {
                        this.SetLeftButtonImage(this.Grid.SavedFocusedRow, GridButtonsImages[0]);
                }
        }
        this.Grid.SavedFocusedRow = this.DataController.FocusedRow;
        this.Grid.SavedFirstVisibleRow = this.Grid.FirstVisibleRow;
  }
  this.SetSelection = function() {
        var table = this.Grid.GetDataTable();
        if(Exists(table)) {
                selected = table.rows[this.DataController.FocusedRow - this.Grid.FirstVisibleRow];
                this.SelectNode(selected);
                if(this.Grid.LBCursorStyle && !this.Grid.EditMode()) this.SetLeftButtonImage(this.DataController.FocusedRow, GridButtonsImages[5]);
        }
  }
  this.SetSortingImages = function() {
        for(var i = 0; i < this.Grid.ColumnCount; i ++)
        {
                var fieldIndex = this.Grid.Columns[i].FieldIndex;
                var sortingOrder = this.DataController.GetItemSortOrder(fieldIndex);
                var sortingImage = dxGrid.Obj.GetElementById(this.Grid.Name + scxSortImgID + i);
                if(Exists(sortingImage)) {
                        sortingImage.src = GridSortingImages[sortingOrder];
                        for(var j = 0; j < sortingImage.length; j ++) {
                                sortingImage[j].src = GridSortingImages[sortingOrder];
                        }
                }
        }
  }
  this.FormHeaderNode = function(ParentEl, height, width, Id, Hint, Handler, imgId, imgSrc, nodeIndex) {
        width = width - BorderCorrect;
        height = height - BorderCorrect;

        var hdiv = document.createElement("DIV");
        ParentEl.appendChild(hdiv);
        hdiv.id = Id;
        hdiv.title = Hint;
        hdiv.className = this.Grid.HeaderStyle;
        hdiv.style.cursor = "hand";
        hdiv.style.height = height;
        hdiv.style.width = width;
        hdiv.style.overflow = "hidden";
        hdiv.onmousedown = eval(Handler);

        var htable = document.createElement("TABLE");
        hdiv.appendChild(htable);
        htable.className = this.Grid.HeaderStyle;
        htable.height = "100%";
        htable.width = "100%";
        htable.border = 0;
        htable.cellSpacing = 0;
        htable.cellPadding = 0;
        htable.style.borderWidth = 0;

        var htbody = document.createElement("TBODY");
        htable.appendChild(htbody);

        var htr = document.createElement("TR");
        htbody.appendChild(htr);

        var htd = document.createElement("TD");
        htr.appendChild(htd);
        htd.align = "center";
        htd.valign = "center";
        var Text = document.createTextNode(this.Grid.Columns[nodeIndex].Title + " ");
        htd.appendChild(Text);

        var ihtd = document.createElement("TD");
        htr.appendChild(ihtd);
        ihtd.align = "center";
        ihtd.valign = "center";
        ihtd.style.width = WebGridSortBitmapWidth + 4;

        var himg = document.createElement("IMG");
        ihtd.appendChild(himg);
        himg.id = imgId;
        himg.align = "absmiddle";
        himg.border = 0;
        himg.src = imgSrc;
  }
  this.AdjustGridWidth = function() {
        var width = this.Grid.GetWidth();

        var element = this.Grid.GetGroupPanel();
        if(Exists(element)) element.style.width = width;
        var element = this.Grid.GetHeaderPanelTable();
        if(Exists(element)) element.style.width = width;
        var element = this.Grid.GetDataTable();
        if(Exists(element)) element.style.width = width;
        var element = this.Grid.GetStatusPanelTable();
        if(Exists(element)) element.style.width = width;
  }
  this.FormGroupingPanel = function() {
        var panel = this.Grid.GetGroupPanelTable();
        if(!Exists(panel)) return;

        var groupPanelTBody = panel.lastChild;
        panel.removeChild(groupPanelTBody);
        groupPanelTBody = document.createElement("TBODY");
        panel.appendChild(groupPanelTBody);
        if(this.DataController.GetGroupingItemCount() == 0) {
                var tr = document.createElement("TR");
                groupPanelTBody.appendChild(tr);
                var td = document.createElement("TD");
                tr.appendChild(td);
                td.style.cursor = "default";
                td.style.borderWidth = 0;
                td.innerHTML = scxEmptyGroupPanelText;
        } else {
                if(dxGrid.Inf.ie) {
                        var builder = new dx_GridGroupPanelBuilder(this);
                        builder.BuildTable(groupPanelTBody);
                        delete builder;
                } else {
                        var tr = document.createElement("TR");
                        groupPanelTBody.appendChild(tr);
                        var itemCount = this.DataController.GetGroupingItemCount();
                        var AWidth = 0;
                        for(var i = 0; i < itemCount; i ++) {
                                var td = document.createElement("TD");
                                tr.appendChild(td);
                                td.width = WebGridGroupPanelInterval;
                                td.style.borderWidth = 0;
                                td.innerHTML = "&nbsp;";
                                var td = document.createElement("TD");
                                tr.appendChild(td);
                                td.width = WebGridGroupPanelNodeWidth;
                                td.align = "center";
                                td.valign = "center";
                                td.style.borderWidth = 0;

                                var ItemIndex = this.DataController.GetGroupingItemIndex(i);
                                var columnIndex = this.Grid.GetColumnIndexByFieldIndex(ItemIndex);
                                var Id = this.Grid.Name + '_GHeader_' + columnIndex;
                                var sortingOrder = this.DataController.GetItemSortOrder(ItemIndex);
                                var ImgId = this.Grid.Name + scxSortImgID + columnIndex;
                                this.FormHeaderNode(td, this.Grid.HeaderHeight, WebGridGroupPanelNodeWidth,
                                    Id, "", "", ImgId, GridSortingImages[sortingOrder], columnIndex);
                                AWidth += (WebGridGroupPanelInterval + WebGridGroupPanelNodeWidth);
                        }
                        var td = document.createElement("TD");
                        tr.appendChild(td);
                        td.style.borderWidth = 0;
                        td.innerHTML = "&nbsp;";
                }
        }
  }
  this.FormHeaderPanel = function() {
        var panel = this.Grid.GetHeaderPanel();
        if(!Exists(panel)) return;

        while(panel.hasChildNodes()) panel.removeChild(panel.firstChild);
        if(this.Grid.ShowIndicator) {
                var divId, divCl, imgSrc;
                if(this.Grid.EditMode()) {
                        divId = this.Grid.Name + scxCancelBtnID;
                        divCl = scxCancelBtnHandler;
                        imgSrc = GridButtonsImages[4];
                } else {
                        if(this.Grid.LBCursorStyle) {
                                divId = this.Grid.Name + scxNodeBtnID;
                                divCl = scxNodeBtnHandler;
                                imgSrc = GridButtonsImages[0];
                        } else {
                                divId = this.Grid.Name + scxInsertBtnID;
                                divCl = scxInsertBtnHandler;
                                imgSrc = GridButtonsImages[2];
                        }
                }
                var ctd = document.createElement("TD");
                panel.appendChild(ctd);
                ctd.height = this.Grid.HeaderHeight;
                ctd.width = this.Grid.ControlColumnWidth;
                ctd.align = "center";
                ctd.valign = "center";
                ctd.style.backgroundColor = "#D4D0C8";
                ctd.style.borderWidth = 0;

                this.FormButton(ctd, -1, divId, divCl, this.Grid.HeaderHeight,
                    this.Grid.ControlColumnWidth, this.Grid.Name + "_HEADERIMG_",
                    imgSrc, this.Grid.IndicatorStyle)
        }

        for(var i = 0; i < this.Grid.ColumnCount; i ++) {
                if(!this.Grid.IsVisibleColumn(i)) continue;

                var td = document.createElement("TD");;
                panel.appendChild(td);
                td.width = this.Grid.GetColumnWidth(i);
//                td.height = this.Grid.HeaderHeight;
                td.align = this.Grid.Columns[i].HAlignment;
                td.valign = "center";//this.Grid.Columns[i].VAlignment;
                td.style.borderWidth = 0;

                var Id = this.Grid.Name + "_Header_" + i;
                var AHint = this.Grid.Columns[i].ShowHeaderHint ? this.Grid.Columns[i].HeaderHint : "";
                var Handler = dxGrid.Inf.ie ? "OnHMDown" : null;
                var fieldIndex = this.Grid.Columns[i].FieldIndex;
                var sortingOrder = this.DataController.GetItemSortOrder(fieldIndex);
                var ImgId = this.Grid.Name + scxSortImgID + i;

                this.FormHeaderNode(td, this.Grid.HeaderHeight, this.Grid.GetColumnWidth(i),
                    Id, AHint, Handler, ImgId, GridSortingImages[sortingOrder], i);
        }
  }
  this.SetStatusPanelText = function() {
        var panel = this.Grid.GetStatusPanelText();
        if(Exists(panel)) {
                var BeginRow = eval(this.Grid.FirstVisibleRow + 1);
                var EndRow = (eval(this.Grid.FirstVisibleRow + this.Grid.PageSize) < this.DataController.RowCount) ? eval(this.Grid.FirstVisibleRow + this.Grid.PageSize) : this.DataController.RowCount;
                if(this.DataController.RowCount == 0)
                        panel.innerHTML = scxStatusBarEmptyGridText;
                else {
                	var panelText = scxStatusBarText.split('%d');
                	panel.innerHTML = panelText[0] + BeginRow + panelText[1] + EndRow + panelText[2] + this.DataController.RowCount + panelText[3];
                }
        }
  }
}

function dx_GridGroupPanelCell(ABuilder)
{
  this.Builder = ABuilder;
  this.Width = 0;
  this.Height = 0;
  this.BorderBottomWidth = 0;
  this.BorderLeftWidth = 0;
  this.BorderRightWidth = 0;
  this.BorderTopWidth = 0;
  this.ColSpan = 1;
  this.RowSpan = 1;
  this.Index = -1;
  this.Invalide = false;
  this.Text = "";

  this.BuildCell = function(parentElement) {
        if(this.Invalide) return;

        var td = document.createElement("TD");
        parentElement.appendChild(td);
        td.width = Math.floor(this.Width);
        td.height = Math.floor(this.Height);
        td.style.borderBottomWidth = this.BorderBottomWidth;
        td.style.borderLeftWidth = this.BorderLeftWidth;
        td.style.borderRightWidth = this.BorderRightWidth;
        td.style.borderTopWidth = this.BorderTopWidth = 0;
        td.colSpan = this.ColSpan;
        td.rowSpan = this.RowSpan;
        if(this.Text != "") td.innerHTML = this.Text;

        if(this.Index != -1) {
                var ItemIndex = this.Builder.DataController.GetGroupingItemIndex(this.Index);
                var columnIndex = this.Builder.Grid.GetColumnIndexByFieldIndex(ItemIndex);
                var Id = this.Builder.Grid.Name + '_GHeader_' + columnIndex;
                var sortingOrder = this.Builder.DataController.GetItemSortOrder(ItemIndex);
                var ImgId = this.Builder.Grid.Name + scxSortImgID + columnIndex;
                var Handler = dxGrid.Inf.ie ? "OnGHMDown" : null;
                this.Builder.GridPainter.FormHeaderNode(td, this.Builder.Grid.HeaderHeight,
                    WebGridGroupPanelNodeWidth, Id, "", Handler, ImgId,
                    GridSortingImages[sortingOrder], columnIndex);
        }
  }
}

function dx_GridGroupPanelBuilder(AGridPainter)
{
  this.GridPainter = AGridPainter;
  this.Grid = this.GridPainter.Grid;
  this.DataControl = this.GridPainter.DataControl;
  this.DataController = this.GridPainter.DataController;

  this.ItemCount = 0;
  this.RowCount = 0;
  this.ColCount = 0;
  this.Cells = [];

  this.Initialize = function() {
        this.ItemCount = this.DataController.GetGroupingItemCount();
        this.RowCount = 1 + (this.ItemCount + 1) * 4 / 2 + 1;
        this.ColCount = 3 * this.ItemCount + 1;
        this.Cells = new Array(this.RowCount);

        for(var i = 0; i < this.RowCount; i ++) {
                this.Cells[i] = new Array(this.ColCount);
                for(var j = 0; j < this.ColCount; j ++) this.Cells[i][j] = new dx_GridGroupPanelCell(this);
        }
  }
  this.BuildTable = function(parentElement) {
        for(var i = 0; i < this.RowCount; i ++) {
                for(var j = 0; j < this.ColCount; j ++) {
                        if(this.Cells[i][j].Invalide) continue;

                        var HIndex = Math.floor(j / 3);
                        var VIndex = Math.floor((i - 1) / 2);

                        if((i == 0) || (i == this.RowCount - 1))
                                this.Cells[i][j].Height = WebGridGroupPanelInterval;
                        else
                                this.Cells[i][j].Height = this.Grid.HeaderHeight / 4;
                        if(j % 3 == 0) {
                                this.Cells[i][j].Width = WebGridGroupPanelInterval;
                        } else {
                                if((HIndex == VIndex) && ((j - 1) % 3 == 0) && ((i - 1) % 2 == 0)) {
                                        this.Cells[i][j].Height = this.Grid.HeaderHeight;
                                        this.Cells[i][j].Width = WebGridGroupPanelNodeWidth;
                                        this.Cells[i][j].ColSpan = 2;
                                        this.Cells[i][j].RowSpan = 4;
                                        this.Cells[i + 1][j].Invalide = true;
                                        this.Cells[i + 2][j].Invalide = true;
                                        this.Cells[i + 3][j].Invalide = true;
                                        this.Cells[i][j + 1].Invalide = true;
                                        this.Cells[i + 1][j + 1].Invalide = true;
                                        this.Cells[i + 2][j + 1].Invalide = true;
                                        this.Cells[i + 3][j + 1].Invalide = true;
                                        this.Cells[i][j].Index = HIndex;
                                        if(HIndex != this.ItemCount - 1) {
                                                this.Cells[i + 4][j + 1].BorderLeftWidth = 1;
                                                this.Cells[i + 4][j + 1].BorderBottomWidth = 1;
                                                this.Cells[i + 4][j + 2].BorderBottomWidth = 1;
                                                this.Cells[i + 4][j + 1].Text = '<IMG src="' + InvisibleImage + '">';
                                                this.Cells[i + 4][j + 2].Text = '<IMG src="' + InvisibleImage + '">';
                                        }
                                } else
                                        this.Cells[i][j].Width = WebGridGroupPanelNodeWidth / 2;
                        }
                }
        }
        for(var i = 0; i < this.RowCount; i ++) {
                this.Cells[i][this.ColCount - 1].Width = this.Grid.Width;
                for(var j = 0; j < this.ColCount - 1; j ++)
                        this.Cells[i][this.ColCount - 1].Width -= (this.Cells[i][j].Width + WebGridGroupPanelInterval);
        }
        for(var i = 0; i < this.RowCount; i ++) {
                var tr = document.createElement("TR");
                parentElement.appendChild(tr);
                for(var j = 0; j < this.ColCount; j ++) this.Cells[i][j].BuildCell(tr);
        }
  }
  this.Initialize();
}

function dx_GridPainterNS6(AGrid)
{
  this.inherit = dx_GridPainter;
  this.inherit(AGrid);
  this.SetColor = function(aNode, aColor) {
        if(typeof(aNode.tagName) == "undefined") return;
        if(!(aNode.tagName == "INPUT" ||
             aNode.tagName == "SELECT" ||
             aNode.tagName == "TABLE"))
                aNode.style.color = aColor;
        for(var i = 0; i < aNode.childNodes.length; i ++)
                this.SetColor(aNode.childNodes[i], aColor); 
  }
  this.SetBgColor = function(aNode, aColor) {
        if(typeof(aNode.tagName) == "undefined") return;
        if(!(aNode.tagName == "INPUT" ||
             aNode.tagName == "SELECT" ||
             aNode.tagName == "TABLE"))
                aNode.style.backgroundColor = aColor;
        for(var i = 0; i < aNode.childNodes.length; i ++)
                this.SetBgColor(aNode.childNodes[i], aColor);
  }
  this.DeselectNode = function(oldNode) {
        if(!Exists(oldNode)) return;
        for(var i = 0; i < oldNode.cells.length; i ++) {
                var oldtd = oldNode.cells[i];
                if(!oldtd || !oldtd.id || (oldtd.id.indexOf(scxCellID) == -1)) continue;
                this.SetColor(oldtd, this.Grid.SavedForeColors[i]);
                this.SetBgColor(oldtd, this.Grid.SavedBackColors[i])
        }
  }
  this.SelectNode = function(newNode) {
        if(!Exists(newNode)) return;
        for(var i = 0; i < newNode.cells.length; i ++) {
                var td = newNode.cells[i];
                if(!td || !td.id || (td.id.indexOf(scxCellID) == -1)) continue;
                this.Grid.SavedForeColors[i] = td.style.color;
                this.Grid.SavedBackColors[i] = td.style.backgroundColor;
                this.SetColor(td, this.Grid.SelectedForeColor);
                this.SetBgColor(td, this.Grid.SelectedBackColor)
        }
  }
}

function dx_GridPainterNS4(AGrid)
{
  this.inherit = dx_GridPainter;
  this.inherit(AGrid);
  this.Update = function() {
        if(!Exists(this.DataController)) return;
        this.RestoreSelection();
        this.SetSelection();
  }
  this.RestoreSelection = function() {
        if(!this.Grid.EditMode()) {
                this.SetLeftButtonImage(this.Grid.SavedFocusedRow, GridButtonsImages[0]);
        }
        this.Grid.SavedFocusedRow = this.Grid.FocusedRow();
  }
  this.SetSelection = function() {
        this.SetLeftButtonImage(this.Grid.FocusedRow(), GridButtonsImages[5]);
  }
}

function dx_GridPainterOpera(AGrid)
{
  this.inherit = dx_GridPainter;
  this.inherit(AGrid);
  this.Update = function() {
        if(!Exists(this.DataController)) return;
        this.RestoreSelection();
        this.SetSelection();
  }
  this.RestoreSelection = function() {
        if(!this.Grid.EditMode()) {
                this.SetLeftButtonImage(this.Grid.SavedFocusedRow, GridButtonsImages[0]);
        }
        this.Grid.SavedFocusedRow = this.Grid.FocusedRow();
  }
  this.SetSelection = function() {
        this.SetLeftButtonImage(this.Grid.FocusedRow(), GridButtonsImages[5]);
  }
}

