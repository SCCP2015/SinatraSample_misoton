require_relative '../src/database'

module Test
  RSpec.describe Database do
    it 'add test' do
      File.write('./data', "")
      Database.instance.addData("test")
      now = File.read('./data')
      expect(now).to eq "test\n"
    end

    it 'read test' do
      File.write('./data', "test")
      expect(Database.instance.readData()).to eq "test\n"
    end

    it 'clean test' do
      Database.instance.cleanData()
      expect(File.read('./data')).to eq ""
    end
  end
end
