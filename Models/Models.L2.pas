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
    /// ���ݵ��ﱾ�ص��Ե�ʱ�䣬�����ص��Ե�ʱ����ʾ
    /// </summary>
    property LocalTime: TDateTime read FLocalTime write FLocalTime;
    /// <summary>
    /// �г�����ʱ��
    /// </summary>
    property MarketTime: TDateTime read FMarketTime write FMarketTime;
    /// <summary>
    /// ���θ��µ��г������ߴ���MMID
    /// </summary>
    property Mmid: string read FMmid write FMmid;
    /// <summary>
    /// ���µĶ����ķ���
    /// </summary>
    property Side: String read FSide write FSide;
    /// <summary>
    /// ���µĶ����ļ۸�
    /// </summary>
    property Price: Double read FPrice write FPrice;
    /// <summary>
    /// ���µĶ����Ĺ���
    /// </summary>
    property Volume: Cardinal read FVolume write FVolume;
    /// <summary>
    /// �����ļ�λ��
    /// </summary>
    property Depth: Cardinal read FDepth write FDepth;
    /// <summary>
    /// ���кţ��ǰ�ÿ���г������ߴ���MMID��Price�����۸񡢺ͷ���Side����ģ����������ų����ҵ�����
    /// </summary>
    property SequenceNumber: Cardinal read FSequenceNumber
      write FSequenceNumber;
  end;

implementation

end.
