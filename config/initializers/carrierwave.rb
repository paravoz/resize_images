Dir["#{Rails.root}/app/uploaders/*.rb"].each { |file| require file }

if defined?(CarrierWave)
  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?

    klass.class_eval do
      def cache_dir
        Rails.root.join('spec', 'support', 'uploads', 'cache')
      end

      def store_dir
        Rails.root.join('spec', 'support', 'uploads')
      end
    end
  end
end
