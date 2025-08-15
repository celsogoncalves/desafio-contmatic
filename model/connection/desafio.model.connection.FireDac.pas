unit desafio.model.connection.FireDac;

interface

uses
  System.Classes, SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDac.DApt,
  FireDac.Phys.SQLite, FireDac.Phys.SQLiteDef,
  desafio.model.connection.interfaces;


type

  TFireDacConexao = class(TInterfacedObject, iConexao)
  Strict private
    FConn : TFDConnection;
    FConf : iConfigConexao;
  private
    constructor Create;
    destructor destroy; override;
  public
    function Conexao: TCustomConnection;

    class function New: iConexao;
  end;

implementation

{ TFireDacConexao }

uses desafio.model.connection.configuracao.arqini;

function TFireDacConexao.Conexao: TCustomConnection;
begin
  Result := Self.FConn;
end;

constructor TFireDacConexao.Create;
begin
  inherited Create;

  FConn := TFDConnection.Create(nil);

  try
    FConf := TConfigArqIni.New( ExtractFilePath( ParamStr(0))+'\configConexao.ini' );

    FConn.Params.Clear;
    FConn.Params.DriverID := FConf.getDriverName;
    FConn.Params.UserName := FConf.getUser;
    FConn.Params.Password := FConf.getPassword;
    FConn.Params.Add('Database='+{FConf.getHost+':'+}FConf.getPath);

    if (FConf.getDriverName='SQLite') then
      FConn.Params.Add('LockingMode=Normal');
    FConn.Open;
  except
    on E:Exception do
      raise Exception.Create('Erro ao conectar com banco de dados: '+ E.Message);
  end;
end;

destructor TFireDacConexao.destroy;
begin
  FreeAndNil(FConn);

  inherited;
end;

class function TFireDacConexao.New: iConexao;
begin
  Result := Self.Create;
end;

end.
