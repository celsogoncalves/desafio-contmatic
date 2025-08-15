program desafio_contmatic;

uses
  Vcl.Forms,
  desafio.view.vcl.principal in 'view\vcl\desafio.view.vcl.principal.pas' {FormPrincipal},
  desafio.model.entity.interfaces in 'model\entity\desafio.model.entity.interfaces.pas',
  desafio.model.entity in 'model\entity\desafio.model.entity.pas',
  desafio.model.connection.interfaces in 'model\connection\desafio.model.connection.interfaces.pas',
  desafio.model.connection.FireDac in 'model\connection\desafio.model.connection.FireDac.pas',
  desafio.model.connection.FireDac.Query in 'model\connection\desafio.model.connection.FireDac.Query.pas',
  desafio.model.connection.configuracao.arqini in 'model\connection\desafio.model.connection.configuracao.arqini.pas',
  desafio.view.vcl.pedido in 'view\vcl\desafio.view.vcl.pedido.pas' {FormVisualizarPedidos},
  desafio.controller.interfaces in 'controller\desafio.controller.interfaces.pas',
  desafio.model.dto in 'model\dto\desafio.model.dto.pas',
  desafio.model.dto.interfaces in 'model\dto\desafio.model.dto.interfaces.pas',
  desafio.controller.produto in 'controller\desafio.controller.produto.pas',
  desafio.model.dao.interfaces in 'model\dao\desafio.model.dao.interfaces.pas',
  desafio.model.dao.produto in 'model\dao\desafio.model.dao.produto.pas',
  desafio.model.adapter in 'model\adapter\desafio.model.adapter.pas',
  desafio.model.dao.cliente in 'model\dao\desafio.model.dao.cliente.pas',
  desafio.controller.cliente in 'controller\desafio.controller.cliente.pas',
  desafio.model.dao.pedido in 'model\dao\desafio.model.dao.pedido.pas',
  desafio.controller.pedido in 'controller\desafio.controller.pedido.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TFormVisualizarPedidos, FormVisualizarPedidos);
  Application.Run;
end.
