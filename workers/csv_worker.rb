class CSVJob
  include Sidekiq::Job

  def perform(name, path)
    file = open(path, 'r')
    MedicalTest.from_csv(file)
  end
end
