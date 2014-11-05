require './spec/spec_helper'
require './entities/package_list_filter'

describe PackageListFilter do
  let(:package_list) do
    [{ name: 'x', number: '1' },
     { name: 'y', number: '2' },
     { name: 'z', number: '3' },
     { name: 'w', number: '4' }]
  end
  let(:filter) { described_class.new(package_list) }

  describe "#remove_existing_versions" do
    it "should return the same list when there's nothing in the database" do
      expect(filter.remove_existing_versions).to eq(package_list)
    end

    it "should return the list minus the existing versions when they are already in the database" do
      Version.create(name: 'x', number: '1')
      Version.create(name: 'y', number: '2')
      expect(filter.remove_existing_versions).to eq([{ name: 'z', number: '3' },
                                                     { name: 'w', number: '4' }])
    end
  end
end
