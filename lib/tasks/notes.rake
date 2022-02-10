namespace :notes do
    Rails.logger = Logger.new(STDOUT)
    Rails.logger.level = Logger::INFO
    fixture_dir = "#{Rails.root}/db/fixtures/#{Rails.env}"
    desc 'ymlからnotesテーブルを洗い替える'
    task :replace, ['yaml_name'] => :environment do |task, args|
        Rails.logger.info 'notes:replace - start.'
        Note.delete_all
        YAML.load_file("#{fixture_dir}/#{args[:yaml_name]}").each do |item|
        Note.create!(item)
        Rails.logger.info "notes added:\t#{item['id']}"
      end
      Rails.logger.info 'notes:replace - end.'
    end
  end