unit Models.L2;

interface

uses System.SysUtils,
  Data.Provider;

type
  {
    Register?symbol=ZVZZT.NQ&feedtype=L2 & output=[bykey|bytype

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
  public
    class function FromCSVString( source: string ): TL2Line;

    function ToCSVString( ): string;

    function SaveToDataBase( DataProvider: TDataProvider ): Boolean;

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
  end;

implementation

uses
  Helper.TDateTime;

{ TL2Line }

class function TL2Line.FromCSVString( source: string ): TL2Line;
var
  pair, name, value: string;
  strs, strs2      : TArray< string >;
begin
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
      else if LowerCase( name ) = LowerCase( 'LocalTime' ) then
      begin
        Result.FLocalTime := TDateTime.Create( value );
      end
      else if LowerCase( name ) = LowerCase( 'MarketTime' ) then
      begin
        Result.FMarketTime := TDateTime.Create( value );
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
        Result.FSequenceNumber := value.ToInteger( );
      end

    end;
  end;

end;

function TL2Line.SaveToDataBase( DataProvider: TDataProvider ): Boolean;
begin
  Result := DataProvider.ExecuteSql( 'insert into L2Lines(NAME,LOCALTIME,MARKETTIME,MMID,SIDE,PRICE,VOLUME,DEPTH,SEQUENCENUMBER)' +
    ' values(:NAME,:LOCALTIME,:MARKETTIME,:MMID,:SIDE,:PRICE,:VOLUME,:DEPTH,:SEQUENCENUMBER)', [
    self.Symbol,
    self.LocalTime,
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
  Result := Result + Format( 'MarketTime=%s,',
    [ self.FMarketTime.ToString( 'HH:mm:ss.zzz' ) ] );
  Result := Result + Format( 'Mmid=%s,', [ self.FMmid ] );
  Result := Result + Format( 'Side=%s,', [ self.FSide ] );
  Result := Result + Format( 'Price=%f,', [ self.FPrice ] );
  Result := Result + Format( 'Volume=%d,', [ self.FVolume ] );
  Result := Result + Format( 'Depth=%d,', [ self.FDepth ] );
  Result := Result + Format( 'SequenceNumber=%d', [ self.FSequenceNumber ] );
end;

end.
