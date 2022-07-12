require 'spec_helper'

describe Server do
  let(:app) { Server.new }

  context 'GET /tests' do
    it 'retorna todos exames cadastrados' do
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
      result = double('result', field_names_as: [test])
      allow_any_instance_of(PG::Connection).to receive(:exec).and_return(result)

      response = get '/tests'
      json_resp = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json_resp.length).to eq(1)
      expect(json_resp[0]['result_token']).to eq('IQCZ17')
      expect(json_resp[0]['result_date']).to eq('2021-08-05')
      expect(json_resp[0]['cpf']).to eq('048.973.170-88')
    end

    it 'e não há exames cadastrados' do
      result = double('result', field_names_as: [])
      allow_any_instance_of(PG::Connection).to receive(:exec).and_return(result)

      response = get '/tests'
      json_resp = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json_resp.length).to eq(0)
    end
  end

  context 'POST /import' do
    it 'com sucesso' do
      file = Rack::Test::UploadedFile.new('./data.csv', 'csv')
      allow(MedicalTest).to receive(:from_csv).and_return(true)

      response = post '/import', data: file

      expect(response.status).to eq(201)
    end

    it 'sem arquivo' do
      allow(MedicalTest).to receive(:from_csv).and_return(false)

      response = post '/import'

      expect(response.status).to eq(500)
    end
  end
end
