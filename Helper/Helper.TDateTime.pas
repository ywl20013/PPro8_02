{ *************************************************************************** }
{ }
{ DateTimeHelper }
{ }
{ Copyright (C) Colin Johnsun }
{ }
{ https://github.com/colinj }
{ }
{ }
{ *************************************************************************** }
{ }
{ Licensed under the Apache License, Version 2.0 (the "License"); }
{ you may not use this file except in compliance with the License. }
{ You may obtain a copy of the License at }
{ }
{ http://www.apache.org/licenses/LICENSE-2.0 }
{ }
{ Unless required by applicable law or agreed to in writing, software }
{ distributed under the License is distributed on an "AS IS" BASIS, }
{ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{ See the License for the specific language governing permissions and }
{ limitations under the License. }
{ }
{ *************************************************************************** }

unit Helper.TDateTime;

interface

uses
  System.SysUtils,
  System.Types,
  System.DateUtils;

type
  TDateTimeHelper = record helper for TDateTime
  private
    function GetDay: Word; inline;
    function GetDate: TDateTime; inline;
    function GetDayOfWeek: Word; inline;
    function GetDayOfYear: Word; inline;
    function GetHour: Word; inline;
    function GetMillisecond: Word; inline;
    function GetMinute: Word; inline;
    function GetMonth: Word; inline;
    function GetSecond: Word; inline;
    function GetTime: TDateTime; inline;
    function GetYear: Word; inline;
    class function GetNow: TDateTime; static; inline;
    class function GetToday: TDateTime; static; inline;
    class function GetTomorrow: TDateTime; static; inline;
    class function GetYesterDay: TDateTime; static; inline;
  public
    class function Create( const aYear, aMonth, aDay: Word ): TDateTime; overload;
      static; inline;
    class function Create( const aYear, aMonth, aDay, aHour, aMinute, aSecond,
      aMillisecond: Word ): TDateTime; overload; static; inline;
    class function Create( const sSource: string ): TDateTime; overload;
      static; inline;

    class property Now: TDateTime read GetNow;
    class property Today: TDateTime read GetToday;
    class property Yesterday: TDateTime read GetYesterDay;
    class property Tomorrow: TDateTime read GetTomorrow;

    property Date: TDateTime read GetDate;
    property Time: TDateTime read GetTime;

    property DayOfWeek: Word read GetDayOfWeek;
    property DayOfYear: Word read GetDayOfYear;

    property Year: Word read GetYear;
    property Month: Word read GetMonth;
    property Day: Word read GetDay;
    property Hour: Word read GetHour;
    property Minute: Word read GetMinute;
    property Second: Word read GetSecond;
    property Millisecond: Word read GetMillisecond;

    function ToString( const aFormatStr: string = '' ): string; inline;

    function StartOfYear: TDateTime; inline;
    function EndOfYear: TDateTime; inline;
    function StartOfMonth: TDateTime; inline;
    function EndOfMonth: TDateTime; inline;
    function StartOfWeek: TDateTime; inline;
    function EndOfWeek: TDateTime; inline;
    function StartOfDay: TDateTime; inline;
    function EndOfDay: TDateTime; inline;

    function ReplaceDate( const aDate: TDate ): TDateTime; inline;
    function ReplaceTime( const aTime: TTime ): TDateTime; inline;

    function AddYears( const aNumberOfYears: Integer = 1 ): TDateTime; inline;
    function AddMonths( const aNumberOfMonths: Integer = 1 ): TDateTime; inline;
    function AddDays( const aNumberOfDays: Integer = 1 ): TDateTime; inline;
    function AddHours( const aNumberOfHours: Int64 = 1 ): TDateTime; inline;
    function AddMinutes( const aNumberOfMinutes: Int64 = 1 ): TDateTime; inline;
    function AddSeconds( const aNumberOfSeconds: Int64 = 1 ): TDateTime; inline;
    function AddMilliseconds( const aNumberOfMilliseconds: Int64 = 1 )
      : TDateTime; inline;

    function CompareTo( const aDateTime: TDateTime ): TValueRelationship; inline;
    function Equals( const aDateTime: TDateTime ): Boolean; inline;
    function IsSameDay( const aDateTime: TDateTime ): Boolean; inline;
    function InRange( const aStartDateTime, aEndDateTime: TDateTime;
      const aInclusive: Boolean = True ): Boolean; inline;
    function IsInLeapYear: Boolean; inline;
    function IsToday: Boolean; inline;
    function IsAM: Boolean; inline;
    function IsPM: Boolean; inline;

    function YearsBetween( const aDateTime: TDateTime ): Integer; inline;
    function MonthsBetween( const aDateTime: TDateTime ): Integer; inline;
    function WeeksBetween( const aDateTime: TDateTime ): Integer; inline;
    function DaysBetween( const aDateTime: TDateTime ): Integer; inline;
    function HoursBetween( const aDateTime: TDateTime ): Int64; inline;
    function MinutesBetween( const aDateTime: TDateTime ): Int64; inline;
    function SecondsBetween( const aDateTime: TDateTime ): Int64; inline;
    function MilliSecondsBetween( const aDateTime: TDateTime ): Int64; inline;

    function WithinYears( const aDateTime: TDateTime; const aYears: Integer )
      : Boolean; inline;
    function WithinMonths( const aDateTime: TDateTime; const aMonths: Integer )
      : Boolean; inline;
    function WithinWeeks( const aDateTime: TDateTime; const aWeeks: Integer )
      : Boolean; inline;
    function WithinDays( const aDateTime: TDateTime; const aDays: Integer )
      : Boolean; inline;
    function WithinHours( const aDateTime: TDateTime; const aHours: Int64 )
      : Boolean; inline;
    function WithinMinutes( const aDateTime: TDateTime; const aMinutes: Int64 )
      : Boolean; inline;
    function WithinSeconds( const aDateTime: TDateTime; const aSeconds: Int64 )
      : Boolean; inline;
    function WithinMilliseconds( const aDateTime: TDateTime;
      const AMilliseconds: Int64 ): Boolean; inline;
  end;

implementation

{ TDateTimeHelper }

function TDateTimeHelper.AddDays( const aNumberOfDays: Integer ): TDateTime;
begin
  Result := IncDay( self, aNumberOfDays );
end;

function TDateTimeHelper.AddHours( const aNumberOfHours: Int64 ): TDateTime;
begin
  Result := IncHour( self, aNumberOfHours );
end;

function TDateTimeHelper.AddMilliseconds( const aNumberOfMilliseconds: Int64 )
  : TDateTime;
begin
  Result := IncMilliSecond( self, aNumberOfMilliseconds );
end;

function TDateTimeHelper.AddMinutes( const aNumberOfMinutes: Int64 ): TDateTime;
begin
  Result := IncMinute( self, aNumberOfMinutes );
end;

function TDateTimeHelper.AddMonths( const aNumberOfMonths: Integer ): TDateTime;
begin
  Result := IncMonth( self, aNumberOfMonths );
end;

function TDateTimeHelper.AddSeconds( const aNumberOfSeconds: Int64 ): TDateTime;
begin
  Result := IncSecond( self, aNumberOfSeconds );
end;

function TDateTimeHelper.AddYears( const aNumberOfYears: Integer ): TDateTime;
begin
  Result := IncYear( self, aNumberOfYears );
end;

function TDateTimeHelper.CompareTo( const aDateTime: TDateTime )
  : TValueRelationship;
begin
  Result := CompareDateTime( self, aDateTime );
end;

class function TDateTimeHelper.Create( const aYear, aMonth, aDay: Word )
  : TDateTime;
begin
  Result := EncodeDate( aYear, aMonth, aDay );
end;

class function TDateTimeHelper.Create( const aYear, aMonth, aDay, aHour, aMinute,
  aSecond, aMillisecond: Word ): TDateTime;
begin
  Result := EncodeDateTime( aYear, aMonth, aDay, aHour, aMinute, aSecond,
    aMillisecond );
end;

function TDateTimeHelper.DaysBetween( const aDateTime: TDateTime ): Integer;
begin
  Result := System.DateUtils.DaysBetween( self, aDateTime );
end;

function TDateTimeHelper.EndOfDay: TDateTime;
begin
  Result := EndOfTheDay( self );
end;

function TDateTimeHelper.EndOfMonth: TDateTime;
begin
  Result := EndOfTheMonth( self );
end;

function TDateTimeHelper.EndOfWeek: TDateTime;
begin
  Result := EndOfTheWeek( self );
end;

function TDateTimeHelper.EndOfYear: TDateTime;
begin
  Result := EndOfTheYear( self );
end;

function TDateTimeHelper.Equals( const aDateTime: TDateTime ): Boolean;
begin
  Result := SameDateTime( self, aDateTime );
end;

function TDateTimeHelper.GetDate: TDateTime;
begin
  Result := DateOf( self );
end;

function TDateTimeHelper.GetDay: Word;
begin
  Result := DayOf( self );
end;

function TDateTimeHelper.GetDayOfWeek: Word;
begin
  Result := DayOfTheWeek( self );
end;

function TDateTimeHelper.GetDayOfYear: Word;
begin
  Result := DayOfTheYear( self );
end;

function TDateTimeHelper.GetHour: Word;
begin
  Result := HourOf( self );
end;

function TDateTimeHelper.GetMillisecond: Word;
begin
  Result := MilliSecondOf( self );
end;

function TDateTimeHelper.GetMinute: Word;
begin
  Result := MinuteOf( self );
end;

function TDateTimeHelper.GetMonth: Word;
begin
  Result := MonthOf( self );
end;

class function TDateTimeHelper.GetNow: TDateTime;
begin
  Result := System.SysUtils.Now;
end;

function TDateTimeHelper.GetSecond: Word;
begin
  Result := SecondOf( self );
end;

function TDateTimeHelper.GetTime: TDateTime;
begin
  Result := TimeOf( self );
end;

class function TDateTimeHelper.GetToday: TDateTime;
begin
  Result := System.SysUtils.Date;
end;

class function TDateTimeHelper.GetTomorrow: TDateTime;
begin
  Result := System.SysUtils.Date + 1;
end;

function TDateTimeHelper.GetYear: Word;
begin
  Result := YearOf( self );
end;

class function TDateTimeHelper.GetYesterDay: TDateTime;
begin
  Result := System.SysUtils.Date - 1;
end;

function TDateTimeHelper.HoursBetween( const aDateTime: TDateTime ): Int64;
begin
  Result := System.DateUtils.HoursBetween( self, aDateTime );
end;

function TDateTimeHelper.InRange( const aStartDateTime, aEndDateTime: TDateTime;
  const aInclusive: Boolean ): Boolean;
begin
  Result := DateTimeInRange( self, aStartDateTime, aEndDateTime, aInclusive );
end;

function TDateTimeHelper.IsAM: Boolean;
begin
  Result := System.DateUtils.IsAM( self );
end;

function TDateTimeHelper.IsInLeapYear: Boolean;
begin
  Result := System.DateUtils.IsInLeapYear( self );
end;

function TDateTimeHelper.IsPM: Boolean;
begin
  Result := System.DateUtils.IsPM( self );
end;

function TDateTimeHelper.IsSameDay( const aDateTime: TDateTime ): Boolean;
begin
  Result := System.DateUtils.IsSameDay( self, aDateTime );
end;

function TDateTimeHelper.IsToday: Boolean;
begin
  Result := System.DateUtils.IsToday( self );
end;

function TDateTimeHelper.MilliSecondsBetween( const aDateTime: TDateTime ): Int64;
begin
  Result := System.DateUtils.MilliSecondsBetween( self, aDateTime );
end;

function TDateTimeHelper.MinutesBetween( const aDateTime: TDateTime ): Int64;
begin
  Result := System.DateUtils.MinutesBetween( self, aDateTime );
end;

function TDateTimeHelper.MonthsBetween( const aDateTime: TDateTime ): Integer;
begin
  Result := System.DateUtils.MonthsBetween( self, aDateTime );
end;

function TDateTimeHelper.ReplaceDate( const aDate: TDate ): TDateTime;
begin
  Result := TDateTime( frac( self ) + trunc( aDate ) );
end;

function TDateTimeHelper.ReplaceTime( const aTime: TTime ): TDateTime;
begin
  Result := TDateTime( frac( aTime ) + trunc( self ) );
end;

function TDateTimeHelper.SecondsBetween( const aDateTime: TDateTime ): Int64;
begin
  Result := System.DateUtils.SecondsBetween( self, aDateTime );
end;

function TDateTimeHelper.StartOfDay: TDateTime;
begin
  Result := StartOfTheDay( self );
end;

function TDateTimeHelper.StartOfMonth: TDateTime;
begin
  Result := StartOfTheMonth( self );
end;

function TDateTimeHelper.StartOfWeek: TDateTime;
begin
  Result := StartOfTheWeek( self );
end;

function TDateTimeHelper.StartOfYear: TDateTime;
begin
  Result := StartOfTheYear( self );
end;

function TDateTimeHelper.ToString( const aFormatStr: string ): string;
begin
  if aFormatStr = '' then
      Result := DateToStr( self )
  else
      Result := FormatDateTime( aFormatStr, self );
end;

function TDateTimeHelper.WeeksBetween( const aDateTime: TDateTime ): Integer;
begin
  Result := System.DateUtils.WeeksBetween( self, aDateTime );
end;

function TDateTimeHelper.WithinDays( const aDateTime: TDateTime;
  const aDays: Integer ): Boolean;
begin
  Result := System.DateUtils.WithinPastDays( self, aDateTime, aDays );
end;

function TDateTimeHelper.WithinHours( const aDateTime: TDateTime;
  const aHours: Int64 ): Boolean;
begin
  Result := System.DateUtils.WithinPastHours( self, aDateTime, aHours );
end;

function TDateTimeHelper.WithinMilliseconds( const aDateTime: TDateTime;
  const AMilliseconds: Int64 ): Boolean;
begin
  Result := System.DateUtils.WithinPastMilliSeconds( self, aDateTime,
    AMilliseconds );
end;

function TDateTimeHelper.WithinMinutes( const aDateTime: TDateTime;
  const aMinutes: Int64 ): Boolean;
begin
  Result := System.DateUtils.WithinPastMinutes( self, aDateTime, aMinutes );
end;

function TDateTimeHelper.WithinMonths( const aDateTime: TDateTime;
  const aMonths: Integer ): Boolean;
begin
  Result := System.DateUtils.WithinPastMonths( self, aDateTime, aMonths );
end;

function TDateTimeHelper.WithinSeconds( const aDateTime: TDateTime;
  const aSeconds: Int64 ): Boolean;
begin
  Result := System.DateUtils.WithinPastSeconds( self, aDateTime, aSeconds );
end;

function TDateTimeHelper.WithinWeeks( const aDateTime: TDateTime;
  const aWeeks: Integer ): Boolean;
begin
  Result := System.DateUtils.WithinPastWeeks( self, aDateTime, aWeeks );
end;

function TDateTimeHelper.WithinYears( const aDateTime: TDateTime;
  const aYears: Integer ): Boolean;
begin
  Result := System.DateUtils.WithinPastYears( self, aDateTime, aYears );
end;

function TDateTimeHelper.YearsBetween( const aDateTime: TDateTime ): Integer;
begin
  Result := System.DateUtils.YearsBetween( self, aDateTime );
end;

class function TDateTimeHelper.Create( const sSource: string ): TDateTime;
begin
  Result := StrToTimeDef( sSource, 0 );
end;

end.
