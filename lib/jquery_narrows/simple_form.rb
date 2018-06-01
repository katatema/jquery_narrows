require 'simple_form'
module JqueryNarrows
  class NarrowsSelectInput < ::SimpleForm::Inputs::CollectionInput
    def input(wrapper_options = nil)
      label_method, value_method = detect_collection_methods

      merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

      if merged_input_options[:id].blank?
        merged_input_options[:id] = collection.first.class.to_s.underscore.gsub(/_/, "-")
      end

      parent = input_options[:parent]
      if parent.present?
        @builder.select(
          attribute_name, collection.map{ |c|
            [
              c.send(label_method), c.send(value_method),
              {data: {"#{parent.to_s}": "#{c.parent_id}"}}
            ]},
          input_options, merged_input_options
        )
      else
        @builder.collection_select(
          attribute_name, collection, value_method, label_method,
          input_options, merged_input_options
        )
      end
    end
  end

  SimpleForm::FormBuilder.class_eval do
    map_type :narrows_select, :to => JqueryNarrows::NarrowsSelectInput
  end
end
