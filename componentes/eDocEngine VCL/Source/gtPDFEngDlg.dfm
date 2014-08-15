inherited gtPDFEngineDlg: TgtPDFEngineDlg
  Caption = 'gtPDFEngineDlg'
  ClientWidth = 492
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inherited btnOK: TButton
    Left = 326
  end
  inherited btnCancel: TButton
    Left = 408
  end
  inherited pnlDocDlg: TPanel
    Width = 475
    inherited Panel2: TPanel
      Width = 350
      inherited Panel3: TPanel
        Width = 350
      end
      inherited pcDocument: TPageControl
        Width = 350
        inherited tsPreferences: TTabSheet
          inherited gbPreferences: TGroupBox
            Width = 329
            inherited gbPageRange: TGroupBox
              Width = 313
            end
            object rgpEmbedTrueTypeFonts: TRadioGroup
              Left = 8
              Top = 168
              Width = 310
              Height = 41
              Caption = 'Embed Used TrueType Fonts'
              Columns = 3
              Items.Strings = (
                'None'
                'Full'
                'Subset')
              TabOrder = 4
            end
          end
        end
        inherited tsContent: TTabSheet
          inherited gbContentOptions: TGroupBox
            Width = 329
            inherited gbItemsToRender: TGroupBox
              Width = 313
            end
            inherited gbDocInfo: TGroupBox
              Width = 313
            end
          end
        end
        inherited tsBackground: TTabSheet
          inherited gbBackground: TGroupBox
            Width = 329
          end
        end
        object tsPDFAdvanced: TTabSheet [3]
          Caption = 'Advanced'
          ImageIndex = 3
          TabVisible = False
          object gbPDFOptions: TGroupBox
            Left = 8
            Top = 0
            Width = 329
            Height = 372
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            object lblFontEncoding: TLabel
              Left = 8
              Top = 327
              Width = 84
              Height = 13
              Caption = 'Font Encoding:'
            end
            object gbEncryption: TGroupBox
              Left = 8
              Top = 62
              Width = 313
              Height = 255
              TabOrder = 3
              object lblOwnerPassword: TLabel
                Left = 8
                Top = 20
                Width = 100
                Height = 13
                Caption = 'Owner Password:'
              end
              object lblConfirmOwnerPassword: TLabel
                Left = 8
                Top = 44
                Width = 150
                Height = 13
                Caption = 'Confirm Owner Password:'
              end
              object lblUserPassword: TLabel
                Left = 8
                Top = 68
                Width = 89
                Height = 13
                Caption = 'User Password:'
              end
              object lblConfirmUserPassword: TLabel
                Left = 8
                Top = 92
                Width = 139
                Height = 13
                Caption = 'Confirm User Password:'
              end
              object lblEncryptionLevel: TLabel
                Left = 8
                Top = 116
                Width = 35
                Height = 13
                Caption = 'Level:'
              end
              object edOwnerPassword: TEdit
                Left = 168
                Top = 16
                Width = 133
                Height = 21
                PasswordChar = '*'
                TabOrder = 0
              end
              object edConfirmOwnerPassword: TEdit
                Left = 168
                Top = 40
                Width = 133
                Height = 21
                PasswordChar = '*'
                TabOrder = 1
                OnExit = edConfirmPasswordExit
              end
              object gbUserPermissions: TGroupBox
                Left = 8
                Top = 136
                Width = 293
                Height = 113
                Caption = 'User Permissions'
                Enabled = False
                TabOrder = 5
                object chkPrint: TCheckBox
                  Left = 7
                  Top = 65
                  Width = 51
                  Height = 17
                  Caption = 'Print'
                  TabOrder = 2
                end
                object chkModify: TCheckBox
                  Left = 7
                  Top = 41
                  Width = 64
                  Height = 17
                  Caption = 'Modify'
                  TabOrder = 1
                end
                object chkCopy: TCheckBox
                  Left = 7
                  Top = 17
                  Width = 58
                  Height = 17
                  Caption = 'Copy'
                  TabOrder = 0
                end
                object chkAnnotation: TCheckBox
                  Left = 144
                  Top = 16
                  Width = 97
                  Height = 17
                  Caption = 'Annotation'
                  TabOrder = 4
                end
                object chkFormFill: TCheckBox
                  Left = 7
                  Top = 88
                  Width = 97
                  Height = 17
                  Caption = 'Form Fill'
                  TabOrder = 3
                end
                object chkAccessibility: TCheckBox
                  Left = 144
                  Top = 40
                  Width = 97
                  Height = 17
                  Caption = 'Accessibility'
                  TabOrder = 5
                end
                object chkDocumentAssembly: TCheckBox
                  Left = 144
                  Top = 64
                  Width = 145
                  Height = 17
                  Caption = 'Document Assembly'
                  TabOrder = 6
                end
                object chkHighResolutionPrint: TCheckBox
                  Left = 144
                  Top = 88
                  Width = 145
                  Height = 17
                  Caption = 'High Resolution Print'
                  TabOrder = 7
                end
              end
              object edUserPassword: TEdit
                Left = 168
                Top = 64
                Width = 133
                Height = 21
                PasswordChar = '*'
                TabOrder = 2
              end
              object edConfirmUserPassword: TEdit
                Left = 168
                Top = 88
                Width = 133
                Height = 21
                PasswordChar = '*'
                TabOrder = 3
				OnExit = edConfirmPasswordExit
              end
              object cbEncryptionLevel: TComboBox
                Left = 168
                Top = 112
                Width = 133
                Height = 21
                Style = csDropDownList
                ItemHeight = 0
                TabOrder = 4
                OnChange = cbEncryptionLevelChange
              end
            end
            object gbUseCompression: TGroupBox
              Left = 8
              Top = 8
              Width = 313
              Height = 47
              TabOrder = 1
              object lblCompressionLevel: TLabel
                Left = 8
                Top = 20
                Width = 114
                Height = 13
                Caption = 'Compression Level:'
              end
              object cbCompressionLevel: TComboBox
                Left = 168
                Top = 16
                Width = 133
                Height = 21
                Style = csDropDownList
                ItemHeight = 0
                TabOrder = 0
              end
            end
            object chkCompressDocument: TCheckBox
              Left = 15
              Top = 7
              Width = 146
              Height = 17
              Caption = 'Compress Document'
              Checked = True
              State = cbChecked
              TabOrder = 0
              OnClick = chkCompressDocumentClick
            end
            object cbEncoding: TComboBox
              Left = 168
              Top = 323
              Width = 133
              Height = 21
              Style = csDropDownList
              ItemHeight = 0
              TabOrder = 4
            end
            object chkEnableEncryption: TCheckBox
              Left = 16
              Top = 60
              Width = 137
              Height = 17
              Caption = 'Encrypt Document'
              TabOrder = 2
              OnClick = chkEnableEncryptionClick
            end
          end
        end
        object tsViewerPreferences: TTabSheet [4]
          Caption = 'Viewer Preferences'
          ImageIndex = 4
          TabVisible = False
          object gbViewerPreferences: TGroupBox
            Left = 8
            Top = 0
            Width = 329
            Height = 372
            TabOrder = 0
            object lblPageLayout: TLabel
              Left = 8
              Top = 16
              Width = 75
              Height = 13
              Caption = 'Page Layout:'
            end
            object lblPageMode: TLabel
              Left = 168
              Top = 16
              Width = 67
              Height = 13
              Caption = 'Page Mode:'
            end
            object cbPageLayout: TComboBox
              Left = 8
              Top = 32
              Width = 153
              Height = 21
              Style = csDropDownList
              ItemHeight = 0
              TabOrder = 0
            end
            object cbPageMode: TComboBox
              Left = 168
              Top = 32
              Width = 149
              Height = 21
              Style = csDropDownList
              ItemHeight = 0
              TabOrder = 1
            end
            object gbHideUIElements: TGroupBox
              Left = 8
              Top = 61
              Width = 309
              Height = 58
              Caption = 'Hide Viewer Interface Elements'
              TabOrder = 2
              object chkMenuBar: TCheckBox
                Left = 8
                Top = 16
                Width = 97
                Height = 17
                Caption = 'Menu Bar'
                TabOrder = 0
              end
              object chkToolBar: TCheckBox
                Left = 161
                Top = 16
                Width = 97
                Height = 17
                Caption = 'Toolbars'
                TabOrder = 1
              end
              object chkNavigationControls: TCheckBox
                Left = 8
                Top = 35
                Width = 145
                Height = 17
                Caption = 'Navigation Controls'
                TabOrder = 2
              end
            end
            object gbPresentationMode: TGroupBox
              Left = 8
              Top = 123
              Width = 309
              Height = 66
              Caption = 'Presentation Mode'
              TabOrder = 3
              object lblPageTransitionEffect: TLabel
                Left = 8
                Top = 16
                Width = 129
                Height = 13
                Caption = 'Page Transition Effect:'
              end
              object lblPageTransitionDuration: TLabel
                Left = 8
                Top = 41
                Width = 146
                Height = 13
                Caption = 'Page Transition Duration:'
              end
              object lblSecs: TLabel
                Left = 274
                Top = 45
                Width = 27
                Height = 13
                Caption = 'Secs'
              end
              object edPageTransitionDuration: TEdit
                Left = 160
                Top = 37
                Width = 109
                Height = 21
                TabOrder = 1
              end
              object cbPageTransitionEffect: TComboBox
                Left = 160
                Top = 12
                Width = 141
                Height = 21
                Style = csDropDownList
                ItemHeight = 0
                TabOrder = 0
                OnChange = cbPageTransitionEffectChange
              end
            end
          end
        end
        inherited tsEMailInfo: TTabSheet
          inherited gbEMailInfo: TGroupBox
            Width = 329
            inherited edHost: TEdit
              Width = 247
            end
            inherited edPort: TEdit
              Width = 247
            end
            inherited edFrom: TEdit
              Width = 247
            end
            inherited edTo: TEdit
              Width = 247
            end
            inherited edCC: TEdit
              Width = 247
            end
            inherited edBCC: TEdit
              Width = 247
            end
            inherited edEmailSubject: TEdit
              Width = 247
            end
            inherited memoBody: TMemo
              Width = 311
            end
            inherited gbAuthentication: TGroupBox
              Width = 312
              inherited edPassword: TEdit
                Width = 226
              end
              inherited edUserID: TEdit
                Width = 226
              end
            end
          end
        end
      end
    end
  end
end
