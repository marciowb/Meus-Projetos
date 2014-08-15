object BDEThreadData: TBDEThreadData
  OldCreateOrder = False
  Height = 480
  Width = 696
  object Items_BDE: TTable
    AutoCalcFields = False
    CachedUpdates = True
    OnCalcFields = Items_BDECalcFields
    DatabaseName = 'DBDEMOS'
    SessionName = 'Session1_5'
    IndexFieldNames = 'OrderNo'
    MasterFields = 'OrderNo'
    TableName = 'ITEMS'
    Left = 187
    Top = 149
    object Items_BDEItemNo: TFloatField
      FieldName = 'ItemNo'
      Visible = False
    end
    object Items_BDEOrderNo: TFloatField
      FieldName = 'OrderNo'
      Visible = False
    end
    object Items_BDEPartNo: TFloatField
      FieldName = 'PartNo'
    end
    object Items_BDEDescription: TStringField
      DisplayWidth = 28
      FieldKind = fkLookup
      FieldName = 'Description'
      LookupDataSet = Parts
      LookupKeyFields = 'PartNo'
      LookupResultField = 'Description'
      KeyFields = 'PartNo'
      ReadOnly = True
      Size = 30
      Lookup = True
    end
    object Items_BDESellPrice: TCurrencyField
      DisplayWidth = 9
      FieldKind = fkLookup
      FieldName = 'SellPrice'
      LookupDataSet = Parts
      LookupKeyFields = 'PartNo'
      LookupResultField = 'ListPrice'
      KeyFields = 'PartNo'
      Lookup = True
    end
    object Items_BDEQty: TIntegerField
      DisplayWidth = 5
      FieldName = 'Qty'
    end
    object Items_BDEDiscount: TFloatField
      DisplayWidth = 7
      FieldName = 'Discount'
      DisplayFormat = '0.00%'
      MaxValue = 100.000000000000000000
    end
    object Items_BDEExtPrice: TCurrencyField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ExtPrice'
      Calculated = True
    end
    object Items_BDEDiscountPc: TFloatField
      FieldKind = fkCalculated
      FieldName = 'DiscountPc'
      Calculated = True
    end
  end
  object Cust_BDE: TTable
    AutoCalcFields = False
    CachedUpdates = True
    DatabaseName = 'DBDEMOS'
    Filter = 'CustNo<1352'
    SessionName = 'Session1_5'
    TableName = 'CUSTOMER'
    Left = 52
    Top = 149
    object Cust_BDECustNo: TFloatField
      Alignment = taLeftJustify
      DisplayWidth = 6
      FieldName = 'CustNo'
    end
    object Cust_BDECompany: TStringField
      DisplayWidth = 26
      FieldName = 'Company'
      Required = True
      Size = 30
    end
    object Cust_BDEPhone: TStringField
      DisplayWidth = 15
      FieldName = 'Phone'
      Size = 15
    end
    object Cust_BDELastInvoiceDate: TDateTimeField
      DisplayLabel = 'LastInvoice'
      DisplayWidth = 10
      FieldName = 'LastInvoiceDate'
      DisplayFormat = 'DDDDD'
    end
    object Cust_BDEAddr1: TStringField
      FieldName = 'Addr1'
      Size = 30
    end
    object Cust_BDEAddr2: TStringField
      FieldName = 'Addr2'
      Size = 30
    end
    object Cust_BDECity: TStringField
      FieldName = 'City'
      Size = 15
    end
    object Cust_BDEState: TStringField
      FieldName = 'State'
    end
    object Cust_BDEZip: TStringField
      FieldName = 'Zip'
      Size = 10
    end
    object Cust_BDECountry: TStringField
      FieldName = 'Country'
    end
    object Cust_BDEFAX: TStringField
      FieldName = 'FAX'
      Size = 15
    end
    object Cust_BDETaxRate: TFloatField
      FieldName = 'TaxRate'
    end
    object Cust_BDEContact: TStringField
      FieldName = 'Contact'
    end
    object Cust_BDETotAddr1: TStringField
      DisplayWidth = 128
      FieldKind = fkCalculated
      FieldName = 'TotAddr1'
      Size = 128
      Calculated = True
    end
    object Cust_BDETotAddr2: TStringField
      FieldKind = fkCalculated
      FieldName = 'TotAddr2'
      Size = 128
      Calculated = True
    end
  end
  object Orders_BDE: TTable
    AutoCalcFields = False
    DatabaseName = 'DBDEMOS'
    SessionName = 'Session1_5'
    IndexName = 'CustNo'
    MasterFields = 'CUSTNO'
    ReadOnly = True
    TableName = 'ORDERS'
    Left = 119
    Top = 149
    object Orders_BDEOrderNo: TFloatField
      Alignment = taLeftJustify
      DisplayWidth = 10
      FieldName = 'OrderNo'
    end
    object Orders_BDECustNo: TFloatField
      FieldName = 'CustNo'
      Visible = False
    end
    object Orders_BDESaleDate: TDateTimeField
      DisplayWidth = 9
      FieldName = 'SaleDate'
      DisplayFormat = 'DDDDD'
    end
    object Orders_BDEShipDate: TDateTimeField
      DisplayWidth = 9
      FieldName = 'ShipDate'
      DisplayFormat = 'DDDDD'
    end
    object Orders_BDEItemsTotal: TCurrencyField
      FieldName = 'ItemsTotal'
      Visible = False
    end
    object Orders_BDETaxRate: TFloatField
      FieldName = 'TaxRate'
      Visible = False
    end
    object Orders_BDEFreight: TCurrencyField
      FieldName = 'Freight'
      Visible = False
    end
    object Orders_BDEAmountPaid: TCurrencyField
      DisplayWidth = 14
      FieldName = 'AmountPaid'
    end
    object Orders_BDEAmountDue: TCurrencyField
      DisplayWidth = 14
      FieldKind = fkCalculated
      FieldName = 'AmountDue'
      Calculated = True
    end
    object Orders_BDEEmpNo: TIntegerField
      FieldName = 'EmpNo'
      Required = True
    end
    object Orders_BDEShipToContact: TStringField
      FieldName = 'ShipToContact'
    end
    object Orders_BDEShipToAddr1: TStringField
      FieldName = 'ShipToAddr1'
      Size = 30
    end
    object Orders_BDEShipToAddr2: TStringField
      FieldName = 'ShipToAddr2'
      Size = 30
    end
    object Orders_BDEShipToCity: TStringField
      FieldName = 'ShipToCity'
      Size = 15
    end
    object Orders_BDEShipToState: TStringField
      FieldName = 'ShipToState'
    end
    object Orders_BDEShipToZip: TStringField
      FieldName = 'ShipToZip'
      Size = 10
    end
    object Orders_BDEShipToCountry: TStringField
      FieldName = 'ShipToCountry'
    end
    object Orders_BDEShipToPhone: TStringField
      FieldName = 'ShipToPhone'
      Size = 15
    end
    object Orders_BDESalesPerson: TStringField
      FieldKind = fkLookup
      FieldName = 'SalesPerson'
      LookupDataSet = Emps
      LookupKeyFields = 'EmpNo'
      LookupResultField = 'FullName'
      KeyFields = 'EmpNo'
      Size = 40
      Lookup = True
    end
    object Orders_BDEShipVIA: TStringField
      FieldName = 'ShipVIA'
      Size = 7
    end
    object Orders_BDEPO: TStringField
      FieldName = 'PO'
      Size = 15
    end
    object Orders_BDETerms: TStringField
      FieldName = 'Terms'
      Size = 6
    end
    object Orders_BDEPaymentMethod: TStringField
      FieldName = 'PaymentMethod'
      Size = 7
    end
  end
  object Emps: TTable
    AutoCalcFields = False
    DatabaseName = 'DBDEMOS'
    SessionName = 'Session1_5'
    IndexFieldNames = 'EmpNo'
    ReadOnly = True
    TableName = 'EMPLOYEE'
    Left = 261
    Top = 149
    object EmpsEmpNo: TIntegerField
      FieldName = 'EmpNo'
    end
    object EmpsFullName: TStringField
      FieldKind = fkCalculated
      FieldName = 'FullName'
      Calculated = True
    end
    object EmpsLastName: TStringField
      FieldName = 'LastName'
    end
    object EmpsFirstName: TStringField
      FieldName = 'FirstName'
      Size = 15
    end
    object EmpsPhoneExt: TStringField
      FieldName = 'PhoneExt'
      Size = 4
    end
    object EmpsHireDate: TDateTimeField
      FieldName = 'HireDate'
    end
    object EmpsSalary: TFloatField
      FieldName = 'Salary'
    end
  end
  object Parts: TTable
    AutoCalcFields = False
    CachedUpdates = True
    DatabaseName = 'DBDEMOS'
    SessionName = 'Session1_5'
    TableName = 'PARTS'
    Left = 313
    Top = 149
    object PartsPartNo: TFloatField
      Alignment = taLeftJustify
      DisplayWidth = 8
      FieldName = 'PartNo'
      Required = True
    end
    object PartsDescription: TStringField
      DisplayWidth = 21
      FieldName = 'Description'
      Required = True
      Size = 30
    end
    object PartsVendorNo: TFloatField
      DisplayWidth = 9
      FieldName = 'VendorNo'
    end
    object PartsOnHand: TFloatField
      DisplayWidth = 9
      FieldName = 'OnHand'
    end
    object PartsOnOrder: TFloatField
      DisplayWidth = 10
      FieldName = 'OnOrder'
    end
    object PartsBackOrd: TBooleanField
      DisplayWidth = 9
      FieldKind = fkCalculated
      FieldName = 'BackOrd'
      DisplayValues = 'Yes;No'
      Calculated = True
    end
    object PartsCost: TCurrencyField
      DisplayWidth = 12
      FieldName = 'Cost'
    end
    object PartsListPrice: TCurrencyField
      DisplayWidth = 12
      FieldName = 'ListPrice'
    end
  end
  object Session1: TSession
    AutoSessionName = True
    Left = 32
    Top = 104
  end
end
