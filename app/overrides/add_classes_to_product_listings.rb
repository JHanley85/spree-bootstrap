@per_row=6
@span='span'+(12 / @per_row).floor.to_s

Deface::Override.new(:virtual_path => %q{spree/shared/products},
                     :name => %{add_class_thumbnails_to_index-listings},
                     :set_attributes => %q{ul#products},
                     :disabled => false,
                     :attributes => {:class => 'product-listing thumbnails'})
Deface::Override.new(:virtual_path => %q{spree/shared/products},
                     :name => %{add_class_thumbnails_to_index-listings},
                     :replace => %q{ul#products},
:text=>%{<ul id="products" class="inline product-listing" data-hook>
<div class='row-fluid'>
<% products.each_with_index do |product,i| %>
  <% if (i % 6==0)%></div><div class='row-fluid'><%end%>
    <% if product.on_display? %>
<li id="product_<%= product.id %>" class="columns three <%= cycle("alpha", "secondary", "", "omega secondary", :name => "classes") %>" data-hook="products_list_item" itemscope itemtype="http://schema.org/Product">
<div class="product-image">
<%= link_to small_image(product, :itemprop => "image"), product, :itemprop => 'url' %>
    </div>
       <div class='row-fluid'>
        <%= link_to truncate(product.name, :length => 50), product, :class => 'info span12', :itemprop => "name", :title => product.name %>
        <span class="price selling span12" itemprop="price"><%= product.price_in(current_currency).display_price %></span>
    </div>
</li>
    <% end %>
  <% end %>
</div>
  <% reset_cycle("classes") %>
</ul>},)
Deface::Override.new(:virtual_path => %q{spree/shared/_products},
                     :name => %{add_div_span_class_thumbnails_to_product_listings},
                     :replace => %q{[data-hook='products_list_item']},
                     :text => %{<li class='span2'><div id="product_<%= product.id %>" class="span2" <%= cycle("alpha", "secondary", "", "omega secondary", :name => "classes") %>" data-hook="products_list_item" itemscope itemtype="http://schema.org/Product"> <div class="product-image thumbnail"><%= link_to small_image(product, :itemprop => "image"), product, :itemprop => 'url' %><%= link_to truncate(product.name, :length => 50), product, :class => 'caption', :itemprop => "name", :title => product.name %><span class="price selling" itemprop="price"><%= product.price_in(current_currency).display_price %></span></div></div></li>})

Deface::Override.new(:virtual_path => %q{spree/shared/_products},
                     :name => %{add_class_thumbnails_to_product_listings},
                     :set_attributes => %q{[data-hook='products_list_item']},
                     :disabled => false,
                     :attributes => {:class => 'products-list-item'})
#Deface::Override.new(:virtual_path => %q{spree/shared/_nav_bar},
#                     :name => "left_logo",
#                     :disabled => false,
#                     :add_to_attributes => %q{ul[id='nav-bar']},
#                     :attributes =>{:class =>'nav pull-right'})
Deface::Override.new(:virtual_path => %q{spree/shared/_main_nav_bar},
                     :name=>'add_navigation',
                     :insert_after=>%{nav},
                     :text=>%{<ul class="nav nav-pills nav-stacked">
  <% get_taxonomies.each do |taxonomy| %>
      <li class='dropdown'>
        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
          <%= t(:shop_by_taxonomy, :taxonomy => taxonomy.name) %>
          <b class="caret"></b>
        </a>
        <%= taxons_tree_bs(taxonomy.root, @taxon, Spree::Config[:max_level_in_taxons_menu] || 1) %>

      </li>

  <% end %>
  </ul>})