describe Fastlane::Actions::SwiftlintCodequalityAction do
  let(:fixtures_path) { File.expand_path("./spec/fixtures") }

  describe '#run' do
    it 'generates empty output if input is also empty' do
      path = fixtures_path + "/empty.txt"
      output = fixtures_path + "/empty.result.json"

      expect(Fastlane::UI).to receive(:message).with("Parsing SwiftLint report at #{path}")
      expect(Fastlane::UI).to receive(:success).with("🚀 Generated Code Quality report at #{output} 🚀")

      Fastlane::Actions::SwiftlintCodequalityAction.run(path: path, output: output, prefix: '')

      result = File.read(output)
      expect(result).to eq("[]")
    end

    it 'generates an output if input is non empty' do
      path = fixtures_path + "/single.txt"
      output = fixtures_path + "/single.result.json"

      expect(Fastlane::UI).to receive(:message).with("Parsing SwiftLint report at #{path}")
      expect(Fastlane::UI).to receive(:success).with("🚀 Generated Code Quality report at #{output} 🚀")

      command = "pwd"
      command_result = "/Users/apple/projects"
      allow(Fastlane::Actions).to receive(:sh).with(command, log: false).and_return(command_result)

      Fastlane::Actions::SwiftlintCodequalityAction.run(path: path, output: output, prefix: '')

      result = File.read(output)
      expect(result).to eq(%q{[{"type":"issue","check_name":"Identifier Name Violation","description":"Variable name should be between 3 and 40 characters long: 'p'","fingerprint":"684722650e18611b41939c985095d204","severity":"critical","location":{"path":"/Project/File.swift","lines":{"begin":20,"end":20}}}]})
    end

    it 'outputs as many code climate objects as there are swiftlint issues' do
      path = fixtures_path + "/multiple.txt"
      output = fixtures_path + "/multiple.result.json"

      expect(Fastlane::UI).to receive(:message).with("Parsing SwiftLint report at #{path}")
      expect(Fastlane::UI).to receive(:success).with("🚀 Generated Code Quality report at #{output} 🚀")

      command = "pwd"
      command_result = "/Users/apple/projects"
      allow(Fastlane::Actions).to receive(:sh).with(command, log: false).and_return(command_result)

      Fastlane::Actions::SwiftlintCodequalityAction.run(path: path, output: output, prefix: '')

      input = File.foreach(path).count
      result = JSON.parse(File.read(output)).length
      expect(result).to eq(input)
    end
  end
end
