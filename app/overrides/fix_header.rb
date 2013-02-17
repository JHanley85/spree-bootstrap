Deface::Override.new(:virtual_path => %q{spree/shared/_nav_bar},
                     :name => "left_logo",
                     :disabled => false,
                     :add_to_attributes => %q{ul[id='nav-bar']},
                     :attributes =>{:class =>'nav pull-right'})
Deface::Override.new(:virtual_path => %{spree/shared/search},
                     :name => "fix-button",
                     :replace => "code[erb-loud]:contains('submit_tag')",
                     :text=>%{here},)




