Deface::Override.new(
    :name=>%{admin theme tab},
    :virtual_path=>%{spree/layouts/admin},
    :insert_bottom =>"[data-hook='admin_tabs'],#admin_tabs[data-hook]",
    :text => '<%=tab :store_theme%>',
)