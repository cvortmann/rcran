require './spec/spec_helper'
require './entities/version_saver'

describe VersionSaver do
  let(:saver) { described_class.new(list_of_packages) }

  describe "#save" do
    context "when list has only one version" do
      let(:list_of_packages) { [{ "Package" => "foo", "Version" => "1.0" }] }

      context "when the package does not exist yet" do
        it "saves one version" do
          saver.save

          version = Version.first
          expect(version.name).to eq("foo")
          expect(version.number).to eq("1.0")
        end
      end

      context "when the version already exists" do
        before do
          Version.create(name: "foo", number: "1.0")
        end

        it "uses the same version" do
          saver.save

          expect(Version.count).to eq(1)
        end
      end
    end

    context "when list has more than one version" do
      let(:list_of_packages) do
        [
          { "Package" => "foo", "Version" => "1.0" },
          { "Package" => "bar", "Version" => "2.0" }
        ]
      end

      it "saves one version per entry" do
        saver.save

        versions = Version.all
        expect(versions[0].name).to   eq("foo")
        expect(versions[0].number).to eq("1.0")
        expect(versions[1].name).to   eq("bar")
        expect(versions[1].number).to eq("2.0")
      end
    end
  end
end
