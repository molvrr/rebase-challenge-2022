require 'spec_helper'

describe Server do
  let(:app) { Server.new }

  context 'GET /tests' do
    it 'retorna todos exames cadastrados' do
      test = [{
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
      }]
      allow(MedicalTest).to receive(:all).and_return(test)

      response = get '/tests'
      json_resp = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json_resp.length).to eq(1)
      expect(json_resp[0]['result_token']).to eq('IQCZ17')
      expect(json_resp[0]['result_date']).to eq('2021-08-05')
      expect(json_resp[0]['cpf']).to eq('048.973.170-88')
    end

    it 'e não há exames cadastrados' do
      allow(MedicalTest).to receive(:all).and_return([])

      response = get '/tests'
      json_resp = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json_resp.length).to eq(0)
    end
  end

  context 'GET /tests/:token' do
    it 'com sucesso' do
      data = {
        result_token: 'IQCZ17',
        result_date: '2021-08-05',
        cpf: '048.973.170-88',
        name: 'Emilly Batista Neto',
        email: 'gerald.crona@ebert-quigley.com',
        birthdate: '2001-03-11',
        doctor: {
          crm: 'B000BJ20J4',
          crm_state: 'PI',
          name: 'Maria Luiza Pires',
        },
        tests: [
          {
            type: 'hemácias',
            limits: '45-52',
            result: '97'
          },
          {
            type: 'leucócitos',
            limits: '9-61',
            result: '89'
          }
        ]
      }
      allow(MedicalTest).to receive(:find_all).and_return(data)

      response = get '/tests/IQCZ17'
      json_resp = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json_resp['result_token']).to eq('IQCZ17')
      expect(json_resp['tests'].length).to eq(2)
    end

    it 'e não há um teste cadastrado com o token informado' do
      allow(MedicalTest).to receive(:find_all).and_return(nil)

      response = get '/tests/IQCZ17'

      expect(response.status).to eq(404)
    end
  end

  context 'POST /import' do
    it 'com sucesso' do
      file = File.open('./data_test.csv', 'r')
      allow(CSVJob).to receive(:perform_async).and_return(true)

      response = post '/import', data: file.read

      expect(response.status).to eq(200)
    end

    it 'sem arquivo' do
      allow(CSVJob).to receive(:perform_async).and_return(false)

      response = post '/import'

      expect(response.status).to eq(400)
    end
  end
end
