unit Models.L2;

interface

type
  TL2Line = class
  private
    FMarketTime: TDateTime;
    FPrice: Double;
    FDepth: Cardinal;
    FLocalTime: TDateTime;
    FSide: String;
    FVolume: Cardinal;
    FSequenceNumber: Cardinal;
    FMmid: string;
  published
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

end.
