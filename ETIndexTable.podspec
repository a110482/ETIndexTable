Pod::Spec.new do |spec|
  spec.name         = 'ETIndexTable'
  spec.version      = '0.1.0'
  spec.authors      = {
    'Andrey Krotov' => 'a80792@gmail.com',
    'Another Andrey Krotov' => 'a80792@gmail.com'
  }
  spec.license      = {
    :type => 'MIT',
    :file => 'LICENSE'
  }
  spec.homepage     = 'https://github.com/a110482/ETIndexTable'
  spec.source       = {
    :git => 'https://github.com/a110482/ETIndexTable.git',
    :branch => 'master',
    :tag => 'v' + spec.version.to_s
  }
  spec.summary      = 'make index for tableview'
  spec.source_files = '**/*.swift', '*.swift'
  spec.swift_versions = '5.0'
  spec.ios.deployment_target = '13.0'
end
