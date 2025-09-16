import "./App.css";
import Table from "react-bootstrap/Table";
import React, { useState, useEffect } from "react";

function App() {
  const dadosCorpoTabela = [
    {
      id: "1",
      codigo_barras: "7891215258101",
      nome: "CHOCOLATE BARRA NESTLE 250G",
      preco_custo: "R$ 5,72",
      preco_venda: "R$ 7,29",
      categoria: "Alimentos"
    },
    {
      id: "2",
      codigo_barras: "7891952386256",
      nome: "SALGADINHO CEBOLITOS 50G",
      preco_custo: "R$ 2,86",
      preco_venda: "R$ 3,59",
      categoria: "Alimentos"
    },
    {
      id: "3",
      codigo_barras: "7891102526112",
      nome: "LEITE UHT ITAMBÉ INTEGRAL 1L",
      preco_custo: "R$ 3,75",
      preco_venda: "R$ 4,29",
      categoria: "Bebidas"
    },
    {
      id: "4",
      codigo_barras: "070330631328",
      nome: "ISQUEIRO BIC MINI ",
      preco_custo: "R$ 1,71",
      preco_venda: "R$ 2,59",
      categoria: "Utensílios"
    },
    {
      id: "5",
      codigo_barras: "7899628484899",
      nome: "REFRIGERANTE COCA-COLA LATA 335ML",
      preco_custo: "R$ 1,99",
      preco_venda: "R$ 3,49",
      categoria: "Bebidas"
    }
  ];

  const [produtos, setProdutos] = useState(dadosCorpoTabela);

  function cadastrarProduto(event) {
      alert(`O produto ${event.target[1].value} foi cadastrado com sucesso!`);
      event.preventDefault();
  }

  function excluirProduto(event) {
      alert(`O produto de código de barras ${event.target[0].value} foi excluído com sucesso!`);
      event.preventDefault();
  }

  function listarProdutos(linha) {
    return (
      <tr>
        <td>{linha.id}</td>
        <td>{linha.codigo_barras}</td>
        <td>{linha.nome}</td>
        <td>{linha.preco_custo}</td>
        <td>{linha.preco_venda}</td>
      </tr>
    );
  }

  return (
    <div>
      <Table striped bordered hover variant="dark">
        <thead>
          <tr>
            <th>#</th>
            <th>Código de barras</th>
            <th>Nome</th>
            <th>Preço de custo</th>
            <th>Preço de venda</th>
          </tr>
        </thead>
        <tbody>
          {produtos.map((linha, index) => {
            return listarProdutos(linha);
          })}
        </tbody>
      </Table>
      <form onSubmit={cadastrarProduto}>
        <h1>Cadastrar produto</h1>
        <br></br>
        <label>
          Código de barras:
          <input type="text" name="name" />
        </label>
        <br></br>
        <label>
          Nome:
          <input type="text" name="name" />
        </label>
        <br></br>
        <label>
          Preço de custo:
          <input type="text" name="name" />
        </label>
        <br></br>
        <label>
          Preço de venda:
          <input type="text" name="name" />
        </label>
        <br></br>
        <label>
          Categoria:
          <select name="categoria">
            <option value="alimentos">Alimentos</option>
            <option value="bebidas">Bebidas</option>
            <option value="utensilios">Utensílios</option>
          </select>
        </label>
        <br></br>
        <input type="submit" value="Enviar" />
      </form>
      <br></br>
      <form onSubmit={excluirProduto}>
        <h1>Excluir produto</h1>
        <br></br>
        <label>
          Código de barras:
          <input type="text" name="name" />
        </label>
        <br></br>
        <input type="submit" value="Enviar" />
      </form>
    </div>
  );
}

export default App;
