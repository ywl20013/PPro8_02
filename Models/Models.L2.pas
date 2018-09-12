unit Models.L2;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  System.Generics.Defaults,
  Vcl.StdCtrls,
  Data.Provider;

type
  {
    Register?symbol=ZVZZT.NQ&feedtype=L2 & output=[bykey|bytype

    SetOutput?symbol=<symbol.extension> & region=[1|2|3|4] & feedtype=[L1|TOS|L2|IMBALANCE|OSTAT|ORDEREVENT|PAPIORDER] & output=[bykey|bytype|<port>] & status=[on|off]

    API将接收代码ZVZZT.NQ的Level 2的所有报价更新。这些更新将被写入PPro8登录目录的文档，文档名为：L2_1_ZVZZT.NQ.log
    L2的数据必须包含代码这个参数。
    L2的数据，每个代码分别写入一个文档。
    每个Level 2的更新，是一个按逗号分隔的数据行，栏目包括：
    LocalTime=08:39:43.114 ← 代表数据到达本地电脑的时间，按本地电脑的时间显示
    MarketTime=08:39:42.601 ← 市场更新时间
    Mmid=ANON ← 代表本次更新的市场参与者代码MMID
    Side=B ← 代表更新的订单的方向
    Price=8.6 ← 代表更新的订单的价格
    Volume=100 ← 代表更新的订单的股数
    Depth=1 ← 代表订单的价位数
    SequenceNumber=27003 ← 这个序列号，是按每个市场参与者代码MMID、Price订单价格、和方向Side分配的，可以用来排除错乱的数据。

    每一次的更新，要么 (a) 创建一个新的价位，要么 (b) 对指定的市场参与者代码MMID, 方向Side和价格Price组合作出更新。

    举例：如果您当前有一个在ANON市场参与者代码中的400股，定价在每股8.6美元的买单，上面的例子将把ANON的8.6价位的买单股数调整到100股。

    Market Depth Snapshot市场深度截图
    当API在一个代码上注册Level 2的数据源的时候，它将首先获取一个截图。截图代表了这个代码目前的报价状态，并且将随着实时的更新消息不断更新。
    截图的数据从Side=s开始。举例：
    LocalTime=08:37:31.908,MarketTime=00:00:00.000,Mmid=,Side=s,Price=0,Volume=0,Depth=0,SequenceNumber=0
    所有截图的数据都显示SequenceNumber=0.
    截图的数据从Side=e结束，举例：
    LocalTime=08:37:31.908,MarketTime=00:00:00.000,Mmid=,Side=e,Price=0,Volume=0,Depth=0,SequenceNumber=0
  }
  /// <summary>
  /// Market Depth (L2)市场深度
  /// </summary>
  TL2Line = class
    private
      FMarketTime    : TDateTime;
      FPrice         : Double;
      FDepth         : Cardinal;
      FLocalTime     : TDateTime;
      FSide          : String;
      FVolume        : Cardinal;
      FSequenceNumber: Cardinal;
      FMmid          : string;
      FSymbol        : string;
      FMessage       : string;
      FRID           : String;
    public
      class function FromCSVString( source: string ): TL2Line;

      function ToCSVString( ): string;

      function SaveToDataBase( DataProvider: TDataProvider ): Boolean;

      function Clone( ): TL2Line;
    published
      /// <summary>
      /// 数据到达本地电脑的时间，按本地电脑的时间显示
      /// </summary>
      property Symbol: string read FSymbol write FSymbol;
      /// <summary>
      /// 数据到达本地电脑的时间，按本地电脑的时间显示
      /// </summary>
      property LocalTime: TDateTime read FLocalTime write FLocalTime;
      /// <summary>
      /// 数据到达本地电脑的时间，按本地电脑的时间显示
      /// </summary>
      property Message: string read FMessage write FMessage;
      /// <summary>
      /// 市场更新时间
      /// </summary>
      property MarketTime: TDateTime read FMarketTime write FMarketTime;
      /// <summary>
      /// 本次更新的市场参与者代码MMID
      /// </summary>
      property Mmid: string read FMmid write FMmid;
      /// <summary>
      /// 更新的订单的方向
      /// </summary>
      property Side: String read FSide write FSide;
      /// <summary>
      /// 更新的订单的价格
      /// </summary>
      property Price: Double read FPrice write FPrice;
      /// <summary>
      /// 更新的订单的股数
      /// </summary>
      property Volume: Cardinal read FVolume write FVolume;
      /// <summary>
      /// 订单的价位数
      /// </summary>
      property Depth: Cardinal read FDepth write FDepth;
      /// <summary>
      /// 序列号，是按每个市场参与者代码MMID、Price订单价格、和方向Side分配的，可以用来排除错乱的数据
      /// </summary>
      property SequenceNumber: Cardinal read FSequenceNumber
        write FSequenceNumber;

      /// <summary>
      /// 本次UDP接收的唯一ID
      /// </summary>
      property RID: String read FRID write FRID;
  end;

  TL2Levels = class
    private
      Data: array of TL2Line;
      function FindIndex( Mmid: string; Price: Double ): Integer;
      function Find( Mmid: string; Price: Double ): TL2Line;
      function Add( item: TL2Line ): Word;

      function Remove( index: Integer ): Boolean;
      function Sort( ): TL2Levels;

    public
      constructor Create( );
      destructor Destroy; override;

      function Parse( source: string ): Boolean; overload;
      function Parse( source: TL2Line ): Boolean; overload;
      procedure RenderToListBox( listBox: TListBox; const renderZeroVolumn: Boolean = false );

      function GetValue( Level: Integer ): TL2Line;
  end;

implementation

uses
  Helper.TDateTime;

{ TL2Line }

function TL2Line.Clone( ): TL2Line;
begin
  Result                 := TL2Line.Create;
  Result.FMarketTime     := self.FMarketTime;
  Result.FPrice          := self.FPrice;
  Result.FDepth          := self.FDepth;
  Result.FLocalTime      := self.FLocalTime;
  Result.FSide           := self.FSide;
  Result.FVolume         := self.FVolume;
  Result.FSequenceNumber := self.SequenceNumber;
  Result.FMmid           := self.FMmid;
  Result.FSymbol         := self.FSymbol;
  Result.FMessage        := self.FMessage;
  Result.FRID            := self.FRID;
end;

class function TL2Line.FromCSVString( source: string ): TL2Line;
var
  dtNow            : TDateTime;
  pair, name, value: string;
  strs, strs2      : TArray< string >;
begin
  dtNow  := TDateTime.Now;
  strs   := source.Split( [ ',' ] );
  Result := self.Create;
  for pair in strs do
  begin
    strs2 := pair.Split( [ '=' ] );
    if ( Length( strs2 ) = 2 ) then
    begin
      name  := strs2[ 0 ];
      value := strs2[ 1 ];
      if LowerCase( name ) = LowerCase( 'Symbol' ) then
      begin
        Result.FSymbol := value;
      end
      else if LowerCase( name ) = LowerCase( 'Message' ) then
      begin
        Result.FMessage := value;
      end
      else if LowerCase( name ) = LowerCase( 'LocalTime' ) then
      begin
        Result.FLocalTime := TDateTime.Create( value ).ReplaceDate( dtNow );
      end
      else if LowerCase( name ) = LowerCase( 'MarketTime' ) then
      begin
        Result.FMarketTime := TDateTime.Create( value ).ReplaceDate( dtNow );
      end
      else if LowerCase( name ) = LowerCase( 'Mmid' ) then
      begin
        Result.FMmid := value;
      end
      else if LowerCase( name ) = LowerCase( 'Side' ) then
      begin
        Result.FSide := value;
      end
      else if LowerCase( name ) = LowerCase( 'Price' ) then
      begin
        Result.FPrice := value.ToDouble( );
      end
      else if LowerCase( name ) = LowerCase( 'Volume' ) then
      begin
        Result.FVolume := value.ToInteger( );
      end
      else if LowerCase( name ) = LowerCase( 'Depth' ) then
      begin
        Result.FDepth := value.ToInteger( );
      end
      else if LowerCase( name ) = LowerCase( 'SequenceNumber' ) then
      begin
        Result.FSequenceNumber := value.Replace( #13#10, '' ).Replace( #13, '' ).Replace( #10, '' ).ToInteger( );
      end

    end;
  end;

end;

function TL2Line.SaveToDataBase( DataProvider: TDataProvider ): Boolean;
begin
  Result := DataProvider.ExecuteSql( 'insert into L2Lines(RID,SYMBOL,LOCALTIME,MESSAGE,MARKETTIME,MMID,SIDE,PRICE,VOLUME,DEPTH,SEQUENCENUMBER)' +
    ' values(:RID,:SYMBOL,:LOCALTIME,:MESSAGE,:MARKETTIME,:MMID,:SIDE,:PRICE,:VOLUME,:DEPTH,:SEQUENCENUMBER)', [
    self.RID,
    self.Symbol,
    self.LocalTime,
    self.Message,
    self.MarketTime,
    self.Mmid,
    self.Side,
    self.Price,
    self.Volume,
    self.Depth,
    self.SequenceNumber
    ] );
end;

function TL2Line.ToCSVString: string;
begin
  Result := Format( 'Symbol=%s,', [ self.FSymbol ] );
  Result := Result + Format( 'LocalTime=%s,',
    [ self.FLocalTime.ToString( 'HH:mm:ss.zzz' ) ] );
  Result := Result + Format( 'Message=%s,', [ self.FMessage ] );
  Result := Result + Format( 'MarketTime=%s,',
    [ self.FMarketTime.ToString( 'HH:mm:ss.zzz' ) ] );
  Result := Result + Format( 'Mmid=%s,', [ self.FMmid ] );
  Result := Result + Format( 'Side=%s,', [ self.FSide ] );
  Result := Result + Format( 'Price=%f,', [ self.FPrice ] );
  Result := Result + Format( 'Volume=%d,', [ self.FVolume ] );
  Result := Result + Format( 'Depth=%d,', [ self.FDepth ] );
  Result := Result + Format( 'SequenceNumber=%d', [ self.FSequenceNumber ] );
end;

{ TL2Levels }

function TL2Levels.Add( item: TL2Line ): Word;
begin
  SetLength( Data, Length( Data ) + 1 );
  Data[ High( Data ) ] := item;
  Sort( );
end;

constructor TL2Levels.Create;
begin
  SetLength( Data, 0 );
end;

destructor TL2Levels.Destroy;
var
  i: Integer;
begin
  for i := Low( Data ) to High( Data ) do
  begin
    Data[ i ].Free;
  end;
  inherited;
end;

function TL2Levels.Find( Mmid: string; Price: Double ): TL2Line;
var
  i   : Integer;
  item: TL2Line;
begin
  for i := 0 to Length( Data ) - 1 do
  begin
    item := Data[ i ];
    if ( item.Mmid = Mmid ) and ( item.Price = Price ) then
      Exit( item );
  end;
  Exit( nil );
end;

function TL2Levels.FindIndex( Mmid: string; Price: Double ): Integer;
var
  i   : Integer;
  item: TL2Line;
begin
  for i := 0 to Length( Data ) - 1 do
  begin
    item := Data[ i ];
    if ( item.Mmid = Mmid ) and ( item.Price = Price ) then
      Exit( i );
  end;
  Exit( -1 );
end;

function TL2Levels.GetValue( Level: Integer ): TL2Line;
var
  i, no: Integer;
  item : TL2Line;
begin
  no    := 1;
  for i := Low( Data ) to High( Data ) do
  begin
    item := Data[ i ];
    if ( item.Volume = 0 ) then
      Continue;
    if no = Level then
      Exit( item );
    inc( no );
  end;
end;

function TL2Levels.Parse( source: TL2Line ): Boolean;
var
  l2line: TL2Line;
  index : Integer;
begin
  try
    index := self.FindIndex( source.Mmid, source.Price );
    if ( index = -1 ) then
    begin
      l2line := source.Clone( );
      self.Add( l2line );
    end
    else
    begin
      l2line            := self.Find( source.Mmid, source.Price );
      l2line.LocalTime  := source.LocalTime;
      l2line.MarketTime := source.MarketTime;
      l2line.Volume     := source.Volume;
    end;
  finally
  end;
end;

function TL2Levels.Parse( source: string ): Boolean;
// var
// sReplaced      : string;
// l2line, l2line2: TL2Line;
// index          : Integer;
begin
  // sReplaced := source.Replace( #13#10, '' ).Replace( #13, '' ).Replace( #10, '' );
  // l2line    := TL2Line.FromCSVString( sReplaced );
  // try
  // index := self.FindIndex( l2line.Mmid, l2line.Price );
  // if ( index = -1 ) then
  // self.Add( l2line )
  // else
  // begin
  // l2line2            := self.Find( l2line.Mmid, l2line.Price );
  // l2line2.LocalTime  := l2line.LocalTime;
  // l2line2.MarketTime := l2line.MarketTime;
  // l2line2.Volume     := l2line.Volume;
  // end;
  // finally
  // l2line.Free;
  // end;
  raise Exception.Create( 'not implemente' );
end;

function TL2Levels.Remove( index: Integer ): Boolean;
begin
  Data[ index ].Volume := 0;

  Sort( );
end;

procedure TL2Levels.RenderToListBox( listBox: TListBox; const renderZeroVolumn: Boolean );
var
  i, no: Integer;
  item : TL2Line;
begin
  listBox.Clear;
  no    := 1;
  for i := Low( Data ) to High( Data ) do
  begin
    item := Data[ i ];
    if ( item.Volume = 0 ) and ( not renderZeroVolumn ) then
      Continue;
    listBox.Items.Add( Format( '%.2d %.8s %4.2f %8.0f %.12s', [
      no,
      item.Mmid,
      item.Price,
      item.Volume / 100,
      item.MarketTime.Time.ToString( 'HH:mm:ss.zzz' ) ] ) );

    inc( no );
  end;
end;

function TL2Levels.Sort: TL2Levels;
begin
  TArray.Sort< TL2Line >(
    Data,
    TComparer< TL2Line >.Construct(
    function( const Left, Right: TL2Line ): Integer
    begin
      Result := TComparer< string >.Default.Compare( Left.Symbol, Right.Symbol );
      if ( Result = 0 ) then
      begin
        if ( Left.Side.ToLower = 'a' ) then
          Result := TComparer< Double >.Default.Compare( Left.Price, Right.Price )
        else if ( Left.Side.ToLower = 'b' ) then
          Result := TComparer< Double >.Default.Compare( Right.Price, Left.Price );
      end;
      if ( Result = 0 ) then
        Result := TComparer< string >.Default.Compare( Left.Mmid, Right.Mmid );
    end
    ) );
end;

end.
