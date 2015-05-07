# coding: utf-8
require 'spec_helper'

describe Database.instance do
  describe '#addData' do
    before do
      File.delete('data') if File.exist?('data')
    end
    it 'return hoge String' do
      expect(Database.instance.addData('hoge')).to eq "hoge\n"
      expect(Database.instance.readData()).to eq "hoge\n"
    end
    context 'In the case of write multiple lines' do
      it 'write a word to next line' do
        expect(Database.instance.addData('hoge')).to eq "hoge\n"
        expect(Database.instance.readData).to eq "hoge\n"
        expect(Database.instance.addData('foo')).to eq "hoge\nfoo\n"
        expect(Database.instance.readData).to eq "hoge\nfoo\n"
      end
    end
  end

  describe '#readData' do
    before do
      File.delete('data') if File.exist?('data')
    end
    context 'In the case of write multiple lines' do
      it 'return an empty String' do
        expect(Database.instance.readData()).to eq ''
      end
    end
    after do
      File.delete('data') if File.exist?('data')
    end
  end

  describe '#cleanData' do
    it 'rewrite a word' do
      File.delete('data') if File.exist?('data')
      expect(Database.instance.cleanData()).to eq ''
      expect(Database.instance.readData()).to eq ''
      Database.instance.addData('foo')
      Database.instance.addData('bar')
      expect(Database.instance.cleanData()).to eq ''
      expect(Database.instance.readData()).to eq ''
    end
  end
end

