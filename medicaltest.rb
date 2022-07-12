require 'pg'
require 'csv'

class MedicalTest
  def self.headers_from_csv
    {
      "cpf": :cpf,
      "nome paciente": :name,
      "email paciente": :email,
      "data nascimento paciente": :birthdate,
      "endereço/rua paciente": :address,
      "cidade paciente": :city,
      "estado patiente": :state,
      "crm médico": :doctor_crm,
      "crm médico estado": :doctor_crm_state,
      "nome médico": :doctor_name,
      "email médico": :doctor_email,
      "token resultado exame": :result_token,
      "data exame": :result_date,
      "tipo exame": :test_type,
      "limites tipo exame": :test_limits,
      "resultado tipo exame": :test_result
    }
  end

  def self.all
    headers_proc = proc { |h| headers_from_csv[h.to_sym] }
    rows = CSV.read('./data.csv', col_sep: ';', headers: true, header_converters: headers_proc)
    rows.map do |r|
      row = r.to_hash
      row[:doctor] = {}
      row[:doctor][:crm] = row.delete(:doctor_crm)
      row[:doctor][:crm_state] = row.delete(:doctor_crm_state)
      row[:doctor][:name] = row.delete(:doctor_name)
      row[:doctor][:email] = row.delete(:doctor_email)

      row[:test] = {}
      row[:test][:type] = row.delete(:test_type)
      row[:test][:limits] = row.delete(:test_limits)
      row[:test][:result] = row.delete(:test_result)

      row
    end
  end
end
