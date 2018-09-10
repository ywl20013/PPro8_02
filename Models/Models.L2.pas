unit Models.L2;

interface

uses System.SysUtils,
  Data.Provider;

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
    /// ���ݵ��ﱾ�ص��Ե�ʱ�䣬�����ص��Ե�ʱ����ʾ
    /// </summary>
    property Symbol: string read FSymbol write FSymbol;
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

uses
  Helper.TDateTime;

{ TL2Line }

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
