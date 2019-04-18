require 'json'
package = JSON.parse(File.read('../package.json'))

Pod::Spec.new do |s|
  s.name                = "RNBuglife"
  s.version             = package["version"]
  s.summary             = package["description"]
  s.description         = <<-DESC
                            A well tested feature rich Buglife implementation for React Native, supporting iOS & Android.
                          DESC
  s.homepage            = "https://github.com/Buglife/react-native-buglife"
  s.license             = package['license']
  s.authors             = "Invertase Limited"
  s.source              = { :git => "https://github.com/Buglife/react-native-buglife.git", :tag => "v#{s.version}" }
  s.platform            = :ios, "9.0"
  s.source_files        = '*.{h,m}'
  s.dependency          'React'
  s.dependency          'Buglife'
end
