
Pod::Spec.new do |spec|
  spec.name         = 'bench_ios'
  spec.version      = '2.1.4'
  spec.license      = { :type => 'BSD' }
  spec.homepage     = 'https://github.com/gwh111/bench_ios'
  spec.authors      = { 'apple' => '173695508@qq.com' }
  spec.summary      = 'IOS bench tool for developer'
  spec.source       = { :git => 'https://github.com/gwh111/bench_ios.git', :tag => 'v2.1.4' }
  spec.frameworks   = 'UIKit'  
  spec.module_name  = 'ccs'

  spec.ios.deployment_target  = '7.0'

  spec.source_files       = 'bench_ios/bench/**/*'
  spec.resources          = 'bench_ios/bench_ios.bundle'

end
