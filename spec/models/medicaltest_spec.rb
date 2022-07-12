require 'rspec'
require './medicaltest'

describe MedicalTest do
  context '#all' do
    it 'retorna todos exames cadastrados' do
      data = MedicalTest.all

      expect(data.length).to eq(3900)
    end
  end
end
