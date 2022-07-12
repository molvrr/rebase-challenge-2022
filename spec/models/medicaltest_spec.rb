require 'rspec'
require './medicaltest'

describe MedicalTest do
  context '#all' do
    it 'retorna todos exames cadastrados' do
      result = double("result")
      test = {
        id: 1,
        cpf: '048.973.170-88',
        name: 'Emilly Batista Neto',
        email: 'gerald.crona@ebert-quigley.com',
        birthdate: '2001-03-11',
        address: '165 Rua Rafaela',
        city: 'Ituverava',
        state: 'Alagoas',
        doctor_crm: 'B000BJ20J4',
        doctor_crm_state: 'PI',
        doctor_name: 'Maria Luiza Pires',
        doctor_email: 'denna@wisozk.biz',
        result_token: 'IQCZ17',
        result_date: '2021-08-05',
        test_type: 'hemácias',
        test_limits: '45-52',
        test_result: '97'
      }
      allow(result).to receive(:field_names_as).and_return([test])
      allow_any_instance_of(PG::Connection).to receive(:exec).and_return(result)
      data = MedicalTest.all

      expect(data.length).to eq(1)
      expect(data[0].id).to eq(1)
      expect(data[0].cpf).to eq('048.973.170-88')
      expect(data[0].doctor[:crm]).to eq('B000BJ20J4')
      expect(data[0].doctor[:name]).to eq('Maria Luiza Pires')
    end

    it 'e não há nenhum exame cadastrado' do
      result = double("result")
      allow(result).to receive(:field_names_as).and_return([])
      allow_any_instance_of(PG::Connection).to receive(:exec).and_return(result)
      data = MedicalTest.all

      expect(data.length).to eq(0)
    end
  end
end
