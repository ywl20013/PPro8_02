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
      FMessage       : string;
      FRID           : String;
    public
      class function FromCSVString( source: string ): TL2Line;

      function ToCSVString( ): string;

      function SaveToDataBase( DataProvider: TDataProvider ): Boolean;

      function Clone( ): TL2Line;
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
      /// ���ݵ��ﱾ�ص��Ե�ʱ�䣬�����ص��Ե�ʱ����ʾ
      /// </summary>
      property Message: string read FMessage write FMessage;
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

      /// <summary>
      /// ����UDP���յ�ΨһID
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
