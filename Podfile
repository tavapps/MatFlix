# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

def rx_pods
  pod 'RxSwift',    '~> 4.0'
  pod 'RxCocoa',    '~> 4.0'
end

target 'MatFlix' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for MatFlix
  rx_pods
  pod 'Kingfisher', '~> 4.0'

  target 'MatFlixTests' do
    inherit! :search_paths
    # Pods for testing

  end

end
