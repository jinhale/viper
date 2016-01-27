# cov.rb - method cov - load results for given pathname into buffer from JSON loaded via load_cov

class CoverageJSONNotLoaded < RuntimeError
end

class FileNotReportedInCoverage < RuntimeError
    def initialize  fname
    super "File #{fname} was not checked for coverage"
  end

end

def cov buffer, pathname
  raise CoverageJSONNotLoaded  if Viper::Session[:coverage].nil?
  # expand_path of pathname
  expanded = File.expand_path(pathname)
  report = Viper::Session[:coverage]['files'].select {|e| e['filename'] == expanded }
  raise FileNotReportedInCoverage.new(expanded) if report.empty?

  # storage[expanded] into buffer
  report[0]['coverage'].each_with_index do |e, n|
    buffer.ins "line #{n + 1}: hits: #{e}\n" unless e.nil?
  end
end

