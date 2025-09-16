class CarrinhoDeCompras {

    constructor(cliente, data, novoCliente) {
        this.cliente = cliente;
        this.novoCliente = novoCliente;
        this.data = data;
        this.itens = [];
        this.valorTotal = 0;
        this.cupom = null;
    }
    
    // adicionar produtos
    adicionarProduto(produto, quantidade) {
       this.itens.push({ produto, quantidade });
       this.calcularValorTotal();
    }

    // recebe um array de objetos com um produto e a sua respectiva quantidade
    adicionarProdutos(lista) {
        this.itens.push(...lista);
        this.calcularValorTotal();
    }
    
    // recalcular valor total para novos produtos adicionados (usar concatenação de operadores)
    calcularValorTotal() {
        let total = 0;

        this.itens.forEach(item => {
            if (item.produto.preco !== undefined) {
                total += item.produto.preco;
            }
        });

        this.valorTotal = total;
    }
    
    // adicionar cupom de desconto
    adicionarCupom(codigo) {
        if ((codigo.toUpperCase().substring('CAMP')) && (!codigo.includes('-'))) {
            
            const desconto = parseInt(codigo.substring('CAMP'.length));

            if (desconto <= 50) {
                this.cupom = desconto;
            }
        }
    }
    
    // calcular quantidade de itens totais 
    get totalDeItens() {
        let total = 0;

        this.itens.forEach(item => {
            total += item.quantidade;
        });

        return total;
    }

    // listar produtos
    get listaDeProdutos() {
        let listaProdutos = '';

        this.itens.forEach(item => {
            listaProdutos += ` - Produto: ${item.produto.codigo} - ${item.produto.nome} x${item.quantidade}\n`
        });

        return listaProdutos;
    }
    
    // calcular valor final (desconto para novos clientes OU cupom)
    fecharCompra() {
        // 20% de desconto para novos clientes
        if(this.novoCliente) { 
            this.valorTotal -= this.valorTotal * 0.2;
        } 
        // desconto de XX% do cupom 
        else if(this.cupom) {
            const desconto = this.cupom * 0.01;
            this.valorTotal -= this.valorTotal * desconto;
        } 
        // 5% de desconto para compras acima de 100 reais
        else {
            if (this.valorTotal > 100)
                this.valorTotal -= this.valorTotal * 0.05;
        }
    }
}

function Produto(codigo, nome, preco){
    this.codigo = codigo;
    this.nome = nome;
    this.preco = preco;
}

const meuCarrinho = new CarrinhoDeCompras();

meuCarrinho.adicionarProduto({codigo: 001, nome: 'Leite Integral 1L', preco: 3.25}, 4);

meuCarrinho.adicionarProduto(new Produto(002, 'Óleo de Soja 900ml', 7.98), 2);

// adicionar uma lista 
let produtoA = {produto: new Produto(003, 'Arroz 5kg', 22.99), quantidade: 1};
let produtoB = {produto: new Produto(004, 'Molho de Tomate 350g', 2.49), quantidade: 2};
const meusItens = [produtoA, produtoB];

produtoA = {produto: new Produto(005, 'Açúcar Cristal 5kg', 12.98), quantidade: 1};
produtoB = {produto: new Produto(006, 'Sal Refinado 1kg', 2.19), quantidade: 1};
meuCarrinho.adicionarProdutos(meusItens);

meuCarrinho.adicionarProdutos([produtoA, produtoB]);

meuCarrinho.adicionarCupom('camp50');

function resumoDaCompra(carrinho) {
    if (carrinho.itens.length <= 0) {
        return "Não é possível realizar uma compra com o carrinho vazio!";
    }

    return (metodoDePagamento, parcelas) => {
        if (parcelas <= 0) {
            return 'Não é possível realizar uma compra com menos de 1 (uma) parcela!';
        }

        if ((metodoDePagamento.includes('Dinheiro')) && (parcelas > 1)) {
            return 'Não é possível dividir o valor da compra em pagamentos feitos em dinheiro.';
        }

        // Taxa paga ao usar cartão de crédito
        if (metodoDePagamento.includes('Cartão de Crédito')) {
            carrinho.valorTotal += carrinho.valorTotal * 0.05;
        }

        let dataAgora = new Date();
        const dataExtenso = `${dataAgora.getDate()}\\${dataAgora.getMonth()}\\${dataAgora.getFullYear()}`;
        const conteudoCompra = `\nCompra realizada em ${dataExtenso}:\n${carrinho.listaDeProdutos}\n`;
        const valorParcela = carrinho.valorTotal / parcelas;
        let infoPagamento = `O valor total de R\$${carrinho.valorTotal.toFixed(2)} foi pago com ${metodoDePagamento} `;
        infoPagamento += `em ${parcelas} parcelas de R\$${valorParcela.toFixed(2)}.`;

        return conteudoCompra + infoPagamento;
    }
}

console.log(resumoDaCompra(meuCarrinho)('Cartão de Débito', 3))
