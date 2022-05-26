require 'roo'

module Extract
  module XLS
    class Earnings
      # Cabeçalho da planilha de movimentação
      # Entrada/Saída - Data - Movimentação - Produto - Instituição - Quantidade - Preço unitário - Valor da Operação
      DATA = 1
      MOVIMENTACAO = 2
      PRODUTO = 3
      QUANTIDADE = 5
      PRECO_UNITARIO = 6
      VALOR_OPERACAO = 7

      def initialize(file, user)
        @file = file
        @user = user
      end

      def call
        xlsx = Roo::Spreadsheet.open(@file)
        xlsx.each_row_streaming(pad_cells: true, offset: 1) do |row|
          Earning.create!(
            asset: extract_asset(row[PRODUTO].value),
            user: @user,
            kind: extract_kind(row[MOVIMENTACAO].value),
            paid_at: row[DATA].value,
            quantity: row[QUANTIDADE].value,
            unit_price: row[PRECO_UNITARIO].value,
            net_value: row[VALOR_OPERACAO].value
          )
        end
        true
      end

      private

      def extract_asset(str)
        # Pattern: LGCP11       - LOG CP INTER FDO INV IMOB
        asset_name = str.split(' ')&.first

        asset = Asset.find_by(name: asset_name)

        return asset if asset.present?

        Asset.create(name: asset_name)
      end

      def extract_kind(str)
        return Earning.kinds[:income] if str.casecmp('Rendimento').zero?
        return Earning.kinds[:interest_on_equity] if str.casecmp('Juros Sobre Capital Próprio').zero?
        return Earning.kinds[:dividend] if str.casecmp('Dividendo').zero?

        raise StandardError, 'Kind not found'
      end
    end
  end
end
