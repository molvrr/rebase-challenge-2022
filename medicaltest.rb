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

  def self.all
    conn = PG.connect(host: 'postgres', password: 1234, user: 'postgres')
    rows = conn.exec('SELECT * FROM tests').field_names_as(:symbol)
    tests = []
    rows.each do |row|
      tests << MedicalTest.new(row, conn)
    end

    tests
  end
end
