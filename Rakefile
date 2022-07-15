require 'pg'
require 'csv'

namespace :db do
  task :setup do
    conn = PG.connect(host: 'postgres', password: 1234, user: 'postgres')
    conn.exec('CREATE TABLE IF NOT EXISTS tests (id SERIAL PRIMARY KEY, cpf TEXT, name TEXT, email TEXT, birthdate TEXT,
      address TEXT, city TEXT, state TEXT, doctor_crm TEXT, doctor_crm_state TEXT, doctor_name TEXT, doctor_email TEXT,
      result_token TEXT, result_date TEXT, test_type TEXT, test_limits TEXT, test_result TEXT)')
    conn.send_query('CREATE DATABASE tests')
    conn.close
    conn = PG.connect(host: 'postgres', password: 1234, user: 'postgres', dbname: 'tests')
    conn.exec('CREATE TABLE IF NOT EXISTS tests (id SERIAL PRIMARY KEY, cpf TEXT, name TEXT, email TEXT, birthdate TEXT,
      address TEXT, city TEXT, state TEXT, doctor_crm TEXT, doctor_crm_state TEXT, doctor_name TEXT, doctor_email TEXT,
      result_token TEXT, result_date TEXT, test_type TEXT, test_limits TEXT, test_result TEXT)')
  end
  task :import do
    conn = PG.connect(host: 'postgres', password: 1234, user: 'postgres')
    rows = CSV.read('./data.csv', col_sep: ';', headers: true, header_converters: :symbol)
    rows.each do |row|
      conn.exec_params("INSERT INTO tests (cpf, name, email, birthdate, address, city, state, doctor_crm, doctor_crm_state, doctor_name, doctor_email, result_token, result_date, test_type, test_limits, test_result) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16)", [row[:cpf], row[:nome_paciente], row[:email_paciente], row[:data_nascimento_paciente], row[:endereorua_paciente], row[:cidade_paciente], row[:estado_patiente], row[:crm_mdico], row[:crm_mdico_estado], row[:nome_mdico], row[:email_mdico], row[:token_resultado_exame], row[:data_exame], row[:tipo_exame], row[:limites_tipo_exame], row[:resultado_tipo_exame]])
    end
  end
end
