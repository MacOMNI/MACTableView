#
# Be sure to run `pod lib lint MACTableView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = “MACTableView”
  s.version          = “1.0.0”
  s.summary          = "The blank of UITableView supports empty text、empty picture、pull up & down events"
  s.homepage         = "https://github.com/azheng51714/MACTableView"
  s.license          = 'MIT'
  s.author           = { “MacKun” => “414294494@qq.com” }
  s.source           = { :git => "https://github.com/azheng51714/MACTableView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/MaximeEpain'

  s.platform     = :ios, ‘6.0’
  s.requires_arc = true

  s.source_files = ‘MACTableView/*.{m,h}’
  s.public_header_files = ["MACTableView/*.h"]
  s.dependency 'MJRefresh', '~> 3.1.0'
  s.dependency 'DZNEmptyDataSet', '~> 1.7.2'
  
end
