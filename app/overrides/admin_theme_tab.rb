=begin
Deface::Override.new(
    :name=>%{admin theme tab},
    :original => '6999548b86c700f2cc5d4f9d297c94b3617fd981',
:virtual_path=>%{spree/layouts/admin},
    :insert_bottom =>"[data-hook='admin_tabs'],#admin_tabs[data-hook]",
    :text => '<%=tab :store_theme%>',
)
=end
