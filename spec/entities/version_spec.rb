describe Version do
  it "should not be valid when name is nil" do
    expect(Version.new(name: nil, number: '1.2.3').valid?).to eq(false)
  end

  it "should not be valid when number is nil" do
    expect(Version.new(name: 'whatever', number: nil).valid?).to eq(false)
  end
end
