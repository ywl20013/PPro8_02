unit Models.L2;

interface

type
  {
    Register?symbol=ZVZZT.NQ&feedtype=L2 & output=[bykey|bytype

    API�����մ���ZVZZT.NQ��Level 2�����б��۸��¡���Щ���½���д��PPro8��¼Ŀ¼���ĵ����ĵ���Ϊ��L2_1_ZVZZT.NQ.log
    L2�����ݱ�������������������
    L2�����ݣ�ÿ������ֱ�д��һ���ĵ���
    ÿ��Level 2�ĸ��£���һ�������ŷָ��������У���Ŀ������
    LocalTime=08:39:43.114 �� �������ݵ��ﱾ�ص��Ե�ʱ�䣬�����ص��Ե�ʱ����ʾ
    MarketTime=08:39:42.601 �� �г�����ʱ��
    Mmid=ANON �� �����θ��µ��г������ߴ���MMID
    Side=B �� ������µĶ����ķ���
    Price=8.6 �� ������µĶ����ļ۸�
    Volume=100 �� ������µĶ����Ĺ���
    Depth=1 �� �������ļ�λ��
    SequenceNumber=27003 �� ������кţ��ǰ�ÿ���г������ߴ���MMID��Price�����۸񡢺ͷ���Side����ģ����������ų����ҵ����ݡ�

    ÿһ�εĸ��£�Ҫô (a) ����һ���µļ�λ��Ҫô (b) ��ָ�����г������ߴ���MMID, ����Side�ͼ۸�Price����������¡�

    �������������ǰ��һ����ANON�г������ߴ����е�400�ɣ�������ÿ��8.6��Ԫ���򵥣���������ӽ���ANON��8.6��λ���򵥹���������100�ɡ�
    Market Depth Snapshot�г���Ƚ�ͼ
    ��API��һ��������ע��Level 2������Դ��ʱ���������Ȼ�ȡһ����ͼ����ͼ�������������Ŀǰ�ı���״̬�����ҽ�����ʵʱ�ĸ�����Ϣ���ϸ��¡�
    ��ͼ�����ݴ�Side=s��ʼ��������
    LocalTime=08:37:31.908,MarketTime=00:00:00.000,Mmid=,Side=s,Price=0,Volume=0,Depth=0,SequenceNumber=0
    ���н�ͼ�����ݶ���ʾSequenceNumber=0.
    ��ͼ�����ݴ�Side=e������������
    LocalTime=08:37:31.908,MarketTime=00:00:00.000,Mmid=,Side=e,Price=0,Volume=0,Depth=0,SequenceNumber=0
  }
  /// <summary>
  /// Market Depth (L2)�г����
  /// </summary>
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
  public
    class function FromCSVString(source: string): TL2Line;

    function ToString(): string;
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

{ TL2Line }

class function TL2Line.FromCSVString(source: string): TL2Line;
begin

end;

function TL2Line.ToString: string;
begin

end;

end.
