module Blueimp
  module FileUpload
    module File
      extend ActiveSupport::Concern
      BLUEIMP_PARAMS = [:name, :size, :url, :thumbnail_url, :delete_url, :delete_type]

      def as_json(options = {})
        {}.tap do |json|
          BLUEIMP_PARAMS.each do |param|
            raise "Blueimp::FileUpload::File requires a method '#{param}'" if !respond_to?(param)
            json[param] = send param
          end
        end
      end

      module ClassMethods
        def from_params(params)
          { :files => from_param(params[:files]) }
        end

        def from_param(param)
          param = [param] unless param.kind_of?(Array)

          [].tap do |list|
            param.each do |p|
              list << new.tap do |file|
                file.name = p.original_filename
                file.contents = p.read
              end
            end
          end
        end
      end
    end
  end
end
