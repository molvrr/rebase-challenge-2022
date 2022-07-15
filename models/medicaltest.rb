require 'pg'
require 'csv'

class MedicalTest
  attr_reader :id, :cpf, :name, :email, :birthdate, :address, :city, :state, :doctor, :result_token, :result_date, :test_type, :test_limits, :test_result

  def initialize(data, conn = nil)
    @sql = conn || PG.connect(host: 'postgres', password: 1234, user: 'postgres')
    @id = data[:id].to_i
    @cpf = data[:cpf]
    @name = data[:name]
    @email = data[:email]
    @birthdate = data[:birthdate]
    @address = data[:address]
    @city = data[:city]
    @state = data[:state]
    @doctor = { crm: data[:doctor_crm], crm_state: data[:doctor_crm_state],
                name: data[:doctor_name], email: data[:doctor_email] }
    @result_token = data[:result_token]
    @result_date = data[:result_date]
    @test_type = data[:test_type]
    @test_limits = data[:test_limits]
    @test_result = data[:test_result]
  end

  def to_json(s)
    {
      result_token: @result_token,
      result_date: @result_date,
      cpf: @cpf,
      name: @name,
      birthdate: @birthdate,
      address: @address,
      city: @city,
      state: @state,
      doctor: @doctor,
      test_type: @test_type,
      test_limits: @test_limits,
      test_result: @test_result
    }.to_json(s)
  end

  def self.find_all(token)
    conn = PG.connect(host: 'postgres', password: 1234, user: 'postgres')
    rows = conn.exec_params('SELECT * FROM tests WHERE result_token = $1', [token]).field_names_as(:symbol)
    tests = []
    rows.each do |row|
      tests << MedicalTest.new(row, conn)
    end

    if rows.ntuples > 0
      {
        result_token: tests[0].result_token,
        result_date: tests[0].result_date,
        cpf: tests[0].cpf,
        name: tests[0].name,
        email: tests[0].email,
        birthdate: tests[0].birthdate,
        doctor: {
          crm: tests[0].doctor[:crm],
          crm_state: tests[0].doctor[:crm_state],
          name: tests[0].doctor[:name],
        },
        tests: tests.map { |t| { type: t.test_type, limits: t.test_limits, result: t.test_result } }
      }
    end
  end

  def self.all
    conn = PG.connect(host: 'postgres', password: 1234, user: 'postgres')
    rows = conn.exec('SELECT * FROM tests').field_names_as(:symbol)
    tests = []
    rows.each do |row|
      tests << MedicalTest.new(row, conn)
    end

    tests
  end

  def self.from_csv(f)
    conn = PG.connect(host: 'postgres', password: 1234, user: 'postgres')
    rows = CSV.read(f, col_sep: ';', headers: true, header_converters: :symbol)
    rows.each do |row|
      conn.exec_params("INSERT INTO tests (cpf, name, email, birthdate, address, city, state, doctor_crm, doctor_crm_state, doctor_name, doctor_email, result_token, result_date, test_type, test_limits, test_result) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16)", [row[:cpf], row[:nome_paciente], row[:email_paciente], row[:data_nascimento_paciente], row[:endereorua_paciente], row[:cidade_paciente], row[:estado_patiente], row[:crm_mdico], row[:crm_mdico_estado], row[:nome_mdico], row[:email_mdico], row[:token_resultado_exame], row[:data_exame], row[:tipo_exame], row[:limites_tipo_exame], row[:resultado_tipo_exame]])
    end
  end
end
