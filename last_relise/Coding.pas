unit Coding;

interface

type
  PCodingClass =^TCodingClass;
  TCodingClass = class(TObject)
  public
    GKeyS,GKeyR:array[0..15] of Byte;
    procedure InitKey(const XorKey; Interlude: Boolean = False); Virtual; Abstract;
    procedure DecryptGP(var Data; const Size: Word); Virtual; Abstract;
    procedure EncryptGP(var Data; const Size: Word); Virtual; Abstract;
  end;

implementation
    
end.
