object ThreadData: TThreadData
  OldCreateOrder = False
  Height = 480
  Width = 696
  object FlxRep: TFlexCelReport
    Template = 'Threads.template.xls'
    AutoClose = False
    Adapter = XLSAdapter
    DateTimeFormat = 'mm/dd/yyyy hh:mm'
    KeepEmptyPictures = False
    DataModule = Owner
    CalcRecordCount = cr_None
    Left = 40
    Top = 24
  end
  object XLSAdapter: TXLSAdapter
    AllowOverwritingFiles = False
    Left = 120
    Top = 24
  end
  object Items: TFlxMemTable
    Columns = <
      item
        Name = 'PartNo'
      end
      item
        Name = 'OrderNo'
      end
      item
        Name = 'Description'
      end
      item
        Name = 'Qty'
      end
      item
        Name = 'SellPrice'
      end
      item
        Name = 'DiscountPc'
      end
      item
        Name = 'ExtPrice'
      end>
    MasterTable = Orders
    MasterField = 'OrderNo'
    Left = 144
    Top = 96
  end
  object Cust: TFlxMemTable
    Columns = <
      item
        Name = 'CustNo'
      end
      item
        Name = 'Addr1'
      end
      item
        Name = 'Addr2'
      end
      item
        Name = 'City'
      end
      item
        Name = 'State'
      end
      item
        Name = 'Zip'
      end
      item
        Name = 'Country'
      end
      item
        Name = 'Company'
      end>
    Left = 48
    Top = 96
  end
  object Orders: TFlxMemTable
    Columns = <
      item
        Name = 'OrderNo'
      end
      item
        Name = 'CustNo'
      end
      item
        Name = 'SalesPerson'
      end
      item
        Name = 'SaleDate'
      end
      item
        Name = 'ShipDate'
      end
      item
        Name = 'ShipVia'
      end
      item
        Name = 'Freight'
      end>
    MasterTable = Cust
    MasterField = 'CustNo'
    Left = 96
    Top = 96
  end
end
