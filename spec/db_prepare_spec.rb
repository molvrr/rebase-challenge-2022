require 'spec_helper'
require 'rake'

describe 'Banco de dados é populado' do
  before(:all) do
    @conn = PG.connect(host: 'postgres', password: 1234, user: 'postgres', dbname: 'tests')
  end

  it 'com sucesso' do
    file = CSV.read('./data_test.csv', col_sep: ';', headers: true, header_converters: :symbol)
    task = Rake::Task['db:prepare']
    allow(PG).to receive(:connect).and_return(@conn)
    allow(CSV).to receive(:read).and_return(file)

    task.execute
    tests = MedicalTest.all

    expect(tests.length).to eq(4)
  end

  it 'e não possui dados anteriores' do
    file = CSV.read('./data_test.csv', col_sep: ';', headers: true, header_converters: :symbol)
    task = Rake::Task['db:prepare']
    allow(PG).to receive(:connect).and_return(@conn)
    allow(CSV).to receive(:read).and_return(file)

    task.execute
    task.execute
    tests = MedicalTest.all

    expect(tests.length).to eq(4)
  end
end
