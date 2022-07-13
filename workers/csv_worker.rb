class CSVJob
  include Sidekiq::Job

  def perform(path)
    file = open(path, 'r')
    MedicalTest.from_csv(file)
    File.delete(path)
  end
end
