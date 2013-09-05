require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'

PuppetLint.configuration.ignore_paths =
  ["modules/stdlib/**/*.pp",
   "modules/concat/**/*.pp",
   "modules/firewall/**/*.pp"]

desc "Generate documentation."
task :doc do |t|
  puts "Generating puppet documentation..."
  work_dir = File.dirname(__FILE__)
  sh %{puppet doc \
--outputdir #{work_dir}/doc \
--mode rdoc \
--manifestdir #{work_dir}/manifests \
--modulepath #{work_dir}/modules \
--manifest #{work_dir}/manifests/site.pp}

  if File.exists? "#{work_dir}/doc/files/#{work_dir}/modules"
    FileUtils.mv "#{work_dir}/doc/files/#{work_dir}", "#{work_dir}/doc/files"
  end
  Dir.glob('./**/*.*').each do |file|
    if File.file? "#{file}"
      sh %{sed -i "s@#{work_dir}/@/@g" "#{file}"}
    end
  end
end
