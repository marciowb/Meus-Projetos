{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{          Messages form - EMessages             }
{                                                }
{  Copyright (c) 2001 - 2008 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EMessages;

{$I Exceptions.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExceptionLog, ExtCtrls;

type
  TMessageForm = class(TForm)
    OK: TBitBtn;
    Cancel: TBitBtn;
    ExceptionsFiltersPanel: TPanel;
    Shape14: TShape;
    Panel17: TPanel;
    Image10: TImage;
    Label1: TLabel;
    ExceptionMessageLabel: TLabel;
    DialogTypeLabel: TLabel;
    Label4: TLabel;
    ActionTypeLabel: TLabel;
    ExceptionTypeLabel: TLabel;
    MessageHelpLabel: TLabel;
    ExceptionMessageText: TMemo;
    ExceptionClassEdit: TComboBox;
    DialogTypeCmb: TComboBox;
    HandlerTypeCmb: TComboBox;
    ActionTypeCmb: TComboBox;
    ExceptionTypeCmb: TComboBox;
    procedure ExceptionTypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HandlerTypeCmbChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MessageForm: TMessageForm;

implementation

{$R *.DFM}

uses EConsts, ECore, EDesign, EOption;

procedure TMessageForm.ExceptionTypeChange(Sender: TObject);
begin
  OK.Enabled := (ExceptionClassEdit.Text <> '');
end;

procedure TMessageForm.FormCreate(Sender: TObject);
var
  Tn: TFilterExceptionType;
  Dn: TFilterDialogType;
  Hn: TFilterHandlerType;
  An: TFilterActionType;
begin
  OK.Caption := EOK;
  Cancel.Caption := ECancel;

  ExceptionTypeCmb.Clear;
  for Tn := low(TypeValues) to high(TypeValues) do
    ExceptionTypeCmb.Items.Add(TypeValues[Tn]);
  ExceptionTypeCmb.ItemIndex := 2;

  DialogTypeCmb.Clear;
  for Dn := low(DialogValues) to high(DialogValues) do
    DialogTypeCmb.Items.Add(DialogValues[Dn]);
  DialogTypeCmb.ItemIndex := 3;

  HandlerTypeCmb.Clear;
  for Hn := low(HandleValues) to high(HandleValues) do
    HandlerTypeCmb.Items.Add(HandleValues[Hn]);
  HandlerTypeCmb.ItemIndex := 2;

  ActionTypeCmb.Clear;
  for An := low(ActionValues) to high(ActionValues) do
    ActionTypeCmb.Items.Add(ActionValues[An]);
  ActionTypeCmb.ItemIndex := 0;

{$IFDEF BUILD_FOR_DOTNET}
  ExceptionClassEdit.Items.Text :=
    'System.Exception' + #13#10 +
    'System.AppDomainUnloadedException' + #13#10 +
    'System.ArgumentException' + #13#10 +
    'System.ArithmeticException' + #13#10 +
    'System.ArrayTypeMismatchException' + #13#10 +
    'System.BadImageFormatException' + #13#10 +
    'System.CannotUnloadAppDomainException' + #13#10 + 
    'System.ComponentModel.LicenseException' + #13#10 + 
    'System.ComponentModel.WarningException' + #13#10 + 
    'System.Configuration.ConfigurationException' + #13#10 + 
    'System.ContextMarshalException' + #13#10 + 
    'System.Data.DataException' + #13#10 + 
    'System.Data.DBConcurrencyException' + #13#10 + 
    'System.Data.Odbc.OdbcException' + #13#10 + 
    'System.Data.SqlClient._ValueException' + #13#10 + 
    'System.Data.SqlClient.SqlException' + #13#10 + 
    'System.Data.SqlTypes.SqlTypeException' + #13#10 + 
    'System.Drawing.Printing.InvalidPrinterException' + #13#10 + 
    'System.ExecutionEngineException' + #13#10 + 
    'System.FormatException' + #13#10 + 
    'System.IndexOutOfRangeException' + #13#10 + 
    'System.InvalidCastException' + #13#10 + 
    'System.InvalidOperationException' + #13#10 + 
    'System.InvalidProgramException' + #13#10 + 
    'System.IO.InternalBufferOverflowException' + #13#10 + 
    'System.IO.IOException' + #13#10 + 
    'System.MemberAccessException' + #13#10 + 
    'System.MulticastNotSupportedException' + #13#10 + 
    'System.NotImplementedException' + #13#10 + 
    'System.NotSupportedException' + #13#10 +
    'System.NullReferenceException' + #13#10 + 
    'System.OutOfMemoryException' + #13#10 + 
    'System.RankException' + #13#10 + 
    'System.Reflection.AmbiguousMatchException' + #13#10 + 
    'System.Reflection.ReflectionTypeLoadException' + #13#10 +
    'System.Resources.MissingManifestResourceException' + #13#10 + 
    'System.Runtime.InteropServices.ExternalException' + #13#10 + 
    'System.Runtime.InteropServices.InvalidComObjectException' + #13#10 + 
    'System.Runtime.InteropServices.InvalidOleVariantTypeException' + #13#10 + 
    'System.Runtime.InteropServices.MarshalDirectiveException' + #13#10 + 
    'System.Runtime.InteropServices.SafeArrayRankMismatchException' + #13#10 + 
    'System.Runtime.InteropServices.SafeArrayTypeMismatchException' + #13#10 + 
    'System.Runtime.Remoting.RemotingException' + #13#10 + 
    'System.Runtime.Remoting.ServerException' + #13#10 + 
    'System.Runtime.Serialization.SerializationException' + #13#10 + 
    'System.Security.Cryptography.CryptographicException' + #13#10 + 
    'System.Security.Policy.PolicyException' + #13#10 + 
    'System.Security.SecurityException' + #13#10 + 
    'System.Security.VerificationException' + #13#10 + 
    'System.Security.XmlSyntaxException' + #13#10 + 
    'System.StackOverflowException' + #13#10 + 
    'System.Threading.SynchronizationLockException' + #13#10 + 
    'System.Threading.ThreadAbortException' + #13#10 + 
    'System.Threading.ThreadInterruptedException' + #13#10 + 
    'System.Threading.ThreadStateException' + #13#10 + 
    'System.Threading.ThreadStopException' + #13#10 + 
    'System.TypeInitializationException' + #13#10 + 
    'System.TypeLoadException' + #13#10 + 
    'System.TypeUnloadedException' + #13#10 + 
    'System.UnauthorizedAccessException' + #13#10 + 
    'System.Xml.Schema.XmlSchemaException' + #13#10 + 
    'System.Xml.XmlException' + #13#10 + 
    'System.Xml.XPath.XPathException' + #13#10 + 
    'System.Xml.Xsl.XsltException';
  ExceptionTypeLabel.Visible := False;
  ExceptionTypeCmb.Visible := False;
  ExceptionMessageLabel.Top := ExceptionTypeLabel.Top;
  MessageHelpLabel.Top := ExceptionMessageLabel.Top;
  ExceptionMessageText.Height := (ExceptionMessageText.Height +
    ExceptionMessageText.Top - ExceptionTypeCmb.Top);
  ExceptionMessageText.Top := ExceptionTypeCmb.Top;
{$ENDIF}

  AdjustFontLanguage(Self);
end;

procedure TMessageForm.FormShow(Sender: TObject);
begin
  OK.Enabled := (ExceptionClassEdit.Text <> '');
  HandlerTypeCmbChange(nil);  
end;

procedure TMessageForm.HandlerTypeCmbChange(Sender: TObject);
var
  State: Boolean;
begin
  State := (HandlerTypeCmb.Text = 'EurekaLog');
  ExceptionMessageLabel.Enabled := State;
  MessageHelpLabel.Enabled := State;
  ExceptionMessageText.Enabled := State;
  ExceptionTypeLabel.Enabled := State;  
  ExceptionTypeCmb.Enabled := State;
  DialogTypeLabel.Enabled := State;
  DialogTypeCmb.Enabled := State;
  ActionTypeLabel.Enabled := State;
  ActionTypeCmb.Enabled := State;
end;

end.