
Deface::Override.new(:virtual_path => %q{spree/shared/_products},
                     :name => %{add_div_span_class_thumbnails_to_product_listings},
                     :replace => %q{[data-hook='products_list_item']},
                     :text => %{<li id="product_<%= product.id %>"  class="thumbnails product-list-item span2 " data-hook="products_list_item" itemscope itemtype="http://schema.org/Product">

  <%= link_to large_image(product, :itemprop => "image"), product, :itemprop => 'url' %>

  <%= link_to truncate(product.name, :length => 50), product, :itemprop => "name", :title => product.name %>
  <span class="price selling" itemprop="price">
    <%= product.price_in(current_currency).display_price %>
  </span></li>})

Deface::Override.new(:virtual_path => %q{spree/shared/_products},
                     :name => %{add_class_span_to_pagination},
                     :surround => %q{code[erb-loud]:contains(paginate)},
                     :disabled => false,
                     :text=>%{<span class='span12'><%=render_original%></span>})
