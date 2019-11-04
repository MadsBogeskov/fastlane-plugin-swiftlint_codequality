describe Fastlane::Actions::SwiftlintCodequalityAction do
  let(:fixtures_path) { File.expand_path("./spec/fixtures") }

  describe '#run' do
    it 'generates empty output if input is also empty' do
      path = fixtures_path + "/empty.json"
      output = fixtures_path + "/empty.result.json"

      expect(Fastlane::UI).to receive(:message).with("Parsing SwiftLint report at #{path}")
      expect(Fastlane::UI).to receive(:success).with("🚀 Generated Code Quality report at #{output} 🚀")

      Fastlane::Actions::SwiftlintCodequalityAction.run(path: path, output: output)

      result = File.read(output)
      expect(result).to eq("[]")
    end
  end
end
