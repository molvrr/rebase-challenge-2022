require 'spec_helper'
require 'rake'

describe 'Banco de dados é populado' do
  before(:all) do
    @conn = PG.connect(host: 'postgres', password: 1234, user: 'postgres', dbname: 'tests')
  end

  after(:each) do
    @conn.exec('DELETE FROM tests')
  end

  it 'com sucesso' do
    file = CSV.read('./data_test.csv', col_sep: ';', headers: true, header_converters: :symbol)
    task = Rake::Task['db:prepare']
    allow(PG).to receive(:connect).and_return(@conn)
    allow(CSV).to receive(:read).and_return(file)

    task.execute
    tests = MedicalTest.all

    expect(tests.length).to eq(4)
    expect(file[0][:nome_paciente]).to eq(tests[0].name)
    expect(file[0][:cpf]).to eq(tests[0].cpf)
    expect(file[1][:nome_paciente]).to eq(tests[1].name)
    expect(file[1][:cpf]).to eq(tests[1].cpf)
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
