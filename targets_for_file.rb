#!/usr/bin/env ruby

require 'xcodeproj'
project_path = ARGV[0] # './Badoo.xcodeproj'
file_to_search = ARGV[1] # "BMADebugFakeLocationController.m"
project = Xcodeproj::Project.open(project_path)
verbose = false
containing_targets_names = []
containing_targets_booleans = []

project.targets.each do |target|
	if verbose
		puts "Checking #{target} ... "
	end

	if file_to_search.end_with?(".m", ".mm", ".swift") 
		files_to_lookup = target.source_build_phase.files
	elsif file_to_search.end_with?(".xcassets", ".xib", ".png") 
		files_to_lookup = target.resources_build_phase.files
	else 
		return
	end

	files = files_to_lookup.to_a.map do |pbx_build_file|
		pbx_build_file.file_ref.real_path.to_s
	end.select do |path| 
	  path.end_with?(file_to_search)
	end.select do |path|
	  File.exists?(path)
	end

	# puts files

	if files.length > 1 
		puts "WARNING: Ambigous name, with many usages: #{files}"
	elsif files.length == 1 
		containing_targets_booleans.push(1)
		containing_targets_names.push(target.name)
	else 
		containing_targets_booleans.push(0)
	end 
end

if verbose
	puts "======"
end

if verbose 
	if containing_targets_names.length > 0
		puts "File found in #{containing_targets_names.length} targets:"
		puts containing_targets_names
	else
		puts "File is not added to any target"
	end
end

puts containing_targets_booleans.join("")
